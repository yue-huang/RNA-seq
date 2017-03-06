#3. edgeR design matrix
# design <- model.matrix(~group,data=y$samples)
design <- model.matrix(~0+group,data=y$samples)
design
y <- estimateDisp(y,design,robust=TRUE)
y$common.dispersion #0.046
plotBCV(y)
