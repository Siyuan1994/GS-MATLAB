% function result = fun_FT_Objective(input,n,~, ~)
function result = fun_FT_Objective(input,n,fl, ql)
% fxfy(scale,scale) = 0;
% for k = 1:scale
%     for l = 1:scale
%     fxfy(l,k) = l^2+k^2; 
%     end;
% end;
%     metrix = (exp (1i*pi*lambda*f.*fxfy))./(1i*lambda*f);
% if n ==1
%     ft = fft2(input);
% 
%     result = metrix.*ft;
% elseif n ==-1
% ift = 1./metrix.*input;
% result = ifft2(ift);
% 
% end;
% 
% mk= (1i/(lambda*focallength))*exp(-1i*4*pi*focallength/lambda);
% if n ==1
% g = exp(1i*2*pi*mk*input);
% result = fftshift(fft2(fftshift(g)));
% elseif n ==-1
% 
% gs = ifftshift(input);
% gt = ifft2(gs);
% gr = ifftshift(gt);
% result = log2(gr)./(1i*2*pi.*mk);
% end;


if n ==1
% temp = fft2(input);
% temp1 = fftshift(imresize(temp,256/257));
% result = imresize(temp1,257/256);
result = fftshift(fft2(input));
elseif n ==-1
% temp = imresize(input,256/257);
% 
% temp1 = ifftshift(temp);
% result = ifft2(imresize(temp1,257/256));
result = ifft2(ifftshift(input));
end;