# Input data

All analyses read their inputs from this folder (`PRINCE_DIR` in the code). `reference/` is `PMCC_DIR`.
Patient-level and unpublished trial data are **not** tracked by git (see `.gitignore`). They must be placed here
before running the pipeline. MD5 checksums of the exact files used for the manuscript are listed below.

| File | Content | Source | In git |
|---|---|---|---|
| `raw/PRINCE_GeoMx_SE_RawCount_SampleAnnot_Filtered.qs` | GeoMx WTA raw counts and AOI annotation (SummarizedExperiment, all sites) | PRINCE GeoMx DSP data | no |
| `raw/Prince_countdata_with_ncg.cvs` | Counts including negative-control probes (used for LOQ and QC) | PRINCE GeoMx DSP data | no |
| `raw/PRINCE_translational_data_DECRYPTED.xlsx` | Clinical outcomes, PSMA-PET and ctDNA per patient | PRINCE trial | no |
| `metadata/PRINCE_DSP Tissue Annotation_02122024_CLWSv2.xlsx` | Documented tissue site of every biopsy (defines the bone-only cohort) | PRINCE pathology | no |
| `reference/PRINCE DSP ROI SUMMARY_RAMYAR_DATA ANALYSIS 21052026.xlsx` | ROI/AOI surface area and nuclei counts | PRINCE GeoMx DSP data | no |
| `reference/msigdb_gene_sets.rds` | MSigDB collections (H, C2, ...) as named lists | MSigDB | no |
| `reference/ProstateCancer_GeneSignatures.R` | Literature prostate-cancer and immune gene signatures | compiled from literature | yes |
| `reference/celltype_markers_AllLevels.xlsx` | Cell-type marker genes at several annotation levels | compiled from literature | no |
| `reference/GSE143791/` | Bone-metastasis scRNA-seq (Kfoury et al. 2021): cell annotation and per-sample counts | GEO GSE143791 (public) | no |
| `refs/pccat_subsample.qs` | Subsample of the PCCAT prostate-cancer scRNA-seq atlas (≤500 cells per group × cell type) | built by `comp_03a_build_refs` from the PCCAT atlas | no (388 MB) |
| `ProstateMarkers/mmc4.xlsx` | STAMPEDE transcriptome signatures (Grist et al., supplementary table) | published supplement | no |
| `previous_analysis/` | Frozen outputs of the earlier all-site AOI-level analysis (RUV-adjusted DE, purity models, NE scores, batch metrics), re-evaluated in Extended Data Fig. 8 | `analysis/legacy_earlier_analysis/` | gene-level tables yes; per-AOI scores (`Phase8_NEPC_Longitudinal/`) no |

Folders written by the pipeline (not tracked):

- `interim/`: all-site QC'd objects from `comp_00a_qc`.
- `phase2_se_qc_filtered.qs`, `phase2_se_with_qc_metrics.qs`, `PRINCE_GeoMx_SE_RawCount_SampleAnnot_Filtered.qs` in this folder: bone-only objects written by `comp_00b_bone_cohort`. Every downstream analysis reads these.

The PCCAT atlas itself (`StepF.PCCAT_scRNAseq_data_0601.26.qs`, 6.6 GB) is needed only to rebuild `refs/pccat_subsample.qs`. To do that, place it in `reference/`.

## Checksums (MD5)

```
0c49280fb2f61b74f546d1fc97a6f8e4  metadata/PRINCE_DSP Tissue Annotation_02122024_CLWSv2.xlsx
2efde75383ffd79ad3a571ec867f6cfe  previous_analysis/Phase3d_PSMA_RootCause/batch_metrics_relative_vs_absolute.csv
827ef66ee975a63af6c193c21a211fd1  previous_analysis/Phase4_DE/CD45__Archival_toptable_with_RUV.csv
9593f0cb3ba1fa803eb58b8c56405c40  previous_analysis/Phase4_DE/CD45__Cycle1_toptable_with_RUV.csv
bd665a7a8caca327186b35764b1a279f  previous_analysis/Phase4_DE/CD45__Screening_toptable_with_RUV.csv
86effc73f06af88bb6706850c16b831d  previous_analysis/Phase4_DE/PanCKPSMA__Archival_toptable_with_RUV.csv
36b3eb9e65bedb7a04b05d3df4136382  previous_analysis/Phase4_DE/PanCKPSMA__Cycle1_toptable_with_RUV.csv
00fa107eb53aed1e67dbaaab3c060cdb  previous_analysis/Phase4_DE/PanCKPSMA__Screening_toptable_with_RUV.csv
cddf8cc8ccecec9a941e84dc3404230d  previous_analysis/Phase4_DE/PSMA__Archival_toptable_with_RUV.csv
af68f439a605779d98570b3fd78ab154  previous_analysis/Phase4_DE/PSMA__Cycle1_toptable_with_RUV.csv
5c0d1b7924524c3f4898257f19537323  previous_analysis/Phase4_DE/PSMA__Screening_toptable_with_RUV.csv
7c7888b2e4d9db59bebf0b682df2f64b  previous_analysis/Phase5_Purity/CD45__Archival_toptable_with_purity.csv
58296d53bbf9fdcb441bfb0d988df88f  previous_analysis/Phase5_Purity/CD45__Cycle1_toptable_with_purity.csv
014718edba738f3e3bb30203de2c5bd2  previous_analysis/Phase5_Purity/CD45__Screening_toptable_with_purity.csv
6495f4742029b127f1396fa77f621e82  previous_analysis/Phase5_Purity/PanCKPSMA__Archival_toptable_with_purity.csv
368f928534f27d01ceebaaf8cfc1259f  previous_analysis/Phase5_Purity/PanCKPSMA__Cycle1_toptable_with_purity.csv
2b93a8f25b7d367ed9ad7f8ac4d753a6  previous_analysis/Phase5_Purity/PanCKPSMA__Screening_toptable_with_purity.csv
f7ed656c2963e358385f741adb8182cf  previous_analysis/Phase5_Purity/PSMA__Archival_toptable_with_purity.csv
807c66f86e351068510660afbe4c0f7f  previous_analysis/Phase5_Purity/PSMA__Cycle1_toptable_with_purity.csv
ac5efeb4df33a016a7b30307593be06a  previous_analysis/Phase5_Purity/PSMA__Screening_toptable_with_purity.csv
2966642f951163c9e258043f2a0e5cbc  previous_analysis/Phase8_NEPC_Longitudinal/all_scores_per_AOI.csv
1f83bde20be342d9541b901b133937d5  ProstateMarkers/mmc4.xlsx
44b802bef6559ec74913ba0294c8a242  raw/Prince_countdata_with_ncg.cvs
89b27cd67879840c69b68616db5157e8  raw/PRINCE_GeoMx_SE_RawCount_SampleAnnot_Filtered.qs
8904a42919df74021363d541ef252581  raw/PRINCE_translational_data_DECRYPTED.xlsx
851d325df51b1df64bb40b0dc4caa5f6  reference/celltype_markers_AllLevels.xlsx
70a4960cbda496493ad8d98762673d23  reference/GSE143791/GSE143791_cell.annotation.human.csv.gz
ee3442fe7696d99219458a1a4dd71a25  reference/msigdb_gene_sets.rds
19f451782d2f39c51c18678fe1941cab  reference/PRINCE DSP ROI SUMMARY_RAMYAR_DATA ANALYSIS 21052026.xlsx
726d58083f9f120db4945d66320e95fb  reference/ProstateCancer_GeneSignatures.R
53ea8179dd8efe97f571cfc73452d4b6  refs/pccat_subsample.qs
```

GSE143791 raw count files (`reference/GSE143791/raw_files/`, 41 files) are the per-sample `*.count.csv.gz` files from the GEO supplementary archive `GSE143791_RAW.tar`.
