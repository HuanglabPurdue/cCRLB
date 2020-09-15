% gen_otf   generate Optical transfer function
%
% SYNOPSIS:
%   out=gen_otf(NA,Lambda,Pixelsize,imgsz)
%
% INPUTS:
%   NA:
%       numerical aperture
%   Lambda:
%       light wavelength
%   Pixelsize:
%       length of a pixel at sample plane
%   imgsz:
%       image size
%
% (C) Copyright 2020               The Huang Lab
%     All rights reserved           Weldon School of Biomedical Engineering
%                                   Purdue University
%                                   West Lafayette, Indiana
%                                   USA
% Yilun Li, April 2020


function out=gen_otf(NA,Lambda,Pixelsize,imgsz)
MTF=zeros(imgsz);
mtf_r=NA/Lambda;
sz=imgsz*Pixelsize;
ctr=floor(imgsz/2)+1;
[x,y]=meshgrid(1:imgsz);
id=(((x-ctr).^2+(y-ctr).^2)./sz^2)<mtf_r.^2;
MTF(id)=1;
out=conv2(MTF,MTF,'same');
out=out./max(out(:));
