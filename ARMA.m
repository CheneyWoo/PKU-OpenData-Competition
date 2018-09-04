clear
clc
a = nonzeros([4.351 4.342 4.261 4.150 3.887 3.923 3.678 3.637 3.755 3.676 3.327 3.256 3.659 3.401 3.171 3.169 3.239 3.144 2.998]);
r11=autocorr(a);
r11'
r12=parcorr(a);
r12'
da=diff(a);
r21=autocorr(da);
r21'
r22=parcorr(da);
r21'
n=length(da);
for i=0:3
    for j=0:3
        spec=garchset('R',i,'M',j,'Display','off');
        [coeffX,errorsX,LLFX] = garchfit(spec,da);
        num=garchcount(coeffX);
        [aic,bic]=aicbic(LLFX,num,n);
        fprintf('R=%d,M=%d,AIC=%f,BIC=%f\n',i,j,aic,bic);
    end
end
r=input('???? R=');m=input('???? M=');
spec2= garchset('R',r,'M',m,'Display','off'); 
[coeffX,errorsX,LLFX] = garchfit(spec2,da)
[sigmaForecast,w_Forecast] = garchpred(coeffX,da,5)
x_pred=a(end)+cumsum(w_Forecast)