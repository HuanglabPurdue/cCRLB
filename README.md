# cCRLB
This folder contains the all the functions for calculating cCRLB

How to run

The demo package consists of functions and scripts written in MATLAB (MathWorks, Natick, MA). The code has been tested in MATLAB version R2015a. 
To run the demo code for simulated microtubule structure:

1. Set the current folder in MATLAB to be cCRLB code\
2. Open script cCRLB_demo.m. Set the value of the following parameters: imgsz (image size), NA (numerical aperture of the objective), Lambda (emission wavelength), I (photon count of each fluorophore), bg(background photon count), gainsub (gain map) and varsub (variance map) of the camera.
3. Run the code.
4. The output includes: CRLB (estimation bound without constraint), cCRLB (estimation bound with constraint)

The usage of the demo code for experimental data is similar to the instruction above. Please see the included script, cCRLB_demo.m, for detail.
