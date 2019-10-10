function gau = fun_gaussian(m,n,p) % in meter
ko_d =1;
Step = (2*p)/255;
x = -p:Step:p;
y=x;
if m ==0
    Hm= ones(size(x));
end
if m ==1
    Hm = 2*x*ko_d;
end
if m ==2
    Hm= 4*x.^2-2*ones(size(x));
end
if m ==3
    Hm= 8*x.^3-12*x;
end
if n == 0
    Hn = ones(size(x));
end
if n ==1
    Hn = 2*x*ko_d;
end
if n ==2
    Hn = 4*x.^2-2*ones(size(x));
end
if n==3
    Hn = 8*x.^3-12*x;
end

% L = 2*x;
n =size(x);
N= n(2);
for k=1:N
    for l=1:N
        gau(k,l) = 255*(exp(1i*ko_d/2*(x(l)^2+y(k)^2))* Hm(l)*Hn(k)*exp(-ko_d/2*(x(l)^2+y(k)^2)));
    end
end