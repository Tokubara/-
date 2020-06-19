function H=hilbMatrix(n)
if(n<=0 || abs(round(n)-n)>1E-5),error('n不是正整数');end
H=zeros(n,n);
for(i=1:n)
    for(j=1:n)
        H(i,j)=1/(i+j-1);
    end
end