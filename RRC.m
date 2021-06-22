function [W, labels, E] = RRC(tr_dat, tr_labels, lambda)

%projection matrix computing
% Matlab�������־���������ţ����ܡ��������bai���������ҳ������A�����Ƿ����췽����A\B��A��������B����inv(A)*B����B/A��B��A������󣬼�B*inv(A)���������ʱ�ɲ�����du�����ֱ�Ӽ��㣮
% ͨ����
% x=A\B����A*x=B�Ľ⣻
% x=B/A����x*A=B�Ľ�.
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
