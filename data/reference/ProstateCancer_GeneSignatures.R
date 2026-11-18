
immune_sigs <- list(

    ## --- Interferon / T-cell inflamed ---
    IFNG_6gene_Ayers       = c("IDO1","CXCL10","CXCL9","HLA-DRA","STAT1","IFNG"),
    IFNG_expanded_Ayers    = c("CD3D","IDO1","CIITA","CD3E","CCL5","GZMK","CD2","HLA-DRA",
                               "CXCL13","IL2RG","NKG7","HLA-E","CXCR6","LAG3","TAGAP",
                               "CXCL10","STAT1","GZMB"),
    Tcell_inflamed_GEP     = c("CCL5","CD27","CD274","CD276","CD8A","CMKLR1","CXCL9",
                               "CXCR6","HLA-DQA1","HLA-DRB1","HLA-E","IDO1","LAG3",
                               "NKG7","PDCD1LG2","PSMB10","STAT1","TIGIT"),
    IFN_I                  = c("IFI6","IFI27","IFI44","IFI44L","IFIT1","IFIT3","ISG15",
                               "MX1","MX2","OAS1","OAS2","OAS3","RSAD2","IFITM3","STAT2","IRF7"),

    ## --- Effector / cytotoxic ---
    Cytolytic_activity     = c("GZMA","PRF1"),
    Cytotoxic_effector     = c("GZMA","GZMB","GZMH","GZMK","PRF1","NKG7","GNLY","KLRD1","FASLG"),
    CD8_effector           = c("CD8A","CD8B","GZMA","GZMB","IFNG","EOMES","PRF1","CXCL9","CXCL10","TBX21"),

    ## --- Exhaustion / dysfunction ---
    T_exhaustion           = c("PDCD1","CTLA4","LAG3","HAVCR2","TIGIT","TOX","ENTPD1",
                               "BTLA","CD244","EOMES","CD160","VSIR"),
    T_exhaustion_terminal  = c("TOX","TOX2","CXCL13","LAYN","ENTPD1","HAVCR2","GZMB","ITGAE"),
    Tcell_stemness_TCF7    = c("TCF7","SELL","CCR7","LEF1","IL7R","BACH2","SLAMF6"),

    ## --- Checkpoints / antigen presentation ---
    Immune_checkpoints     = c("CD274","PDCD1LG2","CTLA4","PDCD1","LAG3","HAVCR2",
                               "TIGIT","IDO1","VSIR","BTLA","CD276","VTCN1"),
    MHC_I                  = c("HLA-A","HLA-B","HLA-C","B2M","TAP1","TAP2","TAPBP","PSMB8","PSMB9","NLRC5"),
    MHC_II                 = c("HLA-DRA","HLA-DRB1","HLA-DQA1","HLA-DQB1","HLA-DPA1",
                               "HLA-DPB1","CD74","CIITA"),

    ## --- Suppressive / resistance programmes ---
    Treg                   = c("FOXP3","IL2RA","IKZF2","CTLA4","TNFRSF4","TNFRSF18","CCR8","LAYN"),
    TGFb_response_FTBRS    = c("TGFB1","TGFBR2","SMAD2","SMAD3","SERPINE1","COL1A1",
                               "COL4A1","ACTA2","TAGLN","FN1"),
    MDSC_like              = c("S100A8","S100A9","S100A12","CD33","ITGAM","ARG1","IL4R","CXCR2","FCGR3B"),
    M2_macrophage          = c("CD163","MRC1","MSR1","CD68","MERTK","IL10","STAB1","F13A1"),
    M1_macrophage          = c("CD80","CD86","NOS2","IL1B","TNF","IL12B","CXCL9","CXCL10","SOCS3"),
    Neutrophil             = c("FCGR3B","CSF3R","CXCR2","S100A8","S100A9","ELANE","MPO","LCN2"),

    ## --- Structural / spatial ---
    TLS_12_chemokine       = c("CCL2","CCL3","CCL4","CCL5","CCL8","CCL18","CCL19","CCL21",
                               "CXCL9","CXCL10","CXCL11","CXCL13"),
    B_cell                 = c("CD19","MS4A1","CD79A","CD79B","BANK1","TNFRSF13C","PAX5"),
    Plasma_cell            = c("MZB1","JCHAIN","XBP1","PRDM1","DERL3","TNFRSF17"),
    NK_cell                = c("NCAM1","KLRD1","KLRF1","NCR1","NCR3","KIR2DL3","FGFBP2","SPON2"),

    ## --- Proliferation / metabolic ---
    Proliferation          = c("MKI67","TOP2A","CCNB1","CDK1","PCNA","BIRC5","TYMS","RRM2"),
    Glycolysis_core        = c("HK2","PFKFB3","PKM","LDHA","SLC2A1","ENO1","GAPDH","ALDOA"),
    OXPHOS_core            = c("NDUFA1","NDUFB3","SDHB","UQCRC1","COX5A","COX7B","ATP5F1A","ATP5F1B"),
    Polyol_pathway         = c("AKR1B1","SORD","KHK","ALDOB","SLC2A5"),

    ## --- AR axis (relevant if any prostate epithelial carryover is suspected) ---
    AR_signalling          = c("KLK3","KLK2","NKX3-1","TMPRSS2","FKBP5","STEAP4","PMEPA1","SORD")
)
