% Course OR
% Álvaro García Cerezo
% 2026
% Lecture 3
% Exercise 5

clear;
close all;
clc;

% Input data.

k = 10; % Number of representative days

demand = xlsread('2015_f_load.xls','C5:C8764');
demandMax = max(demand);
demandMin = min(demand);

% Normalization.
demandNorm = (demand-demandMin)./(demandMax-demandMin);

% Transformation of the input data of each parameter into a matrix of 365 
% rows and 24 columns.
demandMatrixNorm = zeros(size(demandNorm,1)/24,24);
row = 1;
column = 0;
for i = 1:length(demandNorm)
    column = column + 1;
    if column == 25
        column = 1;
        row = row + 1;
    end
    demandMatrixNorm(row,column) = demandNorm(i);
end

% Clustering.
[clusterID,medoidsRDsNorm] = kmedoids(demandMatrixNorm,k);

% Undo the normalization.
medoidsRDs = (medoidsRDsNorm.*(demandMax-demandMin))+demandMin;

% Compute the weights of the representative days.
weight = zeros(k,1);
for i = 1:k
    weight(i) = sum(clusterID == i);
end
% Check the values of the weights.
if sum(weight) ~= size(demandMatrixNorm,1)
    error('The weights are not correct.')
end
disp('Weights of the representative days:');
disp(weight);

% Plot the results.
demandMatrix = (demandMatrixNorm.*(demandMax-demandMin))+demandMin;
figure;
plot(1:24,-1000*ones(24,1),'k-','LineWidth',1);
hold on;
plot(1:24,-1000*ones(24,1),'b-','LineWidth',2);
plot(1:24,demandMatrix,'k-','LineWidth',1);
plot(1:24,medoidsRDs,'b-','LineWidth',2);
set(gca,'FontSize',16);
xlabel('Time (h)','FontSize',18,'FontWeight','Bold'); 
ylabel('Demand level (MW)','FontSize',18,'FontWeight','Bold');
legend('Input data','Representative days','FontSize',16,'Location','northwest');
axis([1 24 demandMin*0.9 demandMax*1.2]);
xticks([1,4:4:24]);
