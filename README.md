
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
  <figcaption><em>Figure: Flowschema of the project transcriptomics pipeline.</em></figcaption>
</figure>


### 🔹 Data

- Raw count matrix from NCBI RNA-seq data
- 8 samples total: 4 RA, 4 Normal

### 🔹 Analysis Pipeline

1. **DESeq2**:
   - Count normalization
   - Differential gene expression (RA vs Normal)
   - Volcano plot visualization

2. **Gene Ontology (GO)**:
   - Enrichment of biological processes using `goseq`
   - Visual representation of top 10 GO terms

3. **KEGG Pathway**:
   - Visualization of enriched pathways using `pathview`
   - Highlighting up- and downregulated genes in RA

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

