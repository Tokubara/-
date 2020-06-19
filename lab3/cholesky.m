function A=cholesky(A)
%首先需要判定一下A是不是对称正定的
if(size(A,1)~=size(A,2)), error('A不是方阵');end
if(~isequal(A,A.')),error('A不是对称矩阵');end
eig_A=eig(A);
if(any(eig_A<0)|any(eig_A-0)<1E-5),error('A不是正定的');end
%现在开始进行分解
n=size(A,1);
% L=zeros(n,n);
%似乎单独写出来第一列的求解
for(i=1:n)
A(i,i)=sqrt(A(i,i)-sum(A(i,1:(i-1)).^2));
% sub_L=L((i+1):n,1:(i-1)); %其实这样也比较费内存
% sub_x=L(i,1:(i-1));
% tmp=A(i,(i+1):n);
for(j=1:(i-1))
    A((i+1):n,i)=A((i+1):n,i)-A(i,j)*A((i+1):n,j);
end
A((i+1):n,i)=A((i+1):n,i)/A(i,i);
A(1:(i-1),i)=0;
end
%希望再改成原地的