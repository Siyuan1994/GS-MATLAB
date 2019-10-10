clear;
clc;

target=im2double(imread('xiaolian.png'));
% target(40,54)=1;
% target(20,54)=1;
% target(54,10)=1;
inneriterationtime=1;

res=512;                   %分辨率
L=10e-3;                    %横向尺寸 单位m
distance=0.2;                 %传播距离 单位m 取0，0.01，1，10
lambda=1.03e-6;             %波长 单位m
w0=3e-3;                    %光斑半径 单位m


x2=linspace(-L,L,res);      %横向尺寸 
dx=2*L/(res-1);             %采样周期
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
ang=randn(512,512);


% afterdistance=abs(fun_fpropagation(gaussian_sqrt,H1)).^2;
% afterdistance=abs(afterdistance)/max(max(abs(afterdistance)));
% afterlen=fun_FT_Objective(afterdistance,1,lambda,focalLength);


for m = 1:inneriterationtime
    
    afterslm = exp(1i*ang).*E;
    afterdistance=fun_fpropagation(afterslm,H1);
    buffer2= afterdistance ;
    afterlens1 =fun_FT_Objective(buffer2,1,lambda,0);
    temp = afterlens1;
    ang = angle(temp);

    buffer3=target.*exp(1i.*ang);
    beforelens1=fun_FT_Objective(buffer3,-1,lambda,0);
    returndistence=fun_fpropagation(beforelens1,H2);
    ang = angle(returndistence);
    
end

ang=im2double(imread('2_predict.tiff'))*2*pi;
afterslm_end=exp(1i*ang).*E;
afterdistance_end=fun_fpropagation(afterslm_end,H1);
result=fun_FT_Objective(afterdistance_end,1,lambda,0);
nom_result=abs(result)/max(max(abs(result)));
ang(ang<0)=ang(ang<0)+2*pi;

figure(1)
imshow(target);
figure(2)
imshow(nom_result);
figure(3)
imshow(abs(ang)/max(max(abs(ang))));


imwrite(ang/2/pi,'holo_smile.png')

% figure(1)
% imagesc(gaussian);
% figure(2)
% imagesc(abs(afterdistance));
