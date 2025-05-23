#!/bin/bash --login
#---------------
#Requested resources:
#SBATCH --account=pawsey0964
#SBATCH --job-name=blob_add
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --mem=20G
#SBATCH --export=ALL
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err


singularity run $SING2/blobtoolkit:4.4.5.sif blobtools add \
                        --hits top10_taxa_full_noheader.tsv \
                        --taxrule bestsumorder \
                        --taxdump /scratch/pawsey0964/lhuet/blobtools/new_taxdump \
                        --replace \
                        OG6_create_out
