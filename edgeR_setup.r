#2. edgeR pipeline setup
library(edgeR)
group <- factor(c(1,1,1,2,2,2))
y <- DGEList(counts=all.gene_counts[,9:14], genes=all.gene_counts[,1:8],group=group)
y$samples
# problematic to change levels so I didn't use: y$samples$group <- relevel(y$samples$group, ref="2")
o <- order(rowSums(y$counts), decreasing=TRUE)
y <- y[o,]
d <- duplicated(y$genes$external_gene_name)
y <- y[!d,]
nrow(y) #62562->56912
# rowSums(is.na(y$genes))==0 Check whether there are NAs in the gene annotations.

keep <- rowSums(cpm(y)>1) >= 3 # Filter lowly expressed genes
table(keep) #True:12855
y <- y[keep, , keep.lib.sizes=FALSE]
# y$samples$lib.size <- colSums(y$counts) ##Duplicate with last filter step.
rownames(y$counts) <- rownames(y$genes) <- y$genes$external_gene_name
y$genes$external_gene_name <- NULL
y <- calcNormFactors(y)
y$samples
plotMDS(y)
