NMI = result(:,1);
NMI = reshape(NMI,5,5);
AC = result(:,2);
AC = reshape(AC,5,5);
lambda = result(:,3);
lambda = unique(log10(lambda));
beta = result(:,4);
beta = unique(log10(beta));
figure(1)
contourf(lambda,beta,NMI)
colormap cool
colorbar('location','EastOutside')
ylabel(colorbar,'Mutual Information(MI)')
xlabel('lg¦Ë')
ylabel('lg¦Â')
figure(2)
contourf(lambda,beta,AC)
colormap cool
colorbar('location','EastOutside')
ylabel(colorbar,'Accuracy(AC)')
xlabel('lg¦Ë')
ylabel('lg¦Â')
