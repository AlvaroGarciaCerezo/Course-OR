% Course OR
% Álvaro García Cerezo
% 2026
% Lecture 3
% Exercise 6

clear;
close all;
clc;

% Input data.

k = 10; % Number of representative days

demand = xlsread('2015_f_load.xls','C5:C8764');
demandMax = max(demand);
demandMin = min(demand);
pv = xlsread('2015_f_pv.xls','C5:C8764');
pvMax = max(pv);
pvMin = min(pv);
wind = xlsread('2015_f_wind.xls','C5:C8764');
windMax = max(wind);
windMin = min(wind);

% Normalization.
demandNorm = (demand-demandMin)./(demandMax-demandMin);
pvNorm = (pv-pvMin)./(pvMax-pvMin);
windNorm = (wind-windMin)./(windMax-windMin);

% Transformation of the input data of each parameter into a matrix of 365 
% rows and 24 columns.
demandMatrixNorm = zeros(size(demandNorm,1)/24,24);
pvMatrixNorm = zeros(size(pvNorm,1)/24,24);
windMatrixNorm = zeros(size(windNorm,1)/24,24);
row = 1;
column = 0;
for i = 1:length(demandNorm)
    column = column + 1;
    if column == 25
        column = 1;
        row = row + 1;
    end
    demandMatrixNorm(row,column) = demandNorm(i);
    pvMatrixNorm(row,column) = pvNorm(i);
    windMatrixNorm(row,column) = windNorm(i);
end

inputMatrixNorm = [demandMatrixNorm,pvMatrixNorm,windMatrixNorm];

% Clustering.
[clusterID,medoidsRDsNorm] = kmedoids(inputMatrixNorm,k);

% Undo the normalization.
demandRDsNorm = medoidsRDsNorm(:,1:24);
pvRDsNorm = medoidsRDsNorm(:,25:48);
windRDsNorm = medoidsRDsNorm(:,49:72);
demandRDs = (demandRDsNorm.*(demandMax-demandMin))+demandMin;
pvRDs = (pvRDsNorm.*(pvMax-pvMin))+pvMin;
windRDs = (windRDsNorm.*(windMax-windMin))+windMin;

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

% Demand.
demandMatrix = (demandMatrixNorm.*(demandMax-demandMin))+demandMin;
figure;
plot(1:24,-1000*ones(24,1),'k-','LineWidth',1);
hold on;
plot(1:24,-1000*ones(24,1),'b-','LineWidth',2);
plot(1:24,demandMatrix,'k-','LineWidth',1);
plot(1:24,demandRDs,'b-','LineWidth',2);
set(gca,'FontSize',16);
xlabel('Time (h)','FontSize',18,'FontWeight','Bold'); 
ylabel('Demand level (MW)','FontSize',18,'FontWeight','Bold');
legend('Input data','Representative days','FontSize',16,'Location','northwest');
axis([1 24 demandMin*0.9 demandMax*1.2]);
xticks([1,4:4:24]);

% PV.
pvMatrix = (pvMatrixNorm.*(pvMax-pvMin))+pvMin;
figure;
plot(1:24,-1000*ones(24,1),'k-','LineWidth',1);
hold on;
plot(1:24,-1000*ones(24,1),'b-','LineWidth',2);
plot(1:24,pvMatrix,'k-','LineWidth',1);
plot(1:24,pvRDs,'b-','LineWidth',2);
set(gca,'FontSize',16);
xlabel('Time (h)','FontSize',18,'FontWeight','Bold'); 
ylabel('Solar-power production (MW)','FontSize',18,'FontWeight','Bold');
legend('Input data','Representative days','FontSize',16,'Location','northwest');
axis([1 24 0 pvMax*1.2]);
xticks([1,4:4:24]);

% Wind.
windMatrix = (windMatrixNorm.*(windMax-windMin))+windMin;
figure;
plot(1:24,-1000*ones(24,1),'k-','LineWidth',1);
hold on;
plot(1:24,-1000*ones(24,1),'b-','LineWidth',2);
plot(1:24,windMatrix,'k-','LineWidth',1);
plot(1:24,windRDs,'b-','LineWidth',2);
set(gca,'FontSize',16);
xlabel('Time (h)','FontSize',18,'FontWeight','Bold'); 
ylabel('Wind-power production (MW)','FontSize',18,'FontWeight','Bold');
legend('Input data','Representative days','FontSize',16,'Location','northwest');
axis([1 24 windMin*0.9 windMax*1.2]);
xticks([1,4:4:24]);
