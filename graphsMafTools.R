#author narumeena
#description making graphs of benchmarking results using annovar and rtg-tools results 

## try http:// if https:// URLs are not supported
#Install Bioconductor dependencies.
source("http://bioconductor.org/biocLite.R")
biocLite("ComplexHeatmap")
biocLite("VariantAnnotation")
biocLite("Biostrings")

#Install maftools from github repository.
#
library("devtools")
#install_github(repo = "PoisonAlien/maftools")

library(maftools)

##annovar output into MAF using annovarToMaf
var.annovar.maf = annovarToMaf(annovar = "/Users/naru/Documents/BISR/WESPipelinePaper/benchmarking/SRR622461/gatk/SRR622461.GATK.haplotypecaller.raw.hg19_multianno.txt", 
                                refBuild = 'hg19',table = 'ensGene', sep = "\t", tsbCol = "Tumor_Sample_Barcode")


laml = read.maf(maf = var.annovar.maf, removeSilent = TRUE, useAll = FALSE)
#Typing laml shows basic summary of MAF file.
laml

#Shows sample summry.
getSampleSummary(laml)


#Shows frequently mutated genes.
getGeneSummary(laml)

#Shows all fields in MAF
getFields(laml)


# Plotting MAF summary
plotmafSummary(maf = laml, rmOutlier = TRUE, addStat = 'median', dashboard = TRUE, titvRaw = FALSE)


#We will draw oncoplots for top ten mutated genes. (Removing non-mutated samples from the plot for better visualization)
oncoplot(maf = laml, top = 10, removeNonMutated = TRUE)
genesToBarcodes(maf = laml, genes = 'DNMT3A')
plotVaf(maf = laml,vafCol = 'Tumor_Sample_Barcode')
laml.titv = titv(maf = laml, plot = FALSE, useSyn = TRUE)
#plot titv summary
plotTiTv(res = laml.titv)
