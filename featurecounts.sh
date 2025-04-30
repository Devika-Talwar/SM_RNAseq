#!/bin/bash
#SBATCH --job-name=featurecounts_pe
#SBATCH --output=featurecounts_pe_%j.out
#SBATCH --error=featurecounts_pe_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=6:00:00


module load build-env/.f2021
module load subread/2.0.2-gcc-10.2.0  # Load FeatureCounts


BAM_DIR="path_to_directory/star_output"
OUTPUT_DIR="path_to_directory/featurecounts_output"
GTF_FILE="genomic.gtf"
mkdir -p "$OUTPUT_DIR"

BAM_FILES=$(ls $BAM_DIR/*Aligned.sortedByCoord.out.bam | tr '\n' ' ')

featureCounts -T 8 -p --countReadPairs -B -C -a $GTF_FILE -o $OUTPUT_DIR/gene_counts.txt $BAM_FILES
echo "FeatureCounts completed successfully."


