function x=solveSPD(A,b)
    %这里没有错误判断，错误判断在各个函数中
    L=cholesky(A);
    x1=solveL(L,b); %得到了L'x
    x=solveU(L',x1);
