function R=PADCPCNN(A,B)

%Code for PADCPCNN
%Absolute values can be used
stdA=std2(A);
stdB=std2(B);
rstd=(stdA+stdB)/2;
alpha_u=log10(1.0/rstd); 
LA=max(A(:));
LB=max(B(:));

LAO=graythresh(A);LBO=graythresh(B);

xA=LA/LAO;
xB=LB/LBO;
xy=(LAO+LBO)/2;

lambda=((xA+xB)/2-1.0)/6;

V_E=exp(-alpha_u)+(xA+xB)/2;

Y=(1-exp(-3*alpha_u))/(1- exp(-alpha_u))+((xA+xB)/2-1)*exp(-alpha_u);
alpha_e=log(V_E / (xy * Y));

V_L=1.0;

betaA1=dbcbox(A,3);
betaB1=dbcbox(B,3);
xbetaA=1+betaA1-min(betaA1(:));
betaA=xbetaA./(max(betaA1(:))-min(betaA1(:))+2);
xbetaB=1+betaB1-min(betaB1(:));
betaB=xbetaB./(max(betaB1(:))-min(betaB1(:))+2);

iteration_times=110;

%DCPCNN

[p,q]=size(A);
F1=abs(A);
F2=abs(B);
U=zeros(p,q);
Y=zeros(p,q);
E=ones(p,q);


W=[0.5 1 0.5;1 0 1;0.5 1 0.5];

for n=1:iteration_times
    K = V_L*conv2(Y,W,'same');
    U1=F1.* (1 + betaA .* K);
    U2=F2.* (1 + betaB .* K);
    map=(U1>=U2);
    U3=map.*U1+~map.*U2;
    U = exp(-alpha_u) * U + U3;
    Y = im2double( U > E );
    E = exp(-alpha_e) * E + V_E * Y;
end

R =(U1>=U2);
end


