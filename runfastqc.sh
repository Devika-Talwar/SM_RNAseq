#!/bin/bash
#SBATCH --job-name=FastQC
#SBATCH --output=fastqc_%j.log
#SBATCH --mail-type=ALL             
#SBATCH --mail-user=devika.talwar00@gmail.com
#SBATCH --ntasks=1                   
#SBATCH --cpus-per-task=4            




module load build-env/f2022
module load fastqc/0.11.9-java-11


INPUT_DIR="/groups/ma/sradata/trimmomatic_results"
OUTPUT_DIR="/groups/ma/sradata/qcresults2"


fastqc -o $"/groups/ma/sradata/qcresults2" $"/groups/ma/sradata/trimmomatic_results"/*fastq

