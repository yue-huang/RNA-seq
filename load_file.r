#1. load files of gene counts
load("~/Dropbox/research/data/Lymphoma-RE/RNA-seq/edgeR.RData")
setwd("~/Dropbox/research/data/Lymphoma-RE/RNA-seq/")
save.image(file="edgeR.RData")

all.gene_CPM <- read.delim("all.gene_CPM.txt", header = TRUE, sep = "\t")
all.gene_counts <- read.delim("all.gene_counts.txt", header = TRUE, sep = "\t")
## Note: somehow read.table only read half of the entire data set!!! Need to check file size!!!
