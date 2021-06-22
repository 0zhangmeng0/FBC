function num=count_class(label,nClass)
num=zeros(nClass,1);
for i=1:nClass
    [num(i),~]=size(label(label==i));
end
stem(num);
end