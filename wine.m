clc
clear
load('wine.mat');
if ~exist('label','var')
    label=gnd;
end
nClass=max(unique(label));
fea=normlizedata(fea,2);
% fea=mapminmax(fea,0,1);
fea=zscore(fea);
[n,m]=size(fea);
options.ReducedDim=fix(0.8*m);
W = PCA(fea,options);
[n,~]=size(fea);
fea=fea*W;
lambda=10;
beta=1;
gamma=0.1;
iter=100;
k=10;
B=randn(n,nClass);
B=sign(B);
W=randn(m,nClass);
% MFBCPSO
% x_MFBCPSO=[];
% for i=1:k
%     i
%     l_MFBCPSO=MFBCPSO(fea,nClass,lambda,beta,iter);
% %     l_GBCNMF=GBCNMF(fea,nClass,lambda,beta,iter);
%     [NMI_MFBCPSO,AC_MFBCPSO]=ACNMI(l_MFBCPSO,label);
%     if balanced(l_MFBCPSO)
%         [S_MFBCPSO]=inclassdistance(fea,l_MFBCPSO,n);
%     else
%         disp('不平衡！');
%     end
%     x_MFBCPSO=[x_MFBCPSO;NMI_MFBCPSO,AC_MFBCPSO,S_MFBCPSO];
% end
% NMI_MFBCPSO_avg=mean(x_MFBCPSO(:,1));
% NMI_MFBCPSO_max=max(x_MFBCPSO(:,1));
% NMI_MFBCPSO_min=min(x_MFBCPSO(:,1));
% AC_MFBCPSO_avg=mean(x_MFBCPSO(:,2));
% AC_MFBCPSO_max=max(x_MFBCPSO(:,2));
% AC_MFBCPSO_min=min(x_MFBCPSO(:,2));
% S_MFBCPSO_avg=mean(x_MFBCPSO(:,3));
% S_MFBCPSO_max=max(x_MFBCPSO(:,3));
% S_MFBCPSO_min=min(x_MFBCPSO(:,3));
% GBCNMF
x_GBCNMF=[];
for i=1:k
    [l_GBCNMF,~,~]=GBCNMF(fea,B,W,nClass,lambda,beta,iter);
    [NMI_GBCNMF,AC_GBCNMF]=ACNMI(l_GBCNMF,label);
    if balanced(l_GBCNMF)
        [S_GBCNMF]=inclassdistance(fea,l_GBCNMF,n);
    else
        disp('不平衡！');
    end
    x_GBCNMF=[x_GBCNMF;NMI_GBCNMF,AC_GBCNMF,S_GBCNMF];
end
NMI_GBCNMF_avg=mean(x_GBCNMF(:,1));
NMI_GBCNMF_max=max(x_GBCNMF(:,1));
NMI_GBCNMF_min=min(x_GBCNMF(:,1));
AC_GBCNMF_avg=mean(x_GBCNMF(:,2));
AC_GBCNMF_max=max(x_GBCNMF(:,2));
AC_GBCNMF_min=min(x_GBCNMF(:,2));
S_GBCNMF_avg=mean(x_GBCNMF(:,3));
S_GBCNMF_max=max(x_GBCNMF(:,3));
S_GBCNMF_min=min(x_GBCNMF(:,3));
% BKmeans
x_BKmeans=[];
for i=1:k
    [l_BKmeans,~]=BKmeans(fea,nClass);
    [NMI_BKmeans,AC_BKmeans]=ACNMI(l_BKmeans,label);
    if balanced(l_BKmeans)
        [S_BKmeans]=inclassdistance(fea,l_BKmeans,n);
    else
        disp('不平衡！');
    end
    x_BKmeans=[x_BKmeans;NMI_BKmeans,AC_BKmeans,S_BKmeans];
end
NMI_BKmeans_avg=mean(x_BKmeans(:,1));
NMI_BKmeans_max=max(x_BKmeans(:,1));
NMI_BKmeans_min=min(x_BKmeans(:,1));
AC_BKmeans_avg=mean(x_BKmeans(:,2));
AC_BKmeans_max=max(x_BKmeans(:,2));
AC_BKmeans_min=min(x_BKmeans(:,2));
S_BKmeans_avg=mean(x_BKmeans(:,3));
S_BKmeans_max=max(x_BKmeans(:,3));
S_BKmeans_min=min(x_BKmeans(:,3));
% ckmeans
x_ckmeans=[];
for i=1:k
    ckmean(fea,nClass);
    load('l4.mat');
    l_ckmeans=l4;
    l_ckmeans=double(l_ckmeans);
    l_ckmeans=l_ckmeans';
    [NMI_ckmeans,AC_ckmeans]=ACNMI(l_ckmeans,label);
    if balanced(l_ckmeans)
        [S_ckmeans]=inclassdistance(fea,l_ckmeans,n);
    else
        disp('不平衡！');
    end
    x_ckmeans=[x_ckmeans;NMI_ckmeans,AC_ckmeans,S_ckmeans];
end
NMI_ckmeans_avg=mean(x_ckmeans(:,1));
NMI_ckmeans_max=max(x_ckmeans(:,1));
NMI_ckmeans_min=min(x_ckmeans(:,1));
AC_ckmeans_avg=mean(x_ckmeans(:,2));
AC_ckmeans_max=max(x_ckmeans(:,2));
AC_ckmeans_min=min(x_ckmeans(:,2));
S_ckmeans_avg=mean(x_ckmeans(:,3));
S_ckmeans_max=max(x_ckmeans(:,3));
S_ckmeans_min=min(x_ckmeans(:,3));

% Kmeans
x_kmeans=[];
for i=1:k
    l_kmeans = litekmeans(fea,nClass,'Replicates',iter);
    [NMI_kmeans,AC_kmeans]=ACNMI(l_kmeans,label);
    [S_kmeans]=inclassdistance(fea,l_kmeans,n);
    x_kmeans=[x_kmeans;NMI_kmeans,AC_kmeans,S_kmeans];
end
NMI_kmeans_avg=mean(x_kmeans(:,1));
NMI_kmeans_max=max(x_kmeans(:,1));
NMI_kmeans_min=min(x_kmeans(:,1));
AC_kmeans_avg=mean(x_kmeans(:,2));
AC_kmeans_max=max(x_kmeans(:,2));
AC_kmeans_min=min(x_kmeans(:,2));
S_kmeans_avg=mean(x_kmeans(:,3));
S_kmeans_max=max(x_kmeans(:,3));
S_kmeans_min=min(x_kmeans(:,3));

