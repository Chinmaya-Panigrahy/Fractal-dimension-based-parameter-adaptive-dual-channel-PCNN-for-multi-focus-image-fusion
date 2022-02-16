% If you use this code, then please cite our following paper:
% Fractal dimension based parameter adaptive dual channel PCNN for multi-focus image fusion. 
% Optics and Lasers in Engineering 133 (2020): 106141.

clear all


        img1=imread('lytro-05-A.jpg'); %First Source image 
        img2=imread('lytro-05-B.jpg'); %Second Source image 

        tic
        
        img1= double(img1)/255;%Image Normalization
        img2= double(img2)/255;%Image Normalization
        imgf=zeros(size(img1));

    for i=1:3
        imgf(:,:,i) =FUSION_NSCT_ABS_MSMFM_DBC_PADCPCNN(img1(:,:,i),img2(:,:,i));
        
    end
       
        F=uint8(imgf*255);%Image Standardization
       
        figure, imshow(F)
        
    


