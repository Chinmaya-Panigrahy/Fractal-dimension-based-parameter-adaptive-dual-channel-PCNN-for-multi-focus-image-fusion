% If you use this code, then please cite our following paper:
% Fractal dimension based parameter adaptive dual channel PCNN for multi-focus image fusion. 
% Optics and Lasers in Engineering 133 (2020): 106141.

clear all


   
        img1=imread('clock1.bmp');%First Source image


        img2=imread('clock2.bmp');   %Second source image
        tic
        img1= double(img1)/255;%Image Normalization
        img2= double(img2)/255;%Image Normalization
        tic
        Fc=FUSION_NSCT_ABS_MSMFM_DBC_PADCPCNN(img1,img2); 
        toc
        F=uint8(Fc*255);%Image Standardization
      
        figure, imshow(F)
        
   

         

