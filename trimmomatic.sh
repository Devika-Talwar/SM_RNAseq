#!/bin/bash
#SBATCH --job-name=trimmomatic_all
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=4:00:00
#SBATCH --output=trimmomatic_all_%j.log

module load build-env/2020
module load trimmomatic/0.38-java-1.8
java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.38.jar


ADAPTERS="adapters.fa"
INPUT_DIR="path_to_directory"
OUTPUT_DIR="path_to_directory/trimmomatic_results"
THREADS=4  

mkdir -p "$OUTPUT_DIR"


for R1 in "$INPUT_DIR"/*_1.fastq; do
    
    SAMPLE=$(basename "$R1" "_1.fastq")
    R2="$INPUT_DIR/${SAMPLE}_2.fastq"
    
   
    R1_PAIRED="${OUTPUT_DIR}/${SAMPLE}_1_paired.fastq"
    R1_UNPAIRED="${OUTPUT_DIR}/${SAMPLE}_1_unpaired.fastq"
    R2_PAIRED="${OUTPUT_DIR}/${SAMPLE}_2_paired.fastq"
    R2_UNPAIRED="${OUTPUT_DIR}/${SAMPLE}_2_unpaired.fastq"

    
    java -jar $EBROOTTRIMMOMATIC/trimmomatic-0.38.jar PE -threads "$THREADS" \
        "$R1" "$R2" \
        "$R1_PAIRED" "$R1_UNPAIRED" \
        "$R2_PAIRED" "$R2_UNPAIRED" \
        ILLUMINACLIP:"$ADAPTERS":2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:36

    echo "Processed $SAMPLE"
done

