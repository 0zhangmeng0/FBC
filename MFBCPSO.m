function [gnd]=MFBCPSO(X,nClass,lambda,bate,iter)
[m,n]=size(X);
ss=50;         %种群数

s1=50;         %最大迭代次数
c1=2;           %c1,c2为学习因子
c2=2;
fit=zeros(ss,1);
init_B=zeros(m,nClass,ss);
init_W=zeros(n,nClass,ss);
parfor ssi=1:ss
    B=randn(m,nClass);
    B=sign(B);
    W=randn(n,nClass);
    [~,init_B(:,:,ssi),init_W(:,:,ssi)]=GBCNMF(X,B,W,nClass,lambda,bate,iter);
    fit(ssi)=obj(X,init_B(:,:,ssi),init_W(:,:,ssi),lambda,bate);
end
pbest=init_B;
gbest=min(fit)*ones(ss,1);
init_v=-0.05+0.10*rand(m,nClass,ss);


x=[];
for i=1:s1
    buf_B=init_B;
    parfor ssi=1:ss
        init_v(:,:,ssi)=init_v(:,:,ssi)+c1*rand()*(pbest(:,:,ssi)-buf_B(:,:,ssi))+c2*rand()*(gbest(ssi)-buf_B(:,:,ssi));
        buf_B(:,:,ssi)=buf_B(:,:,ssi)+init_v(:,:,ssi);
        buf_B(:,:,ssi)=sign(buf_B(:,:,ssi));
%         init_W(:,:,ssi)=RRC(X,init_B(:,:,ssi),lambda);
        [~,init_B(:,:,ssi),init_W(:,:,ssi)]=GBCNMF(X,buf_B(:,:,ssi),init_W(:,:,ssi),nClass,lambda,bate,iter);
        obj_value=obj(X,init_B(:,:,ssi),init_W(:,:,ssi),lambda,bate);
        if obj_value<fit(ssi)
            pbest(:,:,ssi)=init_B(:,:,ssi);
            fit(ssi)=obj_value;
        end
        if fit(ssi)<gbest(ssi)
            gbest(ssi)=fit(ssi);
        end
    end
    ind1=find(min(gbest)==gbest);
    gbest=min(gbest)*ones(ss,1);
    Bbest=pbest(:,:,ind1(1));
    x=[x;min(gbest)];
    if stop(x,i,10)
        break;
    end
end
% plot(x);
gnd=label(Bbest,m);
end

function l=label(x,m)
l=zeros(m,1);
for i=1:m
    l(i)=find(x(i,:)==1);
end
end
function obj=obj(X,B,W,lambda,bate)
[m,n]=size(X);
l=ones(m,1);
obj=norm(B-X*W,'fro')^2+lambda*norm(W,'fro')^2+bate*trace(B'*l*l'*B);
end
function flag=stop(y,i,k)
flag=0;
if i>=k
    if length(unique(y(i-k+1:i)))==1
        flag=1;
    end
end
end