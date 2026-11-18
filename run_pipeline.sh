#!/usr/bin/env bash
# =============================================================================
# PRINCE spatial transcriptomics: run the full analysis.
#
#   ./run_pipeline.sh                 extract code from every R Markdown file, run all default steps in order,
#                                     then assemble the final figures and supplementary files
#   ./run_pipeline.sh --from STEP     start at STEP (step ids are listed in steps.tsv)
#   ./run_pipeline.sh --only STEP     run a single step
#   ./run_pipeline.sh --render STEP   knit one step's R Markdown to an HTML report in reports/
#   ./run_pipeline.sh --legacy        run the earlier all-site analysis scripts (optional)
#   ./run_pipeline.sh --purl          only extract the code into .build/
#
# Environment: PRINCE_MAX_WORKERS (parallel workers, default 4).
# Logs: results/logs/<step>.log; one START/END line per step in results/logs/_pipeline.log.
# =============================================================================
set -u
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PRINCE_ROOT="$ROOT"
cd "$ROOT"
LOG="$ROOT/results/logs"; mkdir -p "$LOG" "$ROOT/.build" "$ROOT/reports"

purl_all() {
  Rscript -e '
    files <- list.files("analysis", pattern = "[.]Rmd$", recursive = TRUE, full.names = TRUE)
    for (f in files) knitr::purl(f, output = file.path(".build", sub("[.]Rmd$", ".R", basename(f))),
                                 documentation = 0, quiet = TRUE)
    cat("extracted", length(files), "scripts into .build/\n")'
}

rmd_of() { find analysis -name "$1.Rmd" | head -1; }

run_step() {  # step script mode
  local st=$1 sc=$2 mode=$3 rc t0
  t0=$(date +%s); echo "[$(date '+%F %T')] START $st" >> "$LOG/_pipeline.log"
  case $mode in
    run|optional|legacy) Rscript ".build/$sc.R" > "$LOG/$st.log" 2>&1 < /dev/null ;;
    env:*)     env ${mode#env:} Rscript ".build/$sc.R" > "$LOG/$st.log" 2>&1 < /dev/null ;;
    args:*)    Rscript ".build/$sc.R" ${mode#args:} > "$LOG/$st.log" 2>&1 < /dev/null ;;
    notitle:*) Rscript .build/comp_44_run_notitle.R ".build/$sc.R" "${mode#notitle:}" > "$LOG/$st.log" 2>&1 < /dev/null ;;
    *) echo "unknown mode $mode"; return 1 ;;
  esac
  rc=$?
  echo "[$(date '+%F %T')] END $st rc=$rc ($(( $(date +%s) - t0 ))s)" >> "$LOG/_pipeline.log"
  if [ $rc -ne 0 ]; then echo "Step $st failed (rc=$rc); see $LOG/$st.log"; exit $rc; fi
  echo "done: $st"
}

FROM=""; ONLY=""; LEGACY=0
case "${1:-}" in
  --from)   FROM=$2 ;;
  --only)   ONLY=$2 ;;
  --legacy) LEGACY=1 ;;
  --purl)   purl_all; exit 0 ;;
  --render)
    purl_all; f=$(awk -F'\t' -v s="$2" '$1==s{print $3}' steps.tsv)
    Rscript -e "rmarkdown::render('$(rmd_of "$f")', output_dir = 'reports', knit_root_dir = NULL)"; exit $? ;;
  "") ;;
  *) sed -n '2,15p' "$0"; exit 1 ;;
esac

purl_all || exit 1
go=0; [ -z "$FROM" ] && go=1
while IFS=$'\t' read -r st folder sc mode note; do
  case "$st" in \#*|"") continue ;; esac
  if [ -n "$ONLY" ]; then [ "$st" == "$ONLY" ] && run_step "$st" "$sc" "$mode"; continue; fi
  if [ $LEGACY == 1 ]; then [ "$mode" == "legacy" ] && run_step "$st" "$sc" "$mode"; continue; fi
  [ "$st" == "$FROM" ] && go=1; [ $go == 0 ] && continue
  case $mode in helper|legacy|optional) continue ;; esac
  run_step "$st" "$sc" "$mode"
done < steps.tsv

if [ -z "$ONLY" ] && [ $LEGACY == 0 ]; then
  bash tools/assemble_figures_and_tables.sh && echo "[$(date '+%F %T')] PIPELINE DONE" >> "$LOG/_pipeline.log"
fi
