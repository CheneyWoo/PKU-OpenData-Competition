lng=xlsread('/Users/CheneyWu/Downloads/Trans_before2015.xlsx','B1:B3000');
lat=xlsread('/Users/CheneyWu/Downloads/Trans_before2015.xlsx','C1:C3000');
n=3000;
D = zeros(n,n);
Dis2 = [];
count = 1;
for i = 1:n-1
    for j = i+1:n
    D(i,j) = acos(sind(lat(i)).*sind(lat(j)).*cosd(lng(i)-lng(j))+cosd(lat(i)).*cosd(lat(j)));
    Dis2(count) = 6371004*D(i,j)*pi/180;
    count = count + 1;
    end
end
%xlswrite('/Users/CheneyWu/Downloads/result.csv',Dis2')
count