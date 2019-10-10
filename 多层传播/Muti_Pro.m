res=512;                   %分辨率
L=10e-3;                    %监视尺寸 单位m
iter=100;
% 
% distance=1; 
distance1=0.2;              %传播距离 单位m 取0，0.01，1，10
distance2=0.5; 
distance3=1; 
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


H1 = exp(1i*2*pi*distance1.*fz);  
H1_= exp(1i*2*pi*-distance1.*fz);  
H2 = exp(1i*2*pi*distance2.*fz); 
H2_= exp(1i*2*pi*-distance2.*fz);  
H3 = exp(1i*2*pi*distance3.*fz);
H3_= exp(1i*2*pi*-distance3.*fz);  
% afterdistance=abs(fun_fpropagation(E,H1)).^2;                    %计算传播后的光强
% afterdistance=abs(afterdistance)/max(max(abs(afterdistance)));   %归一化
target1=im2double(rgb2gray(imread('1.png')));
target2=im2double(rgb2gray(imread('2.png')));
target3=im2double(rgb2gray(imread('3.png')));


ang=randn(512,512);
for i=1:iter
    afterslm=E.*exp(1i*ang);
    afterdistance1=fun_fpropagation(afterslm,H1);  
    phi1=angle(afterdistance1);
    aftermirror1=target1.*exp(1i*phi1);
    return1=fun_fpropagation(aftermirror1,H1_);  
    
    afterdistance2=fun_fpropagation(afterslm,H2);  
    phi2=angle(afterdistance2);
    aftermirror2=target2.*exp(1i*phi2);
    return2=fun_fpropagation(aftermirror2,H2_);  
    
    afterdistance3=fun_fpropagation(afterslm,H3);  
    phi3=angle(afterdistance3);
    aftermirror3=target3.*exp(1i*phi3);
    return3=fun_fpropagation(aftermirror3,H3_); 
%     ang=angle(return2);

    ang=angle(return1+return2+return3);
    
    
end

% ang=im2double(imread('holo/holo1.png'))*2*pi;
% ang=holo*2*pi;
afterslm=E.*exp(1i*ang);
afterdistance1=fun_fpropagation(afterslm,H1);  
I1=abs(afterdistance1).^2;
figure(1)
imshow(I1);                    


afterdistance2=fun_fpropagation(afterslm,H2);  
I2=abs(afterdistance2).^2;
figure(2)
imshow(I2)          


afterdistance3=fun_fpropagation(afterslm,H3);  
I3=abs(afterdistance3).^2;
figure(3)
imshow(I3)


ang(ang<0)=ang(ang<0)+2*pi;
holo=ang/2/pi;
imwrite(holo,'holo/holo1.png');
holo1=im2double(imread('holo/holo1.png'));