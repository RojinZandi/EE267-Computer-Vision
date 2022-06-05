function [output]=bilateral_each_channel(w,sigma_r,sigma_s,level)
%%
image=level; 
%transforms the domain specified by vectors from -window_size to window_size into arrays X and Y 
[x y]=meshgrid(-w:w,-w:w);
%% Domain filter 
%The weights depend on the spatial distance (to the center pixel x) only; therefore, it is calculated once and saved.
domain_filter=exp(-(x.^2+y.^2)/(2*sigma_s^2));

%% Repeat for all pixels
[r c]=size(image);
output=zeros(size(image));

% Create waitbar.
h = waitbar(0,'Wait...');
set(h,'Name','Bilateral Fiter Processing for R,G,B channels');

for i=1:r
    for j=1:c
        %Adjusting the window size
        imin=max(i-w,1);
        imax=min(i+w,r);
        jmin=max(j-w,1);
        jmax=min(j+w,c);
        I=image(imin:imax,jmin:jmax);
        
        % Range filter
        range_filter=exp(-(I-image(i,j)).^2/(2*sigma_r^2));
        
        %Taking the product of the range and domain filter.The combination is refered to as Bilater Filter
        BilateralFilter=range_filter.*domain_filter((imin:imax)-i+w+1,(jmin:jmax)-j+w+1);
        
        Fnorm=sum(BilateralFilter(:));
        
        %normalize the output
        output(i,j)=sum(sum(BilateralFilter.*I))/Fnorm;
    end
   waitbar(i/(r-sigma_s));
end
close(h)
end