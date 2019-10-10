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
afterdistance=abs(fun_fpropagation(E,H1)).^2;                    %计算传播后的光强
afterdistance=abs(afterdistance)/max(max(abs(afterdistance)));   %归一化



figure(1)
imshow(I);                      %显示初始光强
figure(2)
imshow(afterdistance)           %显示传播distance之后的光强



