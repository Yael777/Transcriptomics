#bestanden ophalen
setwd("C:/Users/Yaelf/OneDrive/Documenten/Transcriptomics/")
getwd("C:/Users/Yaelf/OneDrive/Documenten/Transcriptomics/")

#zip bestanden openen
# Vervang de bestandsnaam hieronder met je eigen zip-bestand
unzip("C:/Users/Yaelf/OneDrive/Documenten/Transcriptomics/transfer_3140477_files_2d2312d2.zip", exdir = "transcriptomics_dataset") 
#Hiermee worden de bestanden uitgepakt in een submap 'ethanol_data'

#Package installeren
install.packages('BiocManager')
BiocManager::install('Rsubread')
#Package inladen
library(BiocManager)
library(Rsubread)
a

#Referentiegenoom bestanden ophalen
setwd("C:/Users/Yaelf/OneDrive/Documenten/ncbi_data")
# zip-bestand unzippen
unzip("C:/Users/Yaelf/OneDrive/Documenten/ncbi_data/ncbi_dataset3.zip", exdir = "ncbi_data3") 


######
#Referentiegenoom indexeren
buildindex( basename = 'ref_ecoli', reference = 'C:/Users/Yaelf/OneDrive/Documenten/ncbi_data/ncbi_data3/ncbi_dataset/data/GCF_000005845.2/GCF_000005845.2_ASM584v2_genomic.fna', memory = 4000, indexSplit = TRUE)

setwd("C:/Users/Yaelf/OneDrive/Documenten/Transcriptomics/transcriptomics_dataset")

#Monsters mappen tegen referentiegenoom
# Ethanol monsters
align.eth1 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_data/ref_ecoli", readfile1 = "SRR8394576_ethanol_12h_1.fasta.gz", output_file = "eth1.BAM")
align.eth2 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_data/ref_ecoli", readfile1 = "SRR8394577_ethanol_12h_2.fasta.gz", output_file = "eth2.BAM")
align.eth3 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_data/ref_ecoli", readfile1 = "SRR8394578_ethanol_12h_3.fasta.gz", output_file = "eth3.BAM")

#Controles mappen tegen referentiegenoom
align.con1 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_data/ref_ecoli", readfile1 = "SRR8394612_control_12h_1.fasta.gz", output_file = "con1.BAM")
align.con2 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_data/ref_ecoli", readfile1 = "SRR8394613_control_12h_2.fasta.gz", output_file = "con2.BAM")
align.con3 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_data/ref_ecoli", readfile1 = "SRR8394614_control_12h_3.fasta.gz", output_file = "con3.BAM")



#BAM bestanden sorteren en indexeren
# Laad Rsamtools voor sorteren en indexeren
library(Rsamtools)

# Bestandsnamen van de monsters
samples <- c('eth1', 'eth2', 'eth3', 'con1', 'con2', 'con3')

# Voor elk monster: sorteer en indexeer de BAM-file
# Sorteer BAM-bestanden
lapply(samples, function(s) {sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))})

lapply(samples, function(s) {indexBam(file = paste0(s, '.sorted.bam'))
})