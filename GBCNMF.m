function [gnd,B,W]=GBCNMF(X,B,W,nClass,lambda,bate,iter)
% function [gnd,B,W]=GBCNMF(X,nClass,lambda,bate,iter)
[m,n]=size(X);
% B=randn(m,nClass);
% B=sign(B);
% W=randn(n,nClass);
lm=ones(n,n);
Ic=eye(m,m);
In=eye(m,m);
l=ones(m,1);
ro=1.005;
mu=1e-5;
aa=(1:m)';
eta=rand(m,nClass);
buf=zeros(m,nClass);
x=[];
A=inv(X'*X+lambda*lm);
M=Ic-2*X*A'*X'+X*A'*X'*X*A*X'+lambda*X*A'*A*X'+bate*l*l';
for i=1:iter
        W=RRC(X,B,lambda);
    %     W=A*X'*B;
        for k=1:50
            Z=inv(mu*In+2*M)*(mu*B+eta);
            V=Z-1/mu*eta;
            [~,cc]=max(V');
            cc=cc';
            index=[aa cc];
            newindex=(index(:,2)-1)*m+index(:,1);
            B=-1*ones(m,nClass);
            B(newindex)=1;
            eta=eta+mu*(B-Z);
            mu=ro*mu;
        end
%         obj=norm(B-X*W,'fro')^2+lambda*norm(W,'fro')^2+bate*trace(B'*l*l'*B);
%         x=[x;obj];
    end
% plot(x);
gnd=label(B,m);
end
function l=label(x,m)
l=zeros(m,1);
for i=1:m
    l(i)=find(x(i,:)==1);
end
end

function flag=stop(y,i,k)
flag=0;
n=1;
if i>=k
    for j=i-k+1:i-1
        if isequal(y(:,:,j),y(:,:,j+1))==1
            n=1+n;
        end
    end
end
if n==k
    flag=1;
end
end