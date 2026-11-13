# Shared conventional proof

## Shared theorem
Let b_0=4,b_1=6,b_2=9 and b_n=b_(n-1)+b_(n-3) for n>=3. For t=3,4 let u_t(n)=b_n+t. Then u_3=L(7,9) and u_4=L(8,10). Both satisfy

 a_n=2a_(n-1)-a_(n-2)+a_(n-3)-a_(n-4), n>=4.

The same recurrence holds for L(6,7) and L(7,8), including n=4.

## Proof
All b_n are positive by induction. Define q_m=2b_(m+4)-9b_m. Direct substitution gives q_0=q_1=2,q_2=1. For m>=3, linearity and the recurrence give q_m=q_(m-1)+q_(m-3). Hence q_m>0 for every m>=0, and 2b_(m+4)>9b_m.

For n>=2 put x_n=(b_n,b_(n-1),b_(n-2)). Its transition is A=[[1,0,1],[1,0,0],[0,1,0]]. For n>=3 set W_n=x_n wedge x_(n-1), in coordinate order (01,02,12), with the later vector first. Its first coordinate is H_n=b_n b_(n-2)-b_(n-1)^2. Expanding each minor proves, for arbitrary vectors v,w,

 (Av)_i(Aw)_j-(Av)_j(Aw)_i
 = sum_(k<l) (A_ik A_jl-A_il A_jk)(v_k w_l-v_l w_k).

Thus W_(n+1)=M W_n, where

 M=[[0,-1,0],[1,0,-1],[1,0,0]],
 M^4=[[1,-1,-1],[2,1,-1],[1,1,0]].

The absolute row sums of M^4 are 3,4,2, so ||W_(n+4)||_infinity <=4||W_n||_infinity. The exact initial certificate is:

|n|W_n|norm|b_(n-6)|
|--|--|--|--|
|13|(-21,-7,5)|21|60|
|14|(7,-26,-21)|26|88|
|15|(26,28,7)|28|129|
|16|(-28,19,26)|28|189|

In each case 2||W_n||<b_(n-6). If this holds at n>=13, then

 2||W_(n+4)|| <=8||W_n|| <4b_(n-6)
 <(9/2)b_(n-6)<b_(n-2).

The last comparison is the growth inequality at m=n-6. Every n>=13 is uniquely 13+r+4k, 0<=r<4. Induction in each residue class proves 2||W_n||<b_(n-6) for every n>=13.

For n>=6 the recurrence gives

 b_n+b_(n-2)-2b_(n-1)
 =b_(n-3)-b_(n-4)=b_(n-6).

Expanding the shifted determinant therefore yields

 D_t(n)=(b_n+t)(b_(n-2)+t)-(b_(n-1)+t)^2
       =H_n+t b_(n-6).

For n>=13, write B=b_(n-6)>0. The invariant implies

 (t-1/2)B < D_t(n) < (t+1/2)B <= (9/2)B
 < b_(n-2) < b_(n-2)+t.

Thus 0<D_t(n)<u_t(n-2). The remaining cases are exact integers:

|n|D_3|u_3(n-2)|D_4|u_4(n-2)|
|--|--|--|--|--|
|2|3|7|4|8|
|3|0|9|1|10|
|4|8|12|10|13|
|5|12|16|15|17|
|6|7|22|11|23|
|7|17|31|23|32|
|8|35|44|44|45|
|9|35|63|48|64|
|10|48|91|67|92|
|11|96|132|124|133|
|12|128|192|169|193|

Every row satisfies 0<=D_t(n)<u_t(n-2). The only zero is D_3(3)=16*9-12^2=0; the tail is strictly positive.

For integer h,p and positive integer q, h=ceil(p/q) iff 0<=hq-p<q. Apply this with h=u_t(n), p=u_t(n-1)^2, q=u_t(n-2). Positivity was proved independently. The candidates therefore obey the original nonlinear ceiling recurrence. Their initial pairs are (7,9) and (8,10); uniqueness by successive evaluation identifies them with the original ceiling-defined sequences, not merely a matching finite prefix.

For n>=3, u_t(n)=u_t(n-1)+u_t(n-3)-t. Subtracting consecutive instances proves the fourth-order recurrence for n>=4.

## Shift consequences and the boundary index
The first three terms of L(6,7) are 6,7,ceil(49/6)=9, and those of L(7,8) are 7,8,ceil(64/7)=10. The one-step tails obey the same nonlinear rule and have the initial pairs just proved. Uniqueness gives L(6,7)(n+1)=u_3(n) and L(7,8)(n+1)=u_4(n) for all n>=0.

The recurrence for these tails implies the requested recurrence for each prefixed sequence at n>=5. At the remaining index n=4, their first five terms are respectively (6,7,9,12,16) and (7,8,10,13,17). Directly,

 16=2*12-9+7-6, and 17=2*13-10+8-7.

This completes the conventional proof for all four sequences and all required indices.

