#6. Plot with ggplot2
library(ggplot2)
library(ggrepel)
# plot every gene name
ggplot(SE_5mb_overlap, aes(x = logCPM, y = logFC)) + geom_point(size = 1, alpha = 0.95, color="black") +
  geom_hline(color = "blue3",yintercept = c(-1,1) ) + xlab("average logCPM") + ylab("log(SE/WT)") +
  xlim(0,10)+ylim(-1,1)+ggtitle("Genes within 5Mb of NEK6 SE") +
  geom_text_repel(aes(label = Associated.Gene.Name),size=2.5,color=colors()[30],fontface = "bold",segment.color = "gray22",segment.size=0.2,force=3)

# plot selected gene name
SE_5mb_overlap$emphasis=ifelse((SE_5mb_overlap$Associated.Gene.Name %in% c("NEK6","LHX2","PSMB7","DENND1A")),"emphasis","rest_gene")
ggplot(SE_5mb_overlap, aes(x = logCPM, y = logFC)) +
  geom_point(aes(color=emphasis),size = 0.5, alpha = 0.95) +
  scale_color_manual(values = c("blue4", "gray20")) +
  geom_hline(color = "blue3",yintercept = c(-1,1) ) +
  xlab("average logCPM") + ylab("log(SE1 Del/WT)") +
  xlim(0,10)+ylim(-1,1)+
  ggtitle("Genes within 5 Mb of NEK6 SE1") + theme_bw() +
 theme(title=element_text(size=12,face="bold"),
          axis.text=element_text(size=9,face="bold"),
          axis.title=element_text(size=11,face="bold"),
          panel.border=element_rect(colour = "black", fill=NA, size=1)) +
  geom_label_repel(data=subset(SE_5mb_overlap,emphasis=="emphasis"),aes(label=Associated.Gene.Name),size=3,color=colors()[30],fontface = "bold",segment.color = "gray22",segment.size=0.2,force=1)

# MA plot of all genes. Could set p-value into a gradient.
out$Significance <- ifelse(out$FDR < 0.05, "p < 0.05", "Not Significant")
out$rawSignificance <- ifelse(out$PValue < 0.05, "P < 0.05", "Not Sig")
ggplot(out, aes(x = logCPM, y = logFC)) +
  geom_point(aes(color=Significance),size = 0.3, alpha = 0.9) +
  scale_color_manual(values = c("black","red")) +
  geom_hline(color = "blue2",yintercept = c(-1,1) ) +
  xlab("average logCPM") + ylab("log(SE1 Del/WT)") +
  xlim(-0.3,15)+ylim(-5,5)+
  ggtitle("Gene Expression in SE1 Deletion and WT subclones") + theme_bw() +
  theme(title=element_text(size=11,face="bold"),
        axis.text=element_text(size=9,face="bold"),
        axis.title=element_text(size=11,face="bold"),
        panel.border=element_rect(colour = "black", fill=NA, size=1)) +
  geom_label_repel(data=subset(out,FDR<0.05),aes(label=rownames(subset(out,FDR<0.05))),size=3,color="darkred",fontface = "bold",segment.color = "gray22",segment.size=0.2,force=0.5)

ggsave("Rplot.png",plot=last_plot())
