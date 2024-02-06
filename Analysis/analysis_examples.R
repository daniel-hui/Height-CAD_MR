library(MendelianRandomization)

#####Univariable
##example, height on CAD
data <- read.table("STable6.txt", head=T) #Supplemental Table 6 from manuscript. Note, should be using the full set of height instruments (STable 2, these are only the SNPs used for MVMR i.e., in all of the GWAS used for MVMR)

#for the outcome (e.g., CAD) effects, the alleles need to be oriented to those of height (which are oriented to the height-increasing allele)
#can use this script to flip the alleles:
#python match_height_alleles_general_onlySomeColumns.py <height effects e.g., STable2> <chr:pos to keep> <sumstats to flip> <chrom column> <pos column> <effect allele column> <other allele column> <freq column> <beta column> <se column> <p column>
#<chr:pos to keep> is a file formatted with one "chromosome\tposition" to keep (i.e., in both sets of sumstats)
#this script uses this file even for one other set of sumstats since it was used for MVMR to only keep chr:pos in multiple sets of sumstats
#e.g.,:
#python match_height_alleles_general_onlySomeColumns.py example_files/STable2.txt example_files/chrPos_toKeep.txt example_files/LDL_EUR_formatted_head100000.txt 1 2 3 4 5 6 7 8 | sort -gk1,1 -gk2,2 > example_files/LDL_EUR_formatted_head100000_heightFlipped.txt
#example_files/LDL_EUR_formatted.txt are European ancestry LDL sumstats from Klarin et al 2018
  #I just took the first 100K lines to reduce file size
#chrPos_toKeep.txt contains 1906 chromosome:positions that were available in all the GWAS for all exposures used in MVMR
  #for univariable, would probably be more than that
  #should use all chromosome:positions in both height and the outcome GWAS (e.g., stroke or PAD) only

mrobj <- mr_input(bx=data$Height_BETA, bxse=data$Height_SE, by=data$CAD_BETA, byse=data$CAD_SE) #same thing for the CAD effects, should be for all SNPs also available from STable2 from original CAD GWAS
all <- mr_allmethods(mrobj)
mr_plot(all) #example plot from MendelianRandomization
all #statistics
dput(all, file = "height_CAD.txt")

#format output
#bash:
#python format_dput.py height_CAD.txt > height_CAD_formatted.txt

##change beta to OR and SE to 95% CI
#e.g., for the IVW estimate
est <- -0.118786201
err <- 0.0133179494658282
exp(est)
exp(ci_normal(type = "l", mean = est, se = err, alpha = .025))
exp(ci_normal(type = "u", mean = est, se = err, alpha = .025))


#####Multivariable
library(MVMR)
#e.g., all exposures together
formatted <- format_mvmr(data[,c(21,5,7)], data$CAD_BETA, data[,c(22,6,8)], data$CAD_SE) #e..g, height, alcohol, birth weight
sink("MVMR_example.txt")
mvmr(formatted)
sink()


#####Direct and indirect effects
#direct and indirect effects

#height --> FEV1, Shrine
library(MendelianRandomization)
snps <- read.table("STable7.txt", head=T, sep="\t")

mrobj <- mr_input(bx=snps$Height_BETA, bxse=snps$Height_SE, by=snps$FEV1_BETA, byse=snps$FEV1_SE)
mr_ivw(mrobj)

#direct height estimate
-0.11984363 - (-0.078737196*-0.027)
#-0.1219695

mrobj <- mr_input(bx=snps$Height_BETA, bxse=snps$Height_SE, by=snps$FVC_BETA, byse=snps$FVC_SE)
mr_ivw(mrobj)

#direct height estimate
-0.11984363 - (-0.111505213*-0.01)
#-0.1209587
