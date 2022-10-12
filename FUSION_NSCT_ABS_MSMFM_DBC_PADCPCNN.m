function [F]=FUSION_NSCT_ABS_MSMFM_DBC_PADCPCNN(A,B)

addpath(genpath('nsct_toolbox'));

pfilt = '9-7';
dfilt = 'pkva';
nlevs = [0,1,3,4,4];
scalemsmfm=5;
nsctA=nsctdec(A,nlevs,dfilt,pfilt); % NSCT Decompostion of A
nsctB=nsctdec(B,nlevs,dfilt,pfilt); % NSCT Decompostion of B

n = length(nsctA); %Number of 2nd dimension cell array
Fused=nsctA;          %Intialized with the coefficient size


%Fusion of low-pass sub-bands
ALow1= nsctA{1};
BLow1 =nsctB{1};
msmfmA1=multiscale_morph(ALow1,scalemsmfm);
msmfmB1=multiscale_morph(BLow1,scalemsmfm);
A1=dbcbox(ALow1,3);
B1=dbcbox(BLow1,3);
map1=(A1.*msmfmA1>=B1.*msmfmB1);
Fused{1}=map1.*ALow1+~map1.*BLow1; 
        

%Fusion of band-pass directional sub-bands
Ahigh=nsctA{2};
Bhigh=nsctB{2};
AH=abs(Ahigh);
BH=abs(Bhigh);
map=PADCPCNN(AH,BH);
Fused{2}=map.*Ahigh+~map.*Bhigh;
for i = 3:n
    for d = 1:length(nsctA{i})
        Ahigh = nsctA{i}{d};
        Bhigh = nsctB{i}{d};
        AH=abs(Ahigh);
        BH=abs(Bhigh);
        map=PADCPCNN(AH,BH);
        Fused{i}{d}=map.*Ahigh+~map.*Bhigh;                  
    end
end
F=nsctrec(Fused, dfilt, pfilt);
end








