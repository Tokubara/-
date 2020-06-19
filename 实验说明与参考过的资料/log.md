1.3

题我犯的错误

(1)

理论分析用的不是single类型，而是用了默认的double

```matlab
s_=0;
for(j=1:10000000)
    s_=s_+1/j;
if(2^24/(j+1)<s_)
    break
    end
end
s_
j
```

结果为：

```
s_ =

  14.536111592691070


j =

     1154174
```

实际上应该用single



思考题：如何验证是截断还是就近？从机器精度判断就可以

```
1+2^(-53)>1
```

结果是FALSE，看来是截断存储？



是否矛盾？

```matlab
s_=single(0);
for(j=1:10000000)
    s_=s_+1/j;
if(2^25/(j+1)<s_)
    break
    end
end
s_
j
```

从这里看到，机器精度是2^23的呀



##### |#0 判断矩阵是否可约

为什么有这个需求？写lab4的时候，我觉得首先能说明一下收敛性更好，

搜索matrix irreducible

A [matrix](https://en.wikipedia.org/wiki/Matrix_(mathematics)) is irreducible if it is not [similar](https://en.wikipedia.org/wiki/Similar_matrix) via a [permutation](https://en.wikipedia.org/wiki/Permutation_matrix) to a [block](https://en.wikipedia.org/wiki/Block_matrix) [upper triangular matrix](https://en.wikipedia.org/wiki/Upper_triangular_matrix) (that has more than one block of positive size). (Replacing non-zero entries in the matrix by one, and viewing the matrix as the adjacency matrix of a [directed graph](https://en.wikipedia.org/wiki/Directed_graph), the matrix is irreducible if and only if such directed graph is [strongly connected](https://en.wikipedia.org/wiki/Connectivity_(graph_theory)).)

如果是这里这样，用1替代，那么负数似乎是无关紧要的

因此是的，是不可约的



##### |#1 实验一结果抖动的原因

之前是这个：

```matlab
format long
eps=1E-16;
M=1;
h=logspace(-16,0,33);
true=cos(1);

loglog(h,2*eps./h,'--',h,M*h/2,'--',h,true-(sin(1+h)-sin(1))./h,'-')
legend()
axis([1E-16 1 1E-17 1])
```

要把`true-(sin(1+h)-sin(1))./h`改成`abs(true-(sin(1+h)-sin(1))./h)`

至于原因，是因为有时误差是>0的，有时候是<0的，作图的axis却又要求>0



##### |#2 记录一个可笑的错误

我们知道FPI说收敛，|一阶导|<1，我在用牛顿法就这样，就是求了解这个点上的一阶导。sb，那个一阶导是说FPI的函数的一阶导，不是求根函数。对Newton是x-f(x)/f’(x)，一阶导为0恒成立



##### |#3 R的报错

```R
A=generateA(0.0001,0.5,100) #由于ε也可变，可以在外面再做一次封装。
#需要测试的omega
omega=seq(0.05,1.95,by=0.05)
res<-sapply(omega,function(ome)error_count(A=A,mode=3,omega = ome))
```

感觉挺对的

报错

```
number of items to replace is not a multiple of replacement length
```

读起来像是说，用向量去作用在函数上？

```R
claims$newprocall <-claims$newproc.x
claims$newprocall[is.na(claims$newproc.x)] <- reducedclaims$newproc.y
```

是这种问题，但是我是哪里的问题？

没啥问题，有句话改删的没删，以及如果遇到error，就直接中断了，再也运行，解决办法是改为返回-1



##### #4 SOR:ω=1.25到底收不收敛？

首先在(2)中，是收敛的(包括了0.0001)

但是到了画图的时候，根本不收敛

SOR可没有随机性，就应该是确定的

