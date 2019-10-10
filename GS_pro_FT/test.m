clear;
clc;
res=512;                   %分辨率
L=24e-3;                    %横向尺寸 单位m
distance=1;                 %传播距离 单位m 取0，0.01，1，10
lambda=1.03e-6;             %波长 单位m
w0=3e-3;                    %光斑半径 单位m
size=1;

x2=linspace(-L,L,res);      %横向尺寸 
% dx=2*L/(res-1);             %采样周期
dx=2*L/(res-1);    
[X,Y]=meshgrid(x2,x2);
r=sqrt(X.^2+Y.^2);
E=exp(-r.^2/w0^2);          %电场高斯函数
I=exp(-2*r.^2/w0^2);        %光强高斯函数





fx=linspace(-1/dx,1/dx,res);   %频域分解  1/dx为空间频率
fy=linspace(-1/dx,1/dx,res);   %频域分解


[fX,fY] = meshgrid(fx,fy);
fz=real(sqrt(1/lambda.^2-fX.^2-fY.^2));   %fz=sqer(1/lambda.^2-fX.^2-fY.^2))


H1 = exp(1i*2*pi*distance.*fz);          
H2= exp(1i*2*pi*-distance.*fz);          



% afterdistance=abs(fun_fpropagation(gaussian_sqrt,H1)).^2;
% afterdistance=abs(afterdistance)/max(max(abs(afterdistance)));
% afterlen=fun_FT_Objective(afterdistance,1,lambda,focalLength);




ang=im2double(imread('D:\深度学习项目\DotArray\6_6\6_6_predict_holo.png'))*2*pi;


ang=padarray(ang,[512*(size-1)/2,512*(size-1)/2],0);
E=padarray(E,[512*(size-1)/2,512*(size-1)/2],0);
value=1;
fx=linspace(-1/(value*dx),1/(value*dx),res*size);   %频域分解  1/dx为空间频率
fy=linspace(-1/(value*dx),1/(value*dx),res*size);   %频域分解

% 
[fX,fY] = meshgrid(fx,fy);
  

fz=sqrt(1/lambda.^2-fX.^2-fY.^2);


H1 = exp(1i*2*pi*distance.*fz);          

% H1=padarray(H1,[512,512],0);




afterslm = exp(1i*ang).*E;
afterdistance=fun_fpropagation(afterslm,H1);

afterdistance_nom=abs(afterdistance)./max(max(abs(afterdistance)));
afterdistance_ang=angle(afterdistance);
result=fun_FT_Objective(afterdistance,1,lambda,0);
nom_result=abs(result)/max(max(abs(result)));

figure(1)
subplot(1,2,1);
imshow(nom_result);


subplot(1,2,2);
imshow(afterdistance_nom);


figure(3)
imshow(afterdistance_ang)

% figure(2)
% imagesc(fz);
