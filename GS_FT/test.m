res=114;                   %分辨率
L=6e-3;                    %横向尺寸 单位m
%distance=0.2;                 %传播距离 单位m 取0，0.01，1，10
lambda=0.532e-6;             %波长 单位m
w0=6e-3;                    %光斑半径 单位m

% target=imresize(target,res/512)



x2=linspace(-L,L,res);      %横向尺寸 
dx=2*L/(res-1);             %采样周期
[X,Y]=meshgrid(x2,x2);
r=sqrt(X.^2+Y.^2);
E=exp(-r.^2/w0^2);          %电场高斯函数
I=exp(-2*r.^2/w0^2);        %光强高斯函数

ang=im2double(rgb2gray(imread('111.png')))*2*pi;
afterslm_end=exp(1i*ang).*E;
result=fun_FT_Objective(afterslm_end,1,lambda,0);
nom_result=abs(result)/max(max(abs(result)));
figure(1)
imshow(nom_result);
figure(2)
imshow(abs(ang)/max(max(abs(ang))));

