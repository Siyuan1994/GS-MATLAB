clear;
clc;


scale = 64;
inneriterationtime =50;  % 算法迭代次数
ang_start=randi(scale,scale);
lambda=1.03;
focalLength=2e3;
distance=1e3;
target=zeros(scale,scale);
target(10:20,10:50)=1;
% target(40,54)=1;
% target(20,54)=1;
% target(54,10)=1;


g0=  fun_gaussian(0,0,6.0);
g0 = abs(g0)./max(max(abs(g0)));
gaussian = imresize(g0,scale/256);
gaussian_sqrt=sqrt(gaussian);

fx=linspace(-0.7/lambda,0.7/lambda,scale);
fy=linspace(-0.7/lambda,0.7/lambda,scale);

[X,Y] = meshgrid(fx,fy);
fz=sqrt(1/lambda.^2-X.^2-Y.^2);
H1 = exp(-1i*2*pi*distance.*fz);
H2= exp(-1i*2*pi*-distance.*fz);
ang=ang_start;


% afterdistance=abs(fun_fpropagation(gaussian_sqrt,H1)).^2;
% afterdistance=abs(afterdistance)/max(max(abs(afterdistance)));
% afterlen=fun_FT_Objective(afterdistance,1,lambda,focalLength);


for m = 1:inneriterationtime
    
    afterslm = exp(1i*ang).*gaussian_sqrt;
    afterdistance=fun_fpropagation(afterslm,H1);
    buffer2= afterdistance ;
    afterlens1 =fun_FT_Objective(buffer2,1,lambda,focalLength);
    temp = afterlens1;
    ang = angle(temp);

    buffer3=target.*exp(1i.*ang);
    beforelens1=fun_FT_Objective(buffer3,-1,lambda,focalLength);
    returndistence=fun_fpropagation(beforelens1,H2);
    ang = angle(returndistence);
    
end

afterslm_end=exp(1i*ang).*gaussian_sqrt;
afterdistance_end=fun_fpropagation(afterslm_end,H1);
result=fun_FT_Objective(afterdistance_end,1,lambda,focalLength);
nom_result=abs(result)/max(max(abs(result)));
ang(ang<0)=ang(ang<0)+2*pi;

figure(1)
imshow(target);
figure(2)
imshow(nom_result);
figure(3)
imshow(abs(ang)/max(max(abs(ang))));




% figure(1)
% imagesc(gaussian);
% figure(2)
% imagesc(abs(afterdistance));
