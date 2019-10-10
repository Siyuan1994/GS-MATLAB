clear;
clc;
inneriterationtime=1;

res=1024;                   %分辨率
L=50e-3;                    %横向尺寸 单位m
distance=3;                 %传播距离 单位m 取0，0.01，1，10
lambda=1.03e-6;             %波长 单位m
w0=3e-3;                    %光斑半径 单位m
L_slm=6e-3;
size_r=round(res*L_slm/L/2);


x2=linspace(-L,L,res);      %横向尺寸 
dx=2*L/(res-1);             %采样周期
[X,Y]=meshgrid(x2,x2);
r=sqrt(X.^2+Y.^2);
E=exp(-r.^2/w0^2);          %电场高斯函数
I=exp(-2*r.^2/w0^2);        %光强高斯函数

cut1=r;
cut1(r>12.7e-3)=0;
cut1(r<=12.7e-3)=1;


cut2=zeros(res,res);
cut2(res/2-size_r:res/2+size_r,res/2-size_r:res/2+size_r)=1;




fx=linspace(-1/dx,1/dx,res);   %频域分解  1/dx为空间频率
fy=linspace(-1/dx,1/dx,res);   %频域分解


[fX,fY] = meshgrid(fx,fy);
fz=real(sqrt(1/lambda.^2-fX.^2-fY.^2));   %fz=sqer(1/lambda.^2-fX.^2-fY.^2))


H1 = exp(1i*2*pi*distance.*fz);
H2= exp(1i*2*pi*-distance.*fz);
ang=randn(size_r-1,size_r-1);
ang=padarray(ang,[round((res-size_r)/2),round((res-size_r)/2)],0);
target=im2double(imread('xiaolian1024_3.png'));
% % target=im2double(imresize(target,res/512));
% target=im2double(padarray(target,[(res-512)/2,(res-512)/2],0));
% % afterdistance=abs(fun_fpropagation(gaussian_sqrt,H1)).^2;
% % afterdistance=abs(afterdistance)/max(max(abs(afterdistance)));
% % afterlen=fun_FT_Objective(afterdistance,1,lambda,focalLength);
% 
% 
% for m = 1:inneriterationtime
%     
%     
%     afterslm = exp(1i*ang).*E;
%     afterdistance=fun_fpropagation(afterslm,H1);
%     buffer2= afterdistance ;
%     afterdistance=afterdistance.*cut1;
%     afterlens1 =fun_FT_Objective(buffer2,1,lambda,0);
%     
%     temp = afterlens1;
%     ang = angle(temp);
% 
%     buffer3=target.*exp(1i.*ang);
%     beforelens1=fun_FT_Objective(buffer3,-1,lambda,0);
%     returndistence=fun_fpropagation(beforelens1,H2);
%     ang = angle(returndistence);
%     ang=ang.*cut2;
%     
% end

ang=im2double(imread('smile256_predict_3.tiff'));
% ang=ang.*cut2;
afterslm_end=exp(1i*ang*2*pi).*E;
afterslm_end=afterslm_end.*cut2;
afterdistance_end=fun_fpropagation(afterslm_end,H1);
afterdistance_end1=afterdistance_end.*cut1;
result=fun_FT_Objective(afterdistance_end1,1,lambda,0);
result=abs(result);
nom_result=abs(result)/max(max(abs(result)));
ang(ang<0)=ang(ang<0)+2*pi;

figure(1)
subplot(2,3,1);
imagesc(target);
title('target');
axis equal
xlim([0,1024]);
ylim([0,1024]);

subplot(2,3,2);
imagesc(nom_result);
title('result归一')
axis equal
xlim([0,1024]);
ylim([0,1024]);


subplot(2,3,3);
imagesc(result);
title('result未归一')
axis equal
xlim([0,1024]);
ylim([0,1024]);

subplot(2,3,4);
imagesc(ang.*cut2);
title('全息图')
axis equal
xlim([0,1024]);
ylim([0,1024]);

subplot(2,3,5);
imagesc(abs(afterdistance_end)/max(max(abs(afterdistance_end))));
title('物镜处 截取前')
axis equal
xlim([0,1024]);
ylim([0,1024]);

subplot(2,3,6);
imagesc(abs(afterdistance_end1)/max(max(abs(afterdistance_end1))));
title('物镜处 截取后')
axis equal
xlim([0,1024]);
ylim([0,1024]);


% imwrite(ang/2/pi,'holo_smile.png')

% figure(1)
% imagesc(gaussian);
% figure(2)
% imagesc(abs(afterdistance));
