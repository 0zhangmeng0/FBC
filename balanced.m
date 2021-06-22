function flag=balance(label)
flag=0;
nClass=length(unique(label));
[num,~]=size(label(label==label(1)));
a=0;
for i=1:nClass
    [c1,~]=size(label(label==label(i)));
    if num==c1
        nClass=nClass-1;
    end
end
if ~nClass
    flag=1;
end