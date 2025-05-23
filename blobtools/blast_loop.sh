for fa in *split/*.fa;do

sbatch blastn.sh $fa

done 
