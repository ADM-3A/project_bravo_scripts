#!/bin/bash

for tp in before after; do
    for ij in {001..031} 033 034 {037..040}; do
        cp ${tp}/par-${ij}/mri/aseg.presurf.mgz \
            ${tp}/par-${ij}/mri/aseg.mgz
        cp ${tp}/par-${ij}/mri/brain.mgz \
            ${tp}/par-${ij}/mri/norm.mgz	
        segment_subregions brainstem \
            --cross par-${ij} --sd $(pwd)/${tp} \
            --suffix ${tp} --threads 12
    done
done

# Loop through both 'before' and 'after' directories
for tp in before after; do
    # Define the output CSV file path specifically for this folder
    OUTPUT_FILE="${tp}/${tp}_brainstem_volumes.csv"
    
    # Write the header to the specific CSV
    echo "Participant,Correction,Medulla,Pons,SCP,Midbrain,Whole_Brainstem" > "$OUTPUT_FILE"

    # Loop through each participant directory within the current condition
    for par_dir in "${tp}"/par-*/; do
        # Extract participant ID (e.g., par-001)
        par_id=$(basename "$par_dir")
        
        # Define the source text file path
        file_path="${par_dir}mri/brainstemSsLabels${tp}.volumes.txt"
        
        # Check if the file exists before processing
        if [ -f "$file_path" ]; then
            # Extract volumes using awk [cite: 1]
            medulla=$(grep "Medulla" "$file_path" | awk '{print $2}')
            pons=$(grep "Pons" "$file_path" | awk '{print $2}')
            scp=$(grep "SCP" "$file_path" | awk '{print $2}')
            midbrain=$(grep "Midbrain" "$file_path" | awk '{print $2}')
            whole=$(grep "Whole_brainstem" "$file_path" | awk '{print $2}')
            
            # Append the row to the condition-specific CSV
            echo "$par_id,$tp,$medulla,$pons,$scp,$midbrain,$whole" >> "$OUTPUT_FILE"
        fi
    done
    
    echo "Summary created: $OUTPUT_FILE"
done
echo "All extractions complete."
