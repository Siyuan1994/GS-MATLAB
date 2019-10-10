clear;
clc;

target=im2double(imread('xiaolian.png'));

% target(40,54)=1;
% target(20,54)=1;
% target(54,10)=1;
inneriterationtime=100;

res=512;                   %分辨率
L=6e-3;                    %横向尺寸 单位m
%distance=0.2;                 %传播距离 单位m 取0，0.01，1，10
lambda=1.03e-6;             %波长 单位m
w0=3e-3;                    %光斑半径 单位m

% target=imresize(target,res/512)



x2=linspace(-L,L,res);      %横向尺寸 
dx=2*L/(res-1);             %采样周期
[X,Y]=meshgrid(x2,x2);
r=sqrt(X.^2+Y.^2);
E=exp(-r.^2/w0^2);          %电场高斯函数
I=exp(-2*r.^2/w0^2);        %光强高斯函数





ang=randn(res,res);
ang=zeros(res,res)

% afterdistance=abs(fun_fpropagation(gaussian_sqrt,H1)).^2;
% afterdistance=abs(afterdistance)/max(max(abs(afterdistance)));
% afterlen=fun_FT_Objective(afterdistance,1,lambda,focalLength);


for m = 1:inneriterationtime
    
    afterslm = exp(1i*ang).*E;
    afterlens1 =fun_FT_Objective(afterslm,1,lambda,0);
    temp = afterlens1;
    ang = angle(temp);

    buffer3=target.*exp(1i.*ang);
    beforelens1=fun_FT_Objective(buffer3,-1,lambda,0);
    ang = angle(beforelens1);
    
end

% ang=im2double(rgb2gray(imread('111.png')))*2*pi;
afterslm_end=exp(1i*ang).*E;
result=fun_FT_Objective(afterslm_end,1,lambda,0);
nom_result=abs(result)/max(max(abs(result)));
ang(ang<0)=ang(ang<0)+2*pi;

figure(1)
imshow(target);
figure(2)
imshow(nom_result);
figure(3)
imshow(abs(ang)/max(max(abs(ang))));


% imwrite(ang/2/pi,'holo_smile.png')

MSE=sum(sum((nom_result-target).^2))/64/64

% figure(1)
% imagesc(gaussian);
% figure(2)
% imagesc(abs(afterdistance));
