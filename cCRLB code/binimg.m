% binimage
%
% SYNOPSIS:
%   output=binimg(input,factor)
%
% INPUTS:
%   input:
%       input image
%   factor:
%       binning ratio
%
% (C) Copyright 2017                The Huang Lab
%     All rights reserved           Weldon School of Biomedical Engineering
%                                   Purdue University
%                                   West Lafayette, Indiana
%                                   USA
% Yilun Li, April 2020
function output=binimg(input,factor)
s=size(input,1);
r=round(s/factor);
output=zeros(r);
for i=1:r
    for j=1:r
        vertical =factor*(i-1)+1;
        horizon =factor*(j-1)+1;
        temp=input(vertical:vertical+factor-1,horizon:horizon+factor-1);
        output(i,j)=sum(temp(:));
    end
end
end
