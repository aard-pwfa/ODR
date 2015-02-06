%%load('/nas/nas-li20-pm00/E200/2014/20141213/E200_14296/E200_14316.mat');
load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\nas\nas-li20-pm00\E200\2014\20141213\E200_14320\E200_14320.mat');
%%
header='C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data';
n_imgs=data.raw.images.IP2A.N_IMGS;
pixelsum=zeros(1,n_imgs);
x_low=1;
x_high=538;
y_low=1;
y_high=400;
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
    %pause(1);
    pixelsum(i)=sum(y(:));
    x_projection(i,:)=mean(y,1);
    y_projection(i,:)=mean(y,2);  
end
%%
res=data.raw.images.IP2A.RESOLUTION(1);
figure(1);
plot(pixelsum,'*');
title('BETAL Pixel Sum for each shot (ODR)');
xlabel('Shot Number');
ylabel('Pixel Sum');


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
title('Projected x Intensity (ODR)');
xlabel('x (microns)');
ylabel('Intensity');
hold off;

shoty=shot;
max_y=max(y_projection(shoty,:));
frac_maxy=0.2;
good_yproj=[];
xaxis2=linspace(1*res,y_range*res,y_range);
good_xaxis2=[];
for i=1:y_range
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
title('Projected y Intensity (ODR)');
xlabel('y (microns)');
ylabel('Intensity');
hold off;


figure(4);
imagesc(x_projection);
title('Waterfall Projected x Intensity (ODR)');
xlabel('Pixel');
ylabel('Shot Number');

figure(5);
imagesc(y_projection);
title('Waterfall Projected y Intensity (ODR)');
xlabel('Pixel');
ylabel('Shot Number');



n_imgs_otr=data.raw.images.USOTR.N_IMGS;
pixelsum_otr=zeros(1,n_imgs_otr);
x_low_otr=1;
x_high_otr=300;
y_low_otr=1;
y_high_otr=300;
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
title('BETAL Pixel Sum for each shot (OTR)');
xlabel('Shot Number');
ylabel('Pixel Sum');


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
title('Projected x Intensity (OTR)');
xlabel('x (microns)');
ylabel('Intensity');
hold off;

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



figure(8);
plot(xaxis2_otr,y_projection_otr(shoty,:));
hold on;
plot(good_xaxis2_otr,Gauss_yproj_otr,'-r');
title('Projected y Intensity (OTR)');
xlabel('y (microns)');
ylabel('Intensity');
hold off;


figure(9);
imagesc(x_projection_otr);
title('Waterfall Projected x Intensity (OTR)');
xlabel('Pixel');
ylabel('Shot Number');

figure(10);
imagesc(y_projection_otr);
title('Waterfall Projected y Intensity (OTR)');
xlabel('Pixel');
ylabel('Shot Number');