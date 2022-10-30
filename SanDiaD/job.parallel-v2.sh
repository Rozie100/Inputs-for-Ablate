#!/bin/bash
#SBATCH --cluster=ub-hpc
#SBATCH --partition=general-compute --qos=general-compute
#SBATCH --time=72:00:00
#SBATCH --nodes=80
#SBATCH --ntasks-per-node=40
#SBATCH --constraint=MRI
#SBATCH --cpus-per-task=1
#SBATCH --mem=50000
#SBATCH --job-name="SanDiaD-v2"
#SBATCH --mail-type=END

# Print the current environment
echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR

echo "working directory = "$SLURM_SUBMIT_DIR


module use /projects/academic/chrest/modules
module load chrest/release

# The initial srun will trigger the SLURM prologue on the compute nodes.
NPROCS=`srun --nodes=${SLURM_NNODES} bash -c 'hostname' |wc -l`
echo NPROCS=$NPROCS

# The PMI library is necessary for srun
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so


export HDF5_ROOT=$PETSC_DIR/$PETSC_ARCH
# Make a temp directory so that tchem has a place to vomit its files



# Run ABLATE with Input
echo "Start Time " `date +%s`
srun -n $NPROCS  ~/release/ablate --input /panasas/scratch/grp-chenjm/rozie/sanDiaD-v2.yaml  


echo "End Time " `date +%s`
