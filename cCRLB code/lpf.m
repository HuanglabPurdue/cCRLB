% lpf    low pass filter
%
% SYNOPSIS:
%   out=lpf(input,otf)
%
% INPUTS:
%   input:
%       input image
%   otf
%       Optical transfer function
%
% (C) Copyright 2017                The Huang Lab
%     All rights reserved           Weldon School of Biomedical Engineering
%                                   Purdue University
%                                   West Lafayette, Indiana
%                                   USA
% Yilun Li, April 2020
function out=lpf(input,otf)
f_input=fftshift(fft2(input));
f_output=f_input.*otf;
out=ifft2(ifftshift(f_output));
end

