
#Bestanden ophalen
setwd("C:/Documents/A-HVHL BM opdrachten/J2-P4 Innovatieve diagnostiek")
getwd("C:/Documents/A-HVHL BM opdrachten/J2-P4 Innovatieve diagnostiek")

#Zip bestanden openen
unzip("C:/Users/Yaelf/OneDrive/Documenten/Data_reuma/Data_RA_raw.zip", exdir = "Reuma_dataset") 

#Package installeren
install.packages('BiocManager')
BiocManager::install('Rsubread')
#Package inladen
library(BiocManager)
library(Rsubread)


#Referentiegenoom bestand ophalen
setwd("C:/Documents/ncbi_human")
# zip-bestand unzippen
unzip("C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ncbi_humangenome.zip", exdir = "ncbi_humangenome") 

#Referentiegenoom indexeren
buildindex( basename = 'ref_human', reference = 'C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ncbi_humangenome/ncbi_dataset/data/GCF_000001405.40/GCF_000001405.40_GRCh38.p14_genomic.fna', memory = 4000, indexSplit = TRUE)


#Monsters mappen tegen referentiegenoom
# Controle monsters
align.norm1 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ref_human", readfile1 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785819_1_subset40k.fastq", readfile2 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785819_2_subset40k.fastq",  output_file = "norm1.BAM")
align.norm2 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ref_human", readfile1 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785820_1_subset40k.fastq", readfile2 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785820_2_subset40k.fastq", output_file = "norm2.BAM")
align.norm3 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ref_human", readfile1 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785828_1_subset40k.fastq", readfile2 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785828_2_subset40k.fastq", output_file = "norm3.BAM")
align.norm4 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ref_human", readfile1 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785831_1_subset40k.fastq", readfile2 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785831_2_subset40k.fastq", output_file = "norm4.BAM")

#Experimentele monsters
align.rheu1 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ref_human", readfile1 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785979_1_subset40k.fastq", readfile2 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785979_2_subset40k.fastq", output_file = "rheu1.BAM")
align.rheu2 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ref_human", readfile1 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785980_1_subset40k.fastq", readfile2 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785980_2_subset40k.fastq",  output_file = "rheu2.BAM")
align.rheu3 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ref_human", readfile1 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785986_1_subset40k.fastq", readfile2 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785986_2_subset40k.fastq", output_file = "rheu3.BAM")
align.rheu4 <- align(index = "C:/Users/Yaelf/OneDrive/Documenten/ncbi_human/ref_human", readfile1 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785988_1_subset40k.fastq", readfile2 = "~/Data_reuma/Reuma_dataset/Data_RA_raw/SRR4785988_2_subset40k.fastq", output_file = "rheu4.BAM")


#BAM bestanden sorteren en indexeren
# Package inladen
library(Rsamtools)

# Bestandsnamen van de monsters
samples <- c('rheu1', 'rheu2', 'rheu3', 'rheu4', 'norm1', 'norm2', 'norm3', 'norm4')

#Voor elk monster: sorteer en indexeer de BAM-file
# Sorteer BAM-bestanden
lapply(samples, function(s) {sortBam(file = paste0(s, '.BAM'), destination = paste0(s, '.sorted'))})
lapply(samples, function(s) {indexBam(file = paste0(s, '.sorted.bam'))})





#Count matrix
#Packages inladen
library(readr)
library(dplyr)
library(Rsamtools)
library(Rsubread)

# Vector maken met namen van BAM-bestanden.
allsamples <- c('rheu1.bam', 'rheu2.bam', 'rheu3.bam', 'rheu4.bam', 'norm1.bam', 'norm2.bam', 'norm3.bam', 'norm4.bam')

#count matrix maken
count_matrix <- featureCounts(
  files = allsamples,
  annot.ext = "~/ncbi_human/GCF_000001405.25_GRCh37.p13_genomic.gtf.gz",
  isPairedEnd = TRUE,
  isGTFAnnotationFile = TRUE,
  GTF.attrType = "gene_id",
  useMetaFeatures = TRUE)

#Resultaten bekijken
head(count_matrix$annotation)
head(count_matrix$counts)

#Countmatrix opslaan en inladen
# Bekijk de structuur van het object
str(count_matrix)
# Alleen matrix met tellingen eruit halen
counts <- count_matrix$counts
counts
# Kolomnamen instellen
colnames(counts) <- c("rheu1", "rheu2", "rheu3", "rheu4", "norm1", "norm2", "norm3", "norm4")
# Matrix opslaan
write.csv(counts, "bewerkt_countmatrix.csv")
#Bekijken
head(counts)
# Kolommen sorteren van hoog naar laag
sorted_counts <- counts[order(counts[, 1], decreasing = TRUE), ]
View(sorted_counts)








#Statistiek
#Bestand inlezen count matrix
counts<- read.table("C:/Documents/ncbi_human/count_matrix.txt")
head(counts)

#Behandelingstabel maken voor de Deseq differentiële expressieanalyse
treatment <- c("normal", "normal", "normal", "normal","rheuma", "rheuma", "rheuma", "rheuma")
treatment_table <- data.frame(treatment)
rownames(treatment_table) <- c('SRR4785819', 'SRR4785820','SRR4785828', 'SRR4785831', 'SRR4785979', 'SRR4785980', 'SRR4785986', 'SRR4785988')

#Installeren packages
BiocManager::install("DESeq2")
BiocManager::install("KEGGREST")
#Packages inladen
library(DESeq2)
library(KEGGREST)


#DESeq2-analyse
#Getallen in de count matrix afronden
counts <- round(counts, 0) 

# Maak DESeqDataSet aan
dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = treatment_table,
                              design = ~ treatment)

# Voer Deseq analyse uit
dds <- DESeq(dds)
resultaten <- results(dds)

# Resultaten opslaan in een bestand
write.table(resultaten, file = 'ResultatenDESeqAnalyse.csv', row.names = TRUE, col.names = TRUE)

#Bepalen hoeveel genen up- of down-gereguleerd zijn
#Up-regulated
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange > 1, na.rm = TRUE)
#Down-regulated
sum(resultaten$padj < 0.05 & resultaten$log2FoldChange < -1, na.rm = TRUE)

#Genen met grootste verschil in expressie bepalen
hoogste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = TRUE), ]
laagste_fold_change <- resultaten[order(resultaten$log2FoldChange, decreasing = FALSE), ]
laagste_p_waarde <- resultaten[order(resultaten$padj, decreasing = FALSE), ]
#bekijken welke de belangrijkste genen zijn
head(hoogste_fold_change)
laagste_p_waarde
head(laagste_fold_change)
head(laagste_p_waarde)

#Vulcano plot maken
#inladen package
if (!requireNamespace("EnhancedVolcano", quietly = TRUE)) {
  BiocManager::install("EnhancedVolcano")}
library(EnhancedVolcano)
library(ggplot2)


#Vulcano plot maken
EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj')

# Alternatieve plot zonder p-waarde cutoff (alle genen zichtbaar)
EnhancedVolcano(resultaten,
                lab = rownames(resultaten),
                x = 'log2FoldChange',
                y = 'padj',
                pCutoff = 0)

#Figuur opslaan
dev.copy(png, 'VolcanoplotCasus.png', 
         width = 8,
         height = 10,
         units = 'in',
         res = 500)
dev.off()




####Gene Ontology (GO)-verrijkingsanalyse
#Packages downloaden
BiocManager::install("goseq")
BiocManager::install("geneLenDataBase")
BiocManager::install("org.Dm.eg.db")
a
#Packages inladen
library("goseq")
library("geneLenDataBase")
library("org.Dm.eg.db")
library("gapminder")


#Input files maken
#Tabel maken met significante differentiele genen
read.csv("C:/Documents/ncbi_human/ResultatenDESeqAnalyse.csv")
#Gehele tabel inlezen
deg <- read.table("ResultatenDESeqAnalyse.csv",
                  header = TRUE,
                  sep = ";",          # or "," if it's a CSV
                  row.names = 1,
                  stringsAsFactors = FALSE)
#Subset van tabel maken waarbij padj < 0.5 
DEG <- deg[!is.na(deg$padj) & deg$padj < 0.5, ]


#Tabel maken met alle genen
ALL <- read.table("C:/Documents/ncbi_human/ResultatenDESeqAnalyse.csv")

#Vectoren maken voor DEG en ALL data
class(DEG)
DEG.vector <- ALL %>% 
  filter(padj < 0.05)
deg.vector<- rownames (DEG.vector)
ALL.vector<- rownames(ALL)



#Nieuwe vector maken waarbij een 0 wordt toegevoegd aan elk gen dat niet in de DEG list staat en 1 voor die wel in de DEG list staan
gene.vector=as.integer(ALL.vector%in%deg.vector)
names(gene.vector)=ALL.vector 
#Vector bekijken
head(gene.vector)
tail(gene.vector)



#Weigh the gene vector by lengths of our genes
pwf <- nullp(gene.vector, "hg19", "geneSymbol")
head(pwf)

#Vind enriched GO terms
GO.wall=goseq(pwf,"hg19", "geneSymbol")

#Hoeveel enriched GO terms er zijn
class(GO.wall)
head(GO.wall)
nrow(GO.wall)

#Alleen enriched GO terms selecteren die statistisch significant zijn
enriched.GO=GO.wall$category[GO.wall$over_represented_pvalue<.05]
#Hoeveel GO terms zijn er nu
class(enriched.GO)
head(enriched.GO)
length(enriched.GO)

#Meer biologically meaningful results krijgen
library(GO.db)
capture.output(for(go in enriched.GO[1:258]) { print(GOTERM[[go]])
  cat("--------------------------------------\n")
}
, file="SigGo.txt")
#OUTPUT
file.show("SigGo.txt")


#Plotten van resultaten GO-analyse
#Packages inladen
library("gapminder")
library("ggplot2")

# GO-verrijkingsanalyse uitvoeren
goResults <- goseq(pwf, "hg19","geneSymbol", test.cats=c("GO:BP"))

#Resultaten plotten 10 meest significante GO-terms
goResults %>% 
  top_n(10, wt=-over_represented_pvalue) %>% 
  mutate(hitsPerc=numDEInCat*100/numInCat) %>% 
  ggplot(aes(x=hitsPerc, 
             y=term, 
             colour=over_represented_pvalue, 
             size=numDEInCat)) +
  geom_point() +
  expand_limits(x=0) +
  labs(x="Hits (%)", y="GO term", colour="p-value", size="Count")






#KEGG pathway analyse
#Inladen packages
if (!requireNamespace("pathview", quietly = TRUE)) {
  BiocManager::install("pathview")
}
library(pathview)


#Maken van KEGG pathway
# Genen en log2 fold change extraheren
gene_data <- resultaten$log2FoldChange
names(gene_data) <- rownames(resultaten)


#Zet om naar enterez IDs
entrez_ids_all <- mapIds(org.Hs.eg.db,
                         keys = rownames(resultaten),
                         column = "ENTREZID",
                         keytype = "SYMBOL",
                         multiVals = "first")

#Maak vector van log2FC met entrez IDs als namen
gene_data_entrez <- gene_data
names(gene_data_entrez) <- entrez_ids_all

#Verwijder NA's
gene_data_entrez <- gene_data_entrez[!is.na(names(gene_data_entrez))]

#rheumatoid arthritis pathway
KEGG ID: hsa05323

# KEGG pathway visualisatie (hsa05323)
pathview(gene.data  = gene_data_entrez,
         pathway.id = "hsa05323",
         species    = "hsa",
         limit      = list(gene = c(-5, 5)),
         low        = list(gene = "red"),
         mid        = list(gene = "white"),
         high       = list(gene = "green"))

#Pathway → Genen
keggLink("hsa", "path:hsa05323")

