%------ Demo code for constrained Cramer Rao Lower bound calculation
% software requirement: Matlab R2015a or later
%
% (C) Copyright 2020               The Huang Lab
%     All rights reserved           Weldon School of Biomedical Engineering
%                                   Purdue University
%                                   West Lafayette, Indiana
%                                   USA
% Yilun Li, April 2017
%% create parallel pool, it usually takes 1 to 6 minutes
clc
clearvars;
close all;
if isempty(gcp)
    distcomp.feature('LocalUseMpiexec', false);
    c = parcluster;
    pool = parpool(c.NumWorkers);
end
%% create normalized ideal image

realstrsz = 1024;   % number of pixels for underlying structure (ought to be infinite)
strsize = 0.005;    % the pixel size of underlyin structure on sample plane, unit is micron
NA = 1.4;           % numerical aperture of the microscope system
Lambda = 0.7;       % emission wavelength of the sample, unit is micron
imgsz = 64;         % number of pixels for ideal image
Rb = realstrsz/imgsz;   % Rate of binning
Pixelsize=strsize*Rb;    % the pixel size of ideal image on sample plane, unit is micron

%% creat Siemens star ideal norm

OTF_mask=gen_otf(NA,Lambda,strsize,realstrsz);
strip_n=14;     % Number of branches of Siemens star
star=im_radial_stripe(realstrsz,strip_n);
idealimgnorm=lpf(star,OTF_mask);    % ideal norm image with many (shoule be infinite) pixels
ideal_norm=binimg(idealimgnorm,Rb)./(Rb^2);     % ideal norm image with limited pixels

%% generate ideal image

I = 20;             % total photon count of per area
bg = 10;             % background photon count
ideal_img=ideal_norm.*I+bg;

OTF=gen_otf(NA,Lambda,Pixelsize,imgsz);
imagesc(OTF)
title('Optical transfer function')

%% select variance map from calibrated map data
% the calibrated maps are 512 by 512 pixels
% varsub:   selected variance map, size is the same as the ideal image size
% gainsub:  selected gain map, size is the same as the ideal image size
% test gain calibration file: gaincalibration_561_gain.mat

gainfile = 'gaincalibration_561_gain.mat';
[varsub,gainsub] = gennoisemap(imgsz,gainfile);%% select variance map from calibrated map data

%% CRLB calculation
% CRLB=genCRLB(ideal_img,gainsub,varsub);   % original CRLB calculation
CRLB=ideal_img+varsub./gainsub.^2;  % Maximum likelihood function estimates approaches CRLB asymptotically, generating same results as previous approach but much faster.
figure
imagesc(CRLB)
colorbar
title('CRLB')
axis equal
axis off
%% cCRLB calculation This may take 5-10 minutes
cCRLB=gencCRLB(ideal_img,CRLB,OTF);
figure
imagesc(cCRLB)
colorbar
title('cCRLB')
axis equal
axis off




