#author narumeena
#description making graphs of benchmarking results using annovar and rtg-tools results 

## try http:// if https:// URLs are not supported
#Install Bioconductor dependencies.
source("http://bioconductor.org/biocLite.R")
biocLite("ComplexHeatmap")
biocLite("VariantAnnotation")
biocLite("Biostrings")

#Install maftools from github repository.
library("devtools")
install_github(repo = "PoisonAlien/maftools")


var.annovar = system.file("extdata", "variants.hg19_multianno.txt", package = "maftools")


##annovar output into MAF using annovarToMaf
var.annovar.maf = annovarToMaf(annovar = var.annovar, Center = 'CSI-NUS', refBuild = 'hg19', 
                               tsbCol = 'Tumor_Sample_Barcode', table = 'ensGene')
## Converting Ensemble Gene IDs into HGNC gene symbols.

## Done! Original ensemble gene IDs are preserved under field name ens_id