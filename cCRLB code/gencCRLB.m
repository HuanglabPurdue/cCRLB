% gencCRLB   generate constrained Cramer Rao Lower Bound
%
% SYNOPSIS:
%   cCRLB = gencCRLB(ideal_img,CRLB,OTF_mask)
%
% INPUTS:
%   ideal_img:
%       ideal image
%   CRLB:
%       2D Cramer Rao Lower Bound map
%   OTF_mask:
%       2D Optical transfer function mask
%
%
% (C) Copyright 2020               The Huang Lab
%     All rights reserved           Weldon School of Biomedical Engineering
%                                   Purdue University
%                                   West Lafayette, Indiana
%                                   USA
% Yilun Li, April 2020

function cCRLB=gencCRLB(ideal_img,CRLB,OTF_mask)
InvJ=diag(CRLB(:)); % inverse of Information matrix
N=size(CRLB,1);
[id_v,id_h]=find(ifftshift(OTF_mask)==0);
dG=zeros(size(id_v,1),N*N); % initialize constraints array
W=dftmtx(N);    % 2d discrete Fourier transform matrix
parfor i=1:size(id_v,1)
    p=id_v(i);
    q=id_h(i);
    wp=W(p,:);  % row vector wp=1p'*W
    wq=W(:,q);  % column vector wq=W*1q
    scl=2*vpa(wp,10)*ideal_img*vpa(wq,10);  % calculating scalar 2*1p'*W*U*W*1q with high precision
    dEpq=vpa(wp',10)*vpa(scl,10)*vpa(wq',10);  % calculating matrix derivation 2*W'1p*1p'*W*U*W*1q*1q'*W'  
    dEpq=double(dEpq);
    dG(i,:)=dEpq(:);   % forming ith constraint
end

P=eye(N*N)-InvJ*dG'*(dG*InvJ*dG')^(-1)*dG;  % projection matrix
cInvJ=P*InvJ;   % projected inverse information matrix
cCRLB=real(diag(cInvJ));    %due to numerical calculation result is complex (ideally will be real) with small imaginary part
cCRLB=reshape(cCRLB,N,N);



    