
#!/bin/bash --login
#---------------
#Requested resources:
#SBATCH --account=pawsey0964
#SBATCH --job-name=blob_create
#SBATCH --partition=work
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --mem=40G
#SBATCH --export=ALL
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err




singularity run $SING2/blobtoolkit:4.4.5.sif blobtools create \
                    --fasta OG6_v230702.hic1.3.curated.hap1.chr_level.fa \ 
                    --meta OG6_v230702.hic1.3.curated.hap1.chr_level.yaml \
                    --taxid 232193 \ 
                    --taxdump /taxdump \
                    OG6_create_out


