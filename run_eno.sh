#!/bin/bash

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

# ----------------------------------------------------
# Euler statistics for Subject: par-033 (Pre-Fix)
# ----------------------------------------------------
# Hemisphere: lh
# euler # = v-e+f = 2g-2: 279070 - 837762 + 558508 = -184 --> 93 holes
# Hemisphere: rh
# euler # = v-e+f = 2g-2: 283380 - 850710 + 567140 = -190 --> 96 holes
# ----------------------------------------------------
# ----------------------------------------------------
# Euler statistics for Subject: par-037 (Pre-Fix)
# ----------------------------------------------------
# Hemisphere: lh
# euler # = v-e+f = 2g-2: 266786 - 800928 + 533952 = -190 --> 96 holes
# Hemisphere: rh
# euler # = v-e+f = 2g-2: 255186 - 765972 + 510648 = -138 --> 70 holes
# ----------------------------------------------------