#!/bin/bash

# # --------------------------------------------------------------------------------
# mkdir -p ../FreeSurfer/before
# docker pull freesurfer/freesurfer:6.0
# for i in {001..031} 033 034 {037..040}; do
#     docker run --rm -u 2025 -v /mnt/z/TeletypeModel33/FreeSurfer_license/license.txt:/opt/freesurfer/license.txt \
#         -v /mnt/z/Asgard/FS/before:/data -v /mnt/z/Asgard/FreeSurfer/before:/output \
#         freesurfer/freesurfer:6.0 recon-all -autorecon1 -autorecon2 -expert /data/before.opts \
#         -hires -i /data/par-${i}/MPRAGE.mgz \
#         -nofinalsurfs -nosmooth2 -noinflate2 -nocortribbon -nocurvstats -nosegstats \
#         -sd /output -s par-${i} -threads 20
# done

# --------------------------------------------------------------------------------
# mkdir -p ../FreeSurfer/after
docker pull freesurfer/freesurfer:6.0
for i in {025..031} 033 034 {037..040}; do
# for i in {001..031} 033 034 {037..040}; do
    docker run --rm -u 2025 -v /mnt/z/TeletypeModel33/FreeSurfer_license/license.txt:/opt/freesurfer/license.txt \
        -v /mnt/z/Asgard/FS/after:/data -v /mnt/z/Asgard/FreeSurfer/after:/output \
        freesurfer/freesurfer:6.0 recon-all -autorecon1 -autorecon2 -expert /data/after.opts \
        -hires -i /data/par-${i}/MPRAGE.mgz \
        -nofinalsurfs -nosmooth2 -noinflate2 -nocortribbon -nocurvstats -nosegstats \
        -sd /output -s par-${i} -threads 20
done