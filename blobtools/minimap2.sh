#!/bin/bash --login
#---------------
#Requested resources:
#SBATCH --account=pawsey0964
#SBATCH --job-name=minimap2
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --time=10:00:00
#SBATCH --mem=60G
#SBATCH --export=ALL
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err



singularity run $SING/minimap2:2.26.sif minimap2 -ax map-pb  \
                                    -t 8  \
                                    OG6_v230702.hic1.3.curated.hap1.chr_level.fa \
                                    OG6_cat_hifi_reads.fastq.gz \
                                | singularity run $SING/samtools_1.16.1.sif samtools sort -@16 -O BAM -o OG6_v230702.hic1.3.curated.hap1.chr_level.fa.bam - 







