N = [500 500] % size in pixels of image
 F = 3;        % frequency-filter width
 [X,Y] = ndgrid(1:N(1),1:N(2))
 i = min(X-1,N(1)-X+1);
 j = min(Y-1,N(2)-Y+1);
 H = exp(-.5*(i.^2+j.^2)/F^2);
 Z = real(ifft2(H.*fft2(randn(N))));
 surf(X,Y,Z,'edgecolor','none');
 light;