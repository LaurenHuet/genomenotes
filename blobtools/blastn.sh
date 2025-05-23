#!/bin/bash --login
#---------------
#Requested resources:
#SBATCH --account=pawsey0964
#SBATCH --job-name=blastn
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
#SBATCH --mem=80G
#SBATCH --export=ALL
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err



database=/scratch/pawsey0964/lhuet/databases
fasta=$1 

singularity run -B /scratch:/scratch $SING/blast:2.15.0.sif blastn \
-query $fasta \
-db $database/nt_2025_05/core_nt \
-outfmt '6 qseqid staxids bitscore std' \
-max_target_seqs 1 \
-max_hsps 1 \
-evalue 1e-25 \
-out ${fasta%.fa}_vs_nt.out
