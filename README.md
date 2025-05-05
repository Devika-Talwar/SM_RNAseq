# SM_RNAseq
RNAseq of different life stages of Swede midge

Step 1: Quality control
To perform simple quality checks to assess raw data FASTQC () was used. This was performed to ensure that the data is suitable for analysis and there are no problems or biases that can affect it. It performs preliminary quality checks using various analysis modules and generates a HTML QC report which can identify problems with the raw data. The input for FASTQC is a Fastq file containing raw sequence reads. 

Step 2: Quality trimming (Optional)
If adapter contamination or low quality reads are seen in the sequences, it must be trimmed. 
