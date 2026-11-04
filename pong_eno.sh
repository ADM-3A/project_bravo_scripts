#!/bin/bash
# Specify FreeSurfer subjects directory and ones failed ping_eno.sh
export SUBJECTS_DIR=$PWD
for ij in 033 037; do
    SUBJ="par-${ij}"
    echo "----------------------------------------------------"
    echo "Euler statistics for Subject: $SUBJ (Pre-Fix)"
    echo "----------------------------------------------------"
    for hemi in lh rh; do
        SURF_FILE="$SUBJECTS_DIR/$SUBJ/surf/$hemi.orig.nofix"
        if [ -f "$SURF_FILE" ]; then
            echo "Hemisphere: $hemi"
            # Extract only the line containing the euler number and hole count
            mris_euler_number "$SURF_FILE" | grep "euler #"
        else
            echo "Error: $SURF_FILE not found. Ensure recon-all reached the tessellation stage."
        fi
    done
    echo "----------------------------------------------------"
done
