#5. Select genes of interest
# Intersect with genes within a certain window of SE.
#SE:chr9:124,196,906-124,219,148
#+/- 5MB: chr9:119,196,906-129,219,148
#Export the location/coordinates of a subset of genes from Biomart/Ensembl.
SE_5mb<-read.table("SE_5mb.txt",header=T,sep="\t")
length(unique(SE_5mb$Associated.Gene.Name))
out <- topTags(lrt, n=Inf) #or use treatDGE()
out=out$table
write.table(out,file="edgeR_DE_SE.txt",sep="\t",quote=FALSE)

SE_5mb_overlap=merge(out,SE_5mb, by.x="ensembl_gene_id",by.y="Ensembl.Gene.ID")
