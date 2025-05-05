# SM_RNAseq
RNAseq of different life stages of Swede midge

**Step 1: Quality control**

To perform simple quality checks to assess raw data, FASTQC (0.11.9) was used. This was performed to ensure that the data is suitable for analysis and there are no problems or biases that can affect it. It performs preliminary quality checks using various analysis modules and generates a HTML QC report which can identify problems with the raw data. The input for FASTQC is a Fastq file containing raw sequence reads. 

**Step 2: Quality trimming (Optional)**

Trimmomatic (0.38) was used to remove adapters if any in all the reads. Quality trimming was also performed to remove all low quality bases from the end of the read whose quality score is below the given threshold.

Rerun FASTQC on trimmomatic output to compare the reports. fastqc reports were generated for all the trimmed files.

**Step 3: Mapping to genome using STAR (Spliced Transcripts Alignment to a Reference) (2.7.11a)**

Reference genome (GCF_009176525) was indexed so that reads can efficiently align to it. Reads were aligned to the reference genome and outputs were generated in BAM format. Output BAM files were indexed using samtools (1.18). Gene expression was quantified by counting the no. of reads aligned to each gene using --quantMode option in STAR alignment. STAR output containing read counts per gene were generated into Reads.PerGene.out files. Log files were generated to examine the post alignment stats (Uniquely mapped reads %). 

**Step 4: Quantification**

Quantification of gene expression was done using featurecounts (2.0.2). BAM files were provided as input along with the annotation file to use metafeatures as reference for counting. Output is generated in the form of text file.

**Step 5: Normalization**


