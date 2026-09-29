#!/bin/bash

for tp in before after; do
	for ij in {001..031} 033 034 {037..040}; do
		mkdir -p ../SynthSegCerebNet/${tp}/par-${ij}/mri
		mri_synthseg \
			--i ${tp}/par-${ij}/feline-${ij}.nii \
			--o ../SynthSegCerebNet/${tp}/par-${ij}/mri/synthseg.mgz \
			--vol ../SynthSegCerebNet/${tp}/par-${ij}/mri/synthseg.csv \
			--parc --robust --threads 1 --cpu
		mri_synthstrip \
			-i ${tp}/par-${ij}/feline-${ij}.nii \
			-o ../SynthSegCerebNet/${tp}/par-${ij}/mri/brain.mgz -t 12
        mri_vol2vol \
			--mov ../SynthSegCerebNet/${tp}/par-${ij}/mri/synthseg.mgz \
			--targ ../SynthSegCerebNet/${tp}/par-${ij}/mri/brain.mgz \
			--o ../SynthSegCerebNet/${tp}/par-${ij}/mri/aseg.presurf.mgz \
			--regheader --nearest
	done
done

apptainer build /mnt/z/Alpha/PAR/fast-v2.4.2.sif docker://deepmi/fastsurfer:cpu-v2.4.2

for tp in before after; do
    for ij in {001..031} 033 034 {037..040}; do
        apptainer exec \
            -B /mnt/z/Alpha/SynthSegCerebNet/${tp}:/output --cwd /output \
            /mnt/z/Alpha/PAR/fast-v2.4.2.sif \
            python3 /fastsurfer/CerebNet/run_prediction.py \
                --t1 /output/par-${ij}/mri/brain.mgz \
                --norm_name /output/par-${ij}/mri/brain.mgz \
                --asegdkt_segfile /output/par-${ij}/mri/aseg.presurf.mgz \
                --conformed_name /output/par-${ij}/mri/brain.mgz \
                --cereb_segfile /output/par-${ij}/mri/cerebellum.CerebNet.nii.gz \
                --cereb_statsfile /output/par-${ij}/stats/cerebellum.CerebNet.stats \
                --sd /output \
                --sid par-${ij} \
                --device cpu \
                --threads 12
    done
done
