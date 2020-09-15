function im = im_radial_stripe(N, w)
    % im_mire_radiale - Generates a radial stripe
    %
    %   SYNTAXE
    %   im = im_radial_stripe(N, w);
    %
    %   INPUTS
    %   'N' 	- size of the square image
    %   'w' 	- number of branches
    %
    %   OUTPUT
    %   'im'    - generated image 
    %
    % July 2018 - Olivier Lévêque <olivier.leveque@institutoptique.fr>
    
    li = linspace(-1,1,N);
    [X,Y] = meshgrid(li);
    [th,rad] = cart2pol(X,Y);
    I = 1+sin(w*th);
    I = double((I>1)&(rad<0.9));
    
    if (nargout == 0)
        imagesc(I);
        title(num2str([w,N,N],'Radial stripe with %u branches (%u x %u)'));
        colormap gray;
        colorbar off;
        axis square;
        axis off;
    else
        im = I;
    end
end