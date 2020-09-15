% genCRLB   generate Cramer Rao Lower Bound
%
% SYNOPSIS:
%   CRLB=genCRLB(ideal_img,gain,var)
%
% INPUTS:
%   ideal_img:
%       ideal image
%   pset:
%       point set
%   gain:
%       gain factor
%   var:
%       readout noise variance
%
% (C) Copyright 2020               The Huang Lab
%     All rights reserved           Weldon School of Biomedical Engineering
%                                   Purdue University
%                                   West Lafayette, Indiana
%                                   USA
% Yilun Li, April 2020

function CRLB=genCRLB(ideal_img,gain,var)

h_sz=size(ideal_img,1); % horizontal size
v_sz=size(ideal_img,2); % vertical size
CRLB=zeros(h_sz,v_sz);
for i=1:h_sz
    for j=1:v_sz
        u=ideal_img(i,j);
        g=gain(i,j);
        sigma=sqrt(var(i,j));
        pset=round(u-5*sqrt(u)):round(u+8*sqrt(u));
        pset(pset<0)=[];
        lb=g*pset(1)-6*sigma;   %integration lower bound
        ub=g*pset(end)+6*sigma; %integration higher bound
        ite=integral(@(x)interm(x,pset,u,g,sigma),lb,ub);
        J=ite./u^2-1;
        CRLB(i,j)=1/J;
    end
end
end