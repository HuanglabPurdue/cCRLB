% interm   intermediate variable
%
% SYNOPSIS:
%   out = interm(x,pset,u,g,sigma)
%
% INPUTS:
%   x:
%       pixel readout
%   pset:
%       point set
%   u:
%       expected photon count
%   g:
%       gain factor
%   sigma:
%       readout noise standard deviation
%
% (C) Copyright 2020               The Huang Lab
%     All rights reserved           Weldon School of Biomedical Engineering
%                                   Purdue University
%                                   West Lafayette, Indiana
%                                   USA
% Yilun Li, April 2020

function out=interm(x,pset,u,g,sigma)
temp1=0.*x;
temp2=0.*x;
for i=1:size(pset,2)
    tao=pset(i);
    temp1=temp1+tao.*poisspdf(tao,u).*normpdf(x,g*tao,sigma);
    temp2=temp2+poisspdf(tao,u).*normpdf(x,g*tao,sigma);
end
out=temp1.^2./temp2;
out(temp1==0)=0;
end