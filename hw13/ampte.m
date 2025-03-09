clear;
load ampte.dat
B = ampte_dat(:,2:4);

for j = 1:3
for i = 1:3
    M(i,j) = mean(B(:,i).*B(:,j)) - mean(B(:,i))*mean(B(:,j));
end
end
[V,D] = eigs(M)

X = B';
[E,D,P] = svd(X*X');
[V,D] = eigs(X*X')
P
