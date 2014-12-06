A=[0 1;0 -1];B=[0;1];Bd=[0 0;1 0];
Ch=[1 0];Dh=0;Dhd=[0 -1];
C=[1 0;0 0];D=[0;0];Dd=[0 0;0 1];
X=-inv([A B;Ch Dh])*[Bd;Dhd];Pi=X(1:2,:);Ga=X(3:end,:);
p=[-2+i;-2-i];F=place(A,B,p);G=Ga+F*Pi;
Ae=[A Bd;zeros(2,4)];Be=[B;zeros(2,1)];Ce=[C Dd];Fe=[F -G];
L=place(Ae',Ce',[-10 -11 -12 -13])';
z=[0 0];sys=ss(A,[Bd B],[Ch;z;C],[z Dh;z 1;Dd D]);
co=ss(Ae-L*Ce-Be*Fe+L*D*Fe,L,Fe,0);
cl=lft(sys,-co)
t=linspace(0,25,1e3)';
d=1*(t>0&t<4)+2*(t>4&t<8)+4*(t>8&t<12)+0*(t>12);
r=square(t/1.5);[y,to]=lsim(cl,[d r],t);
plot(to, y(:,1), to, y(:,2))
