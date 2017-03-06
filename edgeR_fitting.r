#4. edgeR model fitting
fit <- glmFit(y, design,robust=TRUE)
# lrt <- glmLRT(fit,coef=2) ##coef=2 means comparing group2 to baseline (group1).
lrt <- glmLRT(fit,contrast=c(1,-1)) ##contrast=c(1,-1) means 1*group1+(-1)*group2=group1-group2.
topTags(lrt)
sum(lrt$table$PValue<0.05) #280# for cpm>1 in >3 samples, or 827 for all, not good.
sum(p.adjust(lrt$table$PValue, method="BH")<0.05) #6# w/ and w/o cpm filter, same as the FDR in table.

o <- order(lrt$table$PValue)
cpm(y)[o[1:10],]
summary(de <- decideTestsDGE(lrt)) #how many are down,not changed, or up.
detags <- rownames(y)[as.logical(de)] #which genes are DE.

# Didn't use cos couldn't adjust easily and has a few weird orange dots.
# plotSmear(lrt, de.tags=detags,xlab="Average logCPM", ylab="log(SE/WT)",main="Gene expression in SE KO subclones") #plot logFC against average count size, highlighting DEs.

#4.2 alternative model fitting, not recommended by GTAC
#fit <- glmQLFit(y,design,robust=TRUE)
#qlf <- glmQLFTest(fit,contrast=c(1,-1))
#topTags(qlf)
#sum(qlf$table$PValue<0.05) #380# with cpm filter, or 512 w/o.
#sum(p.adjust(qlf$table$PValue, method="BH")<0.05) #0# w/ cpm filter, or 0 w/o,same as the FDR in table.
#y$samples
#et <- exactTest(y,pair=c("2","1"))
#topTags(et)
#sum(et$table$PValue<0.05) #281# w/ cpm filter, or 362 w/o.
#sum(p.adjust(et$table$PValue, method="BH")<0.05) #6# w/ and w/o cpm filter,same as the FDR in table.
