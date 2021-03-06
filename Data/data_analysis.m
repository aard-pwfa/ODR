%%load('/nas/nas-li20-pm00/E200/2014/20141213/E200_14296/E200_14316.mat');
load('C:\Users\Matthew\Documents\Matthew\Stanford\FACET\Data\E200_14316\E200_14316.mat');
%%
n_imgs=data.raw.images.USOTR.N_IMGS;
pixelsum=zeros(1,n_imgs);
x_low=25;
x_high=205;
y_low=75;
y_high=125;
x_range=x_high-x_low+1;
y_range=y_high-y_low+1;
x_np=data.raw.images.USOTR.ROI_XNP(1);
x_projection=zeros(n_imgs,x_range);
y_np=data.raw.images.USOTR.ROI_YNP(1);
y_projection=zeros(n_imgs,y_range);
shot=9;



for i=1:n_imgs
    x=imread(data.raw.images.USOTR.dat{i});
    y=x(y_low:y_high,x_low:x_high);
    %imagesc(y);
    %pause(1);
    pixelsum(i)=sum(y(:));
    x_projection(i,:)=mean(y,1);
    y_projection(i,:)=mean(y,2);  
end
%%
res=data.raw.images.USOTR.RESOLUTION(1);
figure(1);
plot(pixelsum,'*');
title('BETAL Pixel Sum for each shot');
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
title('Projected x Intensity');
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
title('Projected y Intensity');
xlabel('y (microns)');
ylabel('Intensity');
hold off;


figure(4);
imagesc(x_projection);
title('Waterfall Projected x Intensity');
xlabel('Pixel');
ylabel('Shot Number');

figure(5);
imagesc(y_projection);
title('Waterfall Projected y Intensity');
xlabel('Pixel');
ylabel('Shot Number');