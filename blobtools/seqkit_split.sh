#!/bin/bash --login
#SBATCH --account=pawsey0964
#SBATCH --job-name=split
#SBATCH --partition=copy
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --export=NONE
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=lauren.huet@uwa.edu.au
#SBATCH --output=split_%j.out
#SBATCH --error=split_%j.err
#-----------------
#Loading the required modules


singularity run $SING/seqkit:2.8.2.sif seqkit sliding -s 10000 -W 10000 OG6_v230702.hic1.3.curated.hap1.chr_level.fa -o OG6_slid_10kb.fa

wait 

singularity run $SING/seqkit:2.8.2.sif seqkit split -p 350 -O OG6_slid_split OG6_slid_10kb.fa
