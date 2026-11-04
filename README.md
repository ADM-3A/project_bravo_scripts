# Post SynthSeg pipelines for brainstem and cerebellum further segmentation

While FreeSurfer provides a comprehensive suite for anatomical MRI preprocessing, full surface reconstruction is unnecessary for studies that do not focus on the cerebral cortex. Instead, targeted subregion segmentation can be handled efficiently:

General Segmentation: SynthSeg provides robust whole-brain segmentation without the heavy overhead of traditional surface generation.

Cerebellar Subregions: Handled via CerebNet for detailed cerebellar segmentation (requires containerized FastSurfer).

Brainstem Subregions: Managed via FreeSurfer's segment_subregions brainstem command (requires a bare-metal FreeSurfer installation).

BTW:
Scripts ping_eno.sh is used to call containerized FreeSurfer v6.0.0 for "Euler number", which was used as image quality metrics in some paper. Only FreeSurfer v6.0.0 was validated for this purpose, the usefulness of later versions is unknown.
In case of error to yield hemispherical "Euler number", users can change into FreeSurfer subjects directory and run pong_eno.sh to extract with the command mris_euler_number.
