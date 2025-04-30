#!/bin/bash
#SBATCH --job-name=star_batch   
#SBATCH --output=star_%j.out   
#SBATCH --error=star_%j.err    
#SBATCH --time=06:00:00           
#SBATCH --nodes=1                 
#SBATCH --ntasks=1               
#SBATCH --cpus-per-task=8         
#SBATCH --mem=64G                 



module load build-env/f2022
module load star/2.7.11a-gcc-12.3.0
module load samtools/1.18-gcc-12.3.0

GENOME_FA="genomic.fa"
ANNOTATION_GTF="genomic.gtf"
GENOME_DIR="path_to_directory/Reference_genome"

FASTQ_DIR="path_to_directory/fastq"                
OUTPUT_DIR="path_to_directory"
                    

echo "Starting genome indexing..."
STAR --runThreadN ${SLURM_CPUS_PER_TASK} \
     --runMode genomeGenerate \
     --genomeDir ${GENOME_DIR} \
     --genomeFastaFiles ${GENOME_FA} \
     --sjdbGTFfile ${ANNOTATION_GTF} \
     --sjdbOverhang 100\
     --genomeSAindexNbases 12
echo "Genome indexing completed."

SAMPLES=("1st_instar_1" "1st_instar_2" "pupae_1" "pupae_2" "adult_male_1" "adult_male_2" "adult_female_1" "adult_female_2" "eggs_1" "eggs_2" "2nd_instar_1" "2nd_instar_2" "3rd_instar_1" "3rd_instar_2" )
for SAMPLE in "${SAMPLES[@]}"; do
    READ1="${FASTQ_DIR}/${SAMPLE}_R1_fixed.fastq"
    READ2="${FASTQ_DIR}/${SAMPLE}_R2_fixed.fastq"

echo "Aligning sample: ${SAMPLE}"
STAR --runThreadN ${SLURM_CPUS_PER_TASK} \
       --genomeDir ${GENOME_DIR} \
       --readFilesIn ${READ1} ${READ2} \
       --outFileNamePrefix ${OUTPUT_DIR}/${SAMPLE}_ \
       --outSAMtype BAM SortedByCoordinate \
       --quantMode TranscriptomeSAM GeneCounts \
       --outFilterMultimapNmax 10 \ 
       --outFilterMismatchNoverReadLmax 0.04
  echo "Alignment completed for ${SAMPLE}"

samtools index ${OUTPUT_DIR}/${SAMPLE}_Aligned.sortedByCoord.out.bam
  echo "BAM indexing completed for ${SAMPLE}"
done
  
echo "STAR alignment pipeline completed for all samples."
  

   

