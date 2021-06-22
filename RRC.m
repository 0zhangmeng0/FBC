function [W, labels, E] = RRC(tr_dat, tr_labels, lambda)

%projection matrix computing
% Matlab中有两种矩阵除法符号：“＼”即左除和bai“／”即右除．如果A矩阵是非奇异方阵，则A\B是A的逆矩阵乘B，即inv(A)*B；而B/A是B乘A的逆矩阵，即B*inv(A)．具体计算时可不用逆du矩阵而直接计算．
% 通常：
% x=A\B就是A*x=B的解；
% x=B/A就是x*A=B的解.
if size(tr_dat,1) < size(tr_dat,2)
    Proj_M = tr_dat'/(tr_dat*tr_dat'+lambda*eye(length(tr_labels)));
else
    Proj_M = (tr_dat'*tr_dat+lambda*eye(size(tr_dat,2)))\tr_dat';
end
if isvector(tr_labels)
    Y = sparse(1:length(tr_labels), double(tr_labels), 1); Y = full(Y);
else
    Y = tr_labels;
end
W = Proj_M * Y;
%-------------------------------------------------------------------------
%testing
if nargout > 1
    [~,labels] = max(tr_dat*W, [], 2);
end
if nargout > 2
    E = sum(sum((Y - tr_dat*W).^2)) + lambda*sum(sum(W.^2));
end
