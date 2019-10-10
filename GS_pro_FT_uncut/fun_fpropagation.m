function u1 = fun_fpropagation(u0,H)
% 
U = fft2(u0);
shiftU = fftshift(U).*H;
U = ifftshift(shiftU);
u1 = ifft2(U);

% U = fft2(u0);
% shiftU = imresize(fftshift(imresize(U,512/513)),513/512).*H;
% U = ifftshift(imresize(shiftU,512/513));
% u1 = ifft2(imresize(U,513/512));