load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\nas\nas-li20-pm00\E200\2014\20141213\E200_14321\E200_14321.mat');
%%
header='C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data';
n_imgs=data.raw.images.IP2A.N_IMGS;
pixelsum=zeros(1,n_imgs);
x_low=50;
x_high=400;
y_low=160;
y_high=270;
x_range=x_high-x_low+1;
y_range=y_high-y_low+1;
x_np=data.raw.images.IP2A.ROI_XNP(1);
x_projection=zeros(n_imgs,x_range);
y_np=data.raw.images.IP2A.ROI_YNP(1);
y_projection=zeros(n_imgs,y_range);
shot=177;




for i=1:n_imgs
    x=imread([header data.raw.images.IP2A.dat{i}]);
    y=x(y_low:y_high,x_low:x_high);
    %imagesc(y);
    caxis([0 50]);
    %pause(1);
    pixelsum(i)=sum(y(:));
    x_projection(i,:)=mean(y,1);
    y_projection(i,:)=mean(y,2);  
end
%%
res=data.raw.images.IP2A.RESOLUTION(1);
figure(1);
plot(pixelsum,'*');
title('Pixel Sum for each shot (ODR) IP = 0.370 mm');
xlabel('Shot Number');
ylabel('Pixel Sum');

saveas(1, '../Figures/Pixelsum_ODR_370', 'png');


shotx=shot;
max_x=max(x_projection(shotx,:));
frac_maxx=0.2;
good_xproj=[];
xaxis1=linspace(1*res,x_range*res,x_range);
good_xaxis1=[];
for i=1:x_range
    if x_projection(shotx,i)>frac_maxx*max_x
        good_xproj=[good_xproj,x_projection(shotx,i)];
        good_xaxis1=[good_xaxis1,xaxis1(i)];
    end
end


logx_proj=log(good_xproj(1,:));

[Coeff]=polyfit(good_xaxis1,logx_proj,2);
sig=sqrt(-1/(2*Coeff(1)));
mu=Coeff(2)*sig^2;
A=exp(Coeff(3)+mu^2/(2*sig^2));

Gauss_xproj=A*exp(-(good_xaxis1-mu).^2/(2*sig^2));


figure(2);
plot(xaxis1,x_projection(shotx,:));
hold on;
plot(good_xaxis1,Gauss_xproj,'-r');
title('Projected x Intensity (ODR) IP = 0.370 mm');
xlabel('x (microns)');
ylabel('Intensity');
hold off;

saveas(2, '../Figures/ProjX_ODR_370', 'png');

xaxis1_14321=xaxis1;
x_projection_14321=x_projection(shotx,:);
good_xaxis1_14321=good_xaxis1;
Gauss_xproj_14321=Gauss_xproj;

sig_total=0;
mu_nimgs_14321=[];
sig_nimgs_14321=[];
for j=1:n_imgs
max_x=max(x_projection(j,:));
frac_maxx=0.2;
good_xproj=[];
xaxis1=linspace(1*res,x_range*res,x_range);
good_xaxis1=[];
for i=1:x_range
    if x_projection(j,i)>frac_maxx*max_x
        good_xproj=[good_xproj,x_projection(j,i)];
        good_xaxis1=[good_xaxis1,xaxis1(i)];
    end
end


logx_proj=log(good_xproj(1,:));

[Coeff]=polyfit(good_xaxis1,logx_proj,2);
sig=sqrt(-1/(2*Coeff(1)));
mu=Coeff(2)*sig^2;
A=exp(Coeff(3)+mu^2/(2*sig^2));
mu_nimgs_14321=[mu_nimgs_14321,mu];
sig_nimgs_14321=[sig_nimgs_14321,sig];
sig_total=sig_total+sig;

Gauss_xproj=A*exp(-(good_xaxis1-mu).^2/(2*sig^2));
end

sig_14321=sig_total/n_imgs;

A_total=0;
for i=1:n_imgs
  A_0=max(y_projection(shot,:));
  A_total=A_0+A_total;
end
A_14321=A_total/n_imgs;

[A,a]=max(y_projection(shot,:));
shoty=shot;
max_y=max(y_projection(shoty,:));
frac_maxy=0.2;
good_yproj=[];
xaxis2=linspace(1*res,y_range*res,y_range);
good_xaxis2=[];
for i=a:y_range
    if y_projection(shoty,i)>frac_maxy*max_y
        good_yproj=[good_yproj,y_projection(shoty,i)];
        good_xaxis2=[good_xaxis2,xaxis2(i)];
    end
end

logy_proj=log(good_yproj(1,:));
[Coeff2]=polyfit(good_xaxis2,logy_proj,2);
sig2=sqrt(-1/(2*Coeff2(1)));
mu2=Coeff2(2)*sig2^2;
A2=exp(Coeff2(3)+mu2^2/(2*sig2^2));

Gauss_yproj=A2*exp(-(good_xaxis2-mu2).^2/(2*sig2^2));



figure(3);
plot(xaxis2,y_projection(shoty,:));
hold on;
plot(good_xaxis2,Gauss_yproj,'-r');
title('Projected y Intensity (ODR) IP = 0.370 mm');
xlabel('y (microns)');
ylabel('Intensity');
hold off;

saveas(3, '../Figures/ProjY_ODR_370', 'png');

figure(4);
imagesc(x_projection);
title('Waterfall Projected x Intensity (ODR) IP = 0.370 mm');
xlabel('Pixel');
ylabel('Shot Number');

saveas(4, '../Figures/ProjX_wfall_ODR_370', 'png');

figure(5);
imagesc(y_projection);
title('Waterfall Projected y Intensity (ODR) IP = 0.370 mm');
xlabel('Pixel');
ylabel('Shot Number');

saveas(5, '../Figures/ProjY_wfall_ODR_370', 'png');


n_imgs_otr=data.raw.images.USOTR.N_IMGS;
pixelsum_otr=zeros(1,n_imgs_otr);
x_low_otr=100;
x_high_otr=300;
y_low_otr=100;
y_high_otr=220;
x_range_otr=x_high_otr-x_low_otr+1;
y_range_otr=y_high_otr-y_low_otr+1;
x_np_otr=data.raw.images.USOTR.ROI_XNP(1);
x_projection_otr=zeros(n_imgs_otr,x_range_otr);
y_np_otr=data.raw.images.USOTR.ROI_YNP(1);
y_projection_otr=zeros(n_imgs_otr,y_range_otr);




for i=1:n_imgs_otr
    x_otr=imread([header data.raw.images.USOTR.dat{i}]);
    y_otr=x_otr(y_low_otr:y_high_otr,x_low_otr:x_high_otr);
    %imagesc(y);
    %pause(1);
    pixelsum_otr(i)=sum(y_otr(:));
    x_projection_otr(i,:)=mean(y_otr,1);
    y_projection_otr(i,:)=mean(y_otr,2);  
end
%%
res_otr=data.raw.images.USOTR.RESOLUTION(1);
figure(6);
plot(pixelsum_otr,'*');
title('Pixel Sum for each shot (OTR) IP = 0.370 mm');
xlabel('Shot Number');
ylabel('Pixel Sum');

saveas(6, '../Figures/PixelSum_OTR_370', 'png');

shotx=shot;
max_x_otr=max(x_projection_otr(shotx,:));
frac_maxx_otr=0.2;
good_xproj_otr=[];
xaxis1_otr=linspace(1*res_otr,x_range_otr*res_otr,x_range_otr);
good_xaxis1_otr=[];
for i=1:x_range_otr
    if x_projection_otr(shotx,i)>frac_maxx_otr*max_x_otr
        good_xproj_otr=[good_xproj_otr,x_projection_otr(shotx,i)];
        good_xaxis1_otr=[good_xaxis1_otr,xaxis1_otr(i)];
    end
end


logx_proj_otr=log(good_xproj_otr(1,:));

[Coeff_otr]=polyfit(good_xaxis1_otr,logx_proj_otr,2);
sig_otr=sqrt(-1/(2*Coeff_otr(1)));
mu_otr=Coeff_otr(2)*sig_otr^2;
A_otr=exp(Coeff_otr(3)+mu_otr^2/(2*sig_otr^2));

Gauss_xproj_otr=A_otr*exp(-(good_xaxis1_otr-mu_otr).^2/(2*sig_otr^2));


figure(7);
plot(xaxis1_otr,x_projection_otr(shotx,:));
hold on;
plot(good_xaxis1_otr,Gauss_xproj_otr,'-r');
title('Projected x Intensity (OTR) IP = 0.370 mm');
xlabel('x (microns)');
ylabel('Intensity');
hold off;

saveas(7, '../Figures/ProjX_OTR_370', 'png');

shoty=shot;
max_y_otr=max(y_projection_otr(shoty,:));
frac_maxy_otr=0.2;
good_yproj_otr=[];
xaxis2_otr=linspace(1*res_otr,y_range_otr*res_otr,y_range_otr);
good_xaxis2_otr=[];
for i=1:y_range_otr
    if y_projection_otr(shoty,i)>frac_maxy_otr*max_y_otr
        good_yproj_otr=[good_yproj_otr,y_projection_otr(shoty,i)];
        good_xaxis2_otr=[good_xaxis2_otr,xaxis2_otr(i)];
    end
end

logy_proj_otr=log(good_yproj_otr(1,:));
[Coeff2_otr]=polyfit(good_xaxis2_otr,logy_proj_otr,2);
sig2_otr=sqrt(-1/(2*Coeff2_otr(1)));
mu2_otr=Coeff2_otr(2)*sig2_otr^2;
A2_otr=exp(Coeff2_otr(3)+mu2_otr^2/(2*sig2_otr^2));

Gauss_yproj_otr=A2_otr*exp(-(good_xaxis2_otr-mu2_otr).^2/(2*sig2_otr^2));


sig_total_otr=0;
mu_nimgs_otr_14321=[];
sig_nimgs_otr_14321=[];
for j=1:n_imgs_otr
max_x_otr=max(x_projection_otr(j,:));
frac_maxx_otr=0.2;
good_xproj_otr=[];
xaxis1_otr=linspace(1*res_otr,x_range_otr*res_otr,x_range_otr);
good_xaxis1_otr=[];
for i=1:x_range_otr
    if x_projection_otr(j,i)>frac_maxx_otr*max_x_otr
        good_xproj_otr=[good_xproj_otr,x_projection_otr(j,i)];
        good_xaxis1_otr=[good_xaxis1_otr,xaxis1_otr(i)];
    end
end


logx_proj_otr=log(good_xproj_otr(1,:));

[Coeff_otr]=polyfit(good_xaxis1_otr,logx_proj_otr,2);
sig_otr=sqrt(-1/(2*Coeff_otr(1)));
mu_otr=Coeff_otr(2)*sig_otr^2;
mu_nimgs_otr_14321=[mu_nimgs_otr_14321,mu_otr];
A_otr=exp(Coeff_otr(3)+mu_otr^2/(2*sig_otr^2));
sig_nimgs_otr_14321=[sig_nimgs_otr_14321,sig_otr];
sig_total_otr=sig_total_otr+sig_otr;

Gauss_xproj_otr=A_otr*exp(-(good_xaxis1_otr-mu_otr).^2/(2*sig_otr^2));
end

sig_otr_14321=sig_total_otr/n_imgs_otr;


figure(8);
plot(xaxis2_otr,y_projection_otr(shoty,:));
hold on;
plot(good_xaxis2_otr,Gauss_yproj_otr,'-r');
title('Projected y Intensity (OTR) IP = 0.370 mm');
xlabel('y (microns)');
ylabel('Intensity');
hold off;

saveas(8, '../Figures/ProjY_OTR_370', 'png');

figure(9);
imagesc(x_projection_otr);
title('Waterfall Projected x Intensity (OTR) IP = 0.370 mm');
xlabel('Pixel');
ylabel('Shot Number');

saveas(9, '../Figures/ProjX_wfall_OTR_370', 'png');

figure(10);
imagesc(y_projection_otr);
title('Waterfall Projected y Intensity (OTR) IP = 0.370 mm');
xlabel('Pixel');
ylabel('Shot Number');

saveas(10, '../Figures/ProjY_wfall_OTR_370', 'png');

figure(11);
x=imread([header data.raw.images.IP2A.dat{shot}]);
y=x(y_low:y_high,x_low:x_high);
imagesc(y);
caxis([0 50]);
title('Sample ODR Shot IP = 0.370 mm');
xlabel('Pixel');
ylabel('Pixel');

saveas(11, '../Figures/Sample_ODR_370', 'png');

figure(12);
x_otr=imread([header data.raw.images.USOTR.dat{i}]);
y_otr=x_otr(y_low_otr:y_high_otr,x_low_otr:x_high_otr);
imagesc(y_otr);
title('Sample OTR Shot IP = 0.370 mm');
xlabel('Pixel');
ylabel('Pixel');

saveas(12, '../Figures/Sample_OTR_370', 'png');

figure(13);
plot(sig_nimgs_14321,'*');
title('Image Width for each shot (ODR) IP = 0.370 mm');
xlabel('Shot Number');
ylabel('Image Width (microns)');

saveas(13, '../Figures/ImageWidth_ODR_370', 'png');

figure(14);
plot(sig_nimgs_otr_14321,'*');
title('Image Width for each shot (OTR) IP = 0.370 mm');
xlabel('Shot Number');
ylabel('Image Width (microns)');

saveas(14, '../Figures/ImageWidth_OTR_370', 'png');

figure(15);
plot(sig_nimgs_otr_14321,sig_nimgs_14321,'*');
title('Image Width for each shot (OTR) IP = 0.370 mm');
xlabel('Image Width OTR (microns)');
ylabel('Image Width ODR (microns)');

saveas(15, '../Figures/ImageWidth_OTRODR_370', 'png');

figure(16);
plot(mu_nimgs_otr_14321,mu_nimgs_14321,'*');
title('Image Width for each shot (OTR) IP = 0.370 mm');
xlabel('Beam Center X Position OTR (microns)');
ylabel('Beam Center X Position ODR (microns)');

saveas(16, '../Figures/XPosition_OTRODR_370', 'png');



muy_nimgs_14321=[];
for i=1:n_imgs
[A,a]=max(y_projection(i,:));
shoty=shot;
max_y=max(y_projection(i,:));
frac_maxy=0.2;
good_yproj=[];
xaxis2=linspace(1*res,y_range*res,y_range);
good_xaxis2=[];
for j=a:y_range
    if y_projection(i,j)>frac_maxy*max_y
        good_yproj=[good_yproj,y_projection(i,j)];
        good_xaxis2=[good_xaxis2,xaxis2(j)];
    end
end

logy_proj=log(good_yproj(1,:));
[Coeff2]=polyfit(good_xaxis2,logy_proj,2);
sig2=sqrt(-1/(2*Coeff2(1)));
mu2=Coeff2(2)*sig2^2;
A2=exp(Coeff2(3)+mu2^2/(2*sig2^2));

muy_nimgs_14321=[muy_nimgs_14321,mu2];

Gauss_yproj=A2*exp(-(good_xaxis2-mu2).^2/(2*sig2^2));

end

muy_nimgs_otr_14321=[];
for i=1:n_imgs_otr
[A_otr,a_otr]=max(y_projection_otr(i,:));
max_y_otr=max(y_projection_otr(i,:));
frac_maxy_otr=0.2;
good_yproj_otr=[];
xaxis2_otr=linspace(1*res_otr,y_range_otr*res_otr,y_range_otr);
good_xaxis2_otr=[];
for j=1:y_range_otr
    if y_projection_otr(i,j)>frac_maxy_otr*max_y_otr
        good_yproj_otr=[good_yproj_otr,y_projection_otr(i,j)];
        good_xaxis2_otr=[good_xaxis2_otr,xaxis2_otr(j)];
    end
end

logy_proj_otr=log(good_yproj_otr(1,:));
[Coeff2_otr]=polyfit(good_xaxis2_otr,logy_proj_otr,2);
sig2_otr=sqrt(-1/(2*Coeff2_otr(1)));
mu2_otr=Coeff2_otr(2)*sig2_otr^2;
A2_otr=exp(Coeff2_otr(3)+mu2_otr^2/(2*sig2_otr^2));

muy_nimgs_otr_14321=[muy_nimgs_otr_14321,mu2_otr];

Gauss_yproj_otr=A2_otr*exp(-(good_xaxis2_otr-mu2_otr).^2/(2*sig2_otr^2));

end

figure(17);
plot(muy_nimgs_otr_14321,muy_nimgs_14321,'*');
axis([min(muy_nimgs_otr_14321) max(muy_nimgs_otr_14321) 0 3500]);
title('Image Width for each shot (OTR) IP = 0.370 mm');
xlabel('Beam Center Y Position OTR (microns)');
ylabel('Beam Center Y Position ODR (microns)');

saveas(17, '../Figures/YPosition_OTRODR_370', 'png');