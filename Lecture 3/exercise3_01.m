% Course OR
% Álvaro García Cerezo
% 2026
% Lecture 3
% Exercise 1

clear;
close all;
clc;

% Input data.
inputData = [0, 2, 7, 10, 3, 8, 9]';
k = 2; % Number of clusters

% Clustering.
[clusterID,centroids] = kmeans(inputData,k);
disp('Clusters of the representative time periods:');
disp(clusterID);
disp('Centroids of the clusters:');
disp(centroids);

% Compute the weights of the representative time periods.
weight = zeros(k,1);
for i = 1:k
    weight(i) = sum(clusterID == i);
end
% Check the values of the weights.
if sum(weight) ~= size(inputData,1)
    error('The weights are not correct.')
end
disp('Weights of the representative time periods:');
disp(weight);
