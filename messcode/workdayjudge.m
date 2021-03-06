N=70;
n=[1:N];
x=[1.02,0.53,1.3,0.84,1.4,0.85,1.5,1.5,1.43,1.8,1.27,1.19,1.39,1.43,1.5,1.35,1.18,1.39,0.93,1.57,0.91,1.33,0.55,1.59,0.7,0.5,0.7,0.89,0.78,1.2,1.06,0.9,0.92,1.21,0.7,0.51,0.97,0.78,0.58,0.6,1.42,0.81,1.3,0.94,1.4,1.57,1.64,1.65,1.23,1.25,1,0.92,1.68,0.88,1,2,1.12,1.29,2.1,0.55,0.51,0.72,0.86,0.98,1.45,0.99,0.75,1.08,0.71,1.6];
y=zeros(1,70);
figure(3)
e=[1:70]
plot(e,x,'b');
title('历史数据曲线图')
grid
for  nn=[1:70],
    y(nn+1)=y(nn)+x(nn);
end
y=y(nn+1)/N
x1=zeros(1,N);
x1=x-y;
R1=zeros(1,N);
x2=zeros(1,N);
for  nn=[1:70],
    for  ii=[1:71-nn],
         x2(nn)=x2(nn)+x1(ii)*x1(nn+ii-1);
    end
end
for  jj=[1:70],
     R1(jj)=x2(jj)/N;
end
R2=R1;
R3=zeros(1,16);
for  jj=[1:16]
    R3(jj)=R2(jj)/R2(1);%R3为相关函数值
end
h=zeros(1,15);
g=zeros(1,15);
A=zeros(15);
for  k=[1:14],
    for j=[1:k],
        A(1,1)=R3(2);
        h(k)=h(k)+R3(k+2-j)*A(k,j);
        g(k)=g(k)+R3(j+1)*A(k,j);
        A(k+1,k+1)=(R3(k+2)-h(k))/(1-g(k));
        A(k+1,j)=A(k,j)-A(k+1,k+1)*A(k,k+1-j);
    end
end
B=A;
figure(1)
set(1,'Position',[10,35,350,650])
ii=[1:16];
iii=[0:0.02:16];
plot(ii,R3,'b',iii,0.2390,'r');
grid
title('自相关图')
figure(2)
jj=[1:16];
m=zeros(1,16);
m(1)=1;
for  j=[2:16],
    m(j)=A(j-1,j-1);%m为偏相关函数值
end
jjj=[0:0.02:16];
plot(jj,m,'b',jjj,0.2390,'r');
title('偏自相关图')
grid

%预测新的数据
  NN=10;
z=zeros(1,11);
z(1)=1.6;
for  q=[1:NN],
     z(q+1)=0.1375*z(q)+0.962895;
end  
figure(4)
p=[1:10];
plot(p,z(p),'b');
grid
title('预测数据')
%总的图形
figure(5)
t=[70:80];
plot(e,x,'b',t,z,'r');
grid
title('历史数据-蓝色线；预测数据-红色线')