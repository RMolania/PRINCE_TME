#!/usr/bin/env bash
# =============================================================================
# Assemble the final figure set and supplementary files from results/,
# then build the combined PDF of figures with their legends.
#
# Figure scripts were developed in successive versions (results folders Figures_v1 ... Figures_v5), and the final
# numbering re-uses panels from several of them. Five scripts are re-rendered without plot titles
# (comp_44_run_notitle); the final figures are then copied under their final numbers.
# Run by run_pipeline.sh after the last analysis step; can also be run on its own.
# =============================================================================
set -eu
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; export PRINCE_ROOT="$ROOT"; cd "$ROOT"
R=results; N=$R/notitle; M=$R/Figures_v5; F=figures_and_tables/figures; S=figures_and_tables/supplementary
mkdir -p "$N" "$F" "$S"

# title-free renders of the earlier figure scripts whose panels appear in the final figure set
for s in comp_21_figures_v3 comp_24_ed_standR comp_11_extended_figures comp_14_revised_figures comp_39_supp_fig6; do
  n=$(echo $s | cut -d_ -f2)
  Rscript .build/comp_44_run_notitle.R ".build/$s.R" "$N/$n" > "$R/logs/notitle_$n.log" 2>&1 < /dev/null
done

cp_() { for e in png pdf; do cp "$1.$e" "$F/$2.$e"; done; }
# main figures
for i in 1 2 3 4 5 6; do cp_ $M/Figure$i Figure$i; done
# Extended Data figures
cp_ $M/ExtendedDataFig1        ExtendedDataFig1
cp_ $N/21/ExtendedDataFig2     ExtendedDataFig2
cp_ $M/v4/ExtendedDataFig4     ExtendedDataFig3
cp_ $M/v4/ExtendedDataFig9     ExtendedDataFig4
cp_ $M/ExtendedDataFig3        ExtendedDataFig5
cp_ $M/v4/ExtendedDataFig8     ExtendedDataFig6
cp_ $M/v4/ExtendedDataFig10    ExtendedDataFig7
cp_ $M/v4/ExtendedDataFig5     ExtendedDataFig8
cp_ $M/v4/ExtendedDataFig6     ExtendedDataFig9
cp_ $N/24/ExtendedDataFig5     ExtendedDataFig10
# Supplementary figures
cp_ $N/39/SupplementaryFig6    SupplementaryFig1
cp_ $N/11/ExtendedDataFig8     SupplementaryFig2
cp_ $N/11/ExtendedDataFig10    SupplementaryFig3
cp_ $N/11/ExtendedDataFig7     SupplementaryFig4
cp_ $N/11/ExtendedDataFig1     SupplementaryFig5
cp_ $N/14/ExtendedDataFig9     SupplementaryFig6
echo "figures assembled in $F"

# supplementary tables and data
cp $M/Supplementary_Tables_v5.xlsx $S/Supplementary_Tables_v6.xlsx
cp $M/Supplementary_Data_*.csv $S/
echo "supplementary files copied to $S"

# combined PDF of all figures, each followed by its legend (legends: figures_and_tables/figure_legends.md; needs reportlab)
python3 tools/make_figures_pdf.py figures_and_tables/figure_legends.md figures_and_tables/PRINCE_figures_with_legends.pdf \
  || echo "combined figure PDF skipped (needs the python package reportlab)"
