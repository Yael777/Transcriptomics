
<p align="center">
  <img src="Assets/RNA_figuur_readme.jpg" alt="RNA Figure" width="1100"  />
</p>

# Transcriptomics rheumatoïde arthritis
# 🧬 Pro-inflammentoire genen, cytokines en cellen zijn up-gereguleerd in patiënten met RA waardoor balans wordt verstoord

Brief one-liner describing the project, e.g., "Differential Gene Expression and GO/KEGG Pathway Analysis in Rheumatoid Arthritis Patients"

---

## 📁 Inhoud/structuur

- `data/raw/` – fictionele datasets voor de analyse van spreuk effectiviteit, gevaar en welke spreuken het beste samengaan met verschillende types staf.  
- `data/processed` - verwerkte datasets gegenereerd met scripts 
- `scripts/` – scripts om prachtige onzin te genereren
- `resultaten/` - grafieken en tabellen
- `bronnen/` - gebruikte bronnen 
- `README.md` - het document om de tekst hier te genereren
- `assets/` - overige documenten voor de opmaak van deze pagina
- `data_stewardship/` - Voor de competentie beheren ga je aantonen dat je projectgegevens kunt beheren met behulp van GitHub. In deze folder kan je hulpvragen terugvinden om je op gang te helpen met de uitleg van data stewardship. 

---

## 🧬 Introduction

Genexpressie is de expressie van een fenotype door transcriptie en translatie (Buccitelli & Selbach, 2020). Transcriptomics is de studie van het transcriptoom (al het RNA in een cel of weefsel) wat iets over de genexpressie zegt. Hiermee kunnen effecten en oorzaken van verschillende ziektebeelden worden onderzocht. (Khodadadian et al., 2020).
Reumatoïde artritis (RA) is een chronische auto-immuunziekte waarbij systematische synovitis (ontsteking van synovium) en bot- en gewrichtsafbraak optreedt. 5 op de 1000 volwassenen heeft RA waarvan 5-20% van de patiënten slecht op anti-reumatische medicatie reageert. RA ontstaat onder anderen door genetische factoren waardoor auto-immuun tolerantie verminderd. De complexiteit van het ziekteverloop en de onbekende oorzaak van RA zorgen ervoor dat het moeilijk behandelbaar is. (Suwa et al., 2023)
Hoewel de precieze oorzaak van RA niet bekend, is het duidelijk is dat genetische factoren een rol spelen. Door de oorzaak van RA in beeld te krijgen kunnen gerichtere therapieën en preventie worden ontwikkeld. In dit onderzoek wordt er m.b.v transcriptomics de expressie van genen in RA en normale personen vergeleken om een beter beeld van de pathogenese van de ziekte te krijgen.

---

## 🧪 Methods

<figure>
  <img src="Assets/Flowschema_project_transcriptomics.png" alt="Flowschema">
  <figcaption><em>Figuur 1: Flowschema transcriptomics analyse. Een weergave van de methode van de transcriptomics analyse in R vanaf sample collectie tot statistische analyses.</em></figcaption>
</figure>


### 🔹 Meta data
Er werden 4 samples van personen zonder RA (ACPA negatief) en 4 samples van personen met RA (diagnose van >12 maanden, ACPA positief) verkregen uit een synoviumbiopt. Informatie over deelnemers is te vinden in tabel…. In…. Sequencing werd uitgevoerd waarna een transcriptomics analyse werd uitgevoerd in R, scripts zijn te vinden in …….. en flowschema is weergegeven in figuur 1.

### 🔹 Sorteren, indexeren en countmatrix
Het referentiegenoom werd geïndexeerd met behulp van het menselijke referentiegenoom uit het NCBI-file: GCF_000001405.40_GRCh38.p14_genomic.fna, en de packages BiocManager en Rsubread. Monsters werden gemapt tegen het geïndexeerde referentiegenoom waaruit BAM-files ontstonden. BAM-files werden gesorteerd en geïndexeerd m.b.v Rsamtools.  M.b.v readr, dplyr, Rsamtools en Rsubread en het annotation NCBI file GCF_000001405.25_GRCh37.p13_genomic.gtf.gz werd een countmatrix gemaakt. Statistiek werd uitgevoerd op de count matrix file: count_matrix.txt. 

### 🔹 DEseq2-, GO- en KEGG-analyse
Een DESeq2-analyse werd uitgevoerd met DESeq2. Resultaten werden gevisualiseerd in een vulcano plot m.b.v EnhancedVolcano en ggplot2. Een Gene Ontology (GO)-verrijkingsanalyse werd m.b.v goseq , geneLenDataBase en org.Dm.eg.db . De 10 meest significante resultaten werden gevisualiseerd. Een KEGG pathway analyse werd uitgevoerd m.b.v KEGGREST en de resultaten van de GO-analyse waarbij de pathway ‘rheumatoide arthritis’  met KEGG ID: hsa05323 uit GO term ‘immune system process’ werd geanalyseerd m.b.v pathview.

---

## 📊 Results

### 🔹 Differential Expression

- Total significant DEGs (FDR < 0.05): **X**
  - Upregulated in RA: **Y**
  - Downregulated in RA: **Z**

### 🔹 Top Genes

- Most upregulated: *GENE_A*, *GENE_B*
- Most downregulated: *GENE_X*, *GENE_Y*

### 🔹 GO Enrichment

- Top enriched biological processes include:
  - Inflammatory response
  - Immune system regulation
  - Cell adhesion

### 🔹 KEGG Pathway

- RA-associated pathway `hsa05323` visualized
- Genes mapped with fold changes (green = upregulated, red = downregulated)

---

## Conclusion

This analysis identified key genes and pathways altered in rheumatoid arthritis. The combination of DESeq2, GO, and KEGG analyses provides biological insight into disease mechanisms, highlighting immune and inflammatory responses as major drivers in RA.

