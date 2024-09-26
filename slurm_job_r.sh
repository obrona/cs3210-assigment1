#!/bin/bash

## This is an example Slurm template job script for A1 that just runs the script and arguments you pass in via `srun`.

#SBATCH --job-name=a1-perf-r
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=array_job_1
#SBATCH --output=output_%A_%a.txt
#SBATCH --error=error_%A_%a.txt
#SBATCH --array=0-4  # Adjust this
#SBATCH --mem=4gb
#SBATCH --partition=i7-7700
#SBATCH --time=00:10:00


values=(40 48 56 64 72)
lengths=(7926 9511 11097 12682 14267)
# Get the current array index
index=$SLURM_ARRAY_TASK_ID
# Access the corresponding value from the array
value=${values[$index]}
len=${lengths[$index]}
# Runs your script with the arguments you passed in
temp_file="temp_file_${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}.txt"
python3 gen_testcase.py 10000 "$len" $value 100 0 5 > "$temp_file"
echo "10000 $len $value 100 0 5 8" 1>&2
srun perf stat -r 3 ./sim.perf "$temp_file" 8
rm "$temp_file"