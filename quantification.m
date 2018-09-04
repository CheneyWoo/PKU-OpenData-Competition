function G = quantification(X)
n = length(X)
x_aver = sum(X)/n;
a = [];
b = [];
for i = 1:n
    a(i) = (X(i)-x_aver)/(max(X)-min(X));
    temp = [abs(X(i)-x_aver),X(i),x_aver];
    b(i) = abs(X(i)-x_aver)/max(temp);
    G(i) = X(i)*b(i)/100 + a(i);
end

    