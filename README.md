# Post SynthSeg pipelines for brainstem and cerebellum further segmentation

While FreeSurfer provides a comprehensive suite for anatomical MRI preprocessing, full surface reconstruction is unnecessary for studies that do not focus on the cerebral cortex. Instead, targeted subregion segmentation can be handled efficiently:

General Segmentation: SynthSeg provides robust whole-brain segmentation without the heavy overhead of traditional surface generation.

Brainstem Subregions: Managed via FreeSurfer's segment_subregions brainstem command (requires a bare-metal FreeSurfer installation).

Cerebellar Subregions: Handled via CerebNet for detailed cerebellar segmentation (requires containerized FastSurfer).
