clear all;
close all;
X = load('data3.txt');
scatter(X(:,1),X(:,2));
D_Eu = pdist(X, 'euclidean');
D_Ma = pdist(X, 'mahalanobis');
D_Mi = pdist(X, 'minkowski', 4);
C_Eu_Com = linkage(X, 'complete');
C_Eu_Med = linkage(X, 'median');
C_Eu_Sin = linkage(X, 'single');
C_Ma_Com = linkage(X, 'complete', 'mahalanobis');
C_Ma_Med = linkage(X, 'median', 'mahalanobis');
C_Ma_Sin = linkage(X, 'single', 'mahalanobis');
C_Mi_Com = linkage(D_Mi, 'complete');
C_Mi_Med = linkage(D_Mi, 'median');
C_Mi_Sin = linkage(D_Mi, 'single');
D_arr  = [D_Eu; D_Ma; D_Mi];
A = c_arr_function(C_Eu_Com, C_Eu_Med, C_Eu_Sin, C_Ma_Com, C_Ma_Med, C_Ma_Sin, C_Mi_Com, C_Mi_Med, C_Mi_Sin);
KKM = zeros(3,3);
j=1;
i=1;
m=0;
for j=1:3
    for i=1:3
       KKM(i,j)=cophenet(A(:,:,i+m*3),D_arr(j,:));
    end;
    m=m+1;
end;
figure;
dendrogram(C_Ma_Com);
T = cluster(C_Ma_Com, 'maxclust', 4);
P= zeros(1,2);
M= zeros(7,2,4);
k = 1;
for i = 1:4
    for j = 1:28
        if T(j)==i
           P(k,1) = X(j,1);
           P(k,2) = X(j,2);
           k=k+1;
        end;
    end;
    M(:,:,i)=P;
    P=[];
    k=1;
end;
Mean = []
for i = 1:4
    Mean(i,:)=mean(M(:,:,i));
    Std_arr(i,:) = std(M(:,:,i)).^2;
end
for i = 1:4
    M(8,:,i) = Mean(i,:);
    U = pdist(M(:,:,i));
    Z(:,:,i) = squareform(U);
end
figure;
hold on;

gscatter(X(:,1),X(:,2), T);
scatter(Mean(:,1), Mean(:,2));


