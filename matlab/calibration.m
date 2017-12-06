data=importdata('calibrationdata.xls');

P = data.data(:,1); %kPa error 0.1
V = data.data(:,2); %V error 0.05

P = P/10; %kPa error 0.05
SP = 0.1;
SV = 0.05;

linFit = fit(V,P,'poly1');

cal = figure('Name','Pressure calibration curve');hold on
meas = plot(V,P,'*');
Fit = plot(linFit);
legend([meas Fit],'Measured values','Linear fit','Location','nw')
xlabel 'Voltage [V]'
ylabel 'Pressure [kPa]'
set(gca,'FontSize',14)
grid on
saveas(cal,'calibration','png')
close all

%% Error
maxP = [P(1)+SP, P(end)-SP]; 
maxV = [V(1)-SV, V(end)+SV];
maxSlope = (maxP(2)-maxP(1))/(maxV(2)-maxV(1));
maxSlope = maxSlope - linFit.p1;

minP = [P(1)-SP, P(end)+SP];
minV = [V(1)+SV, V(end)-SV];
minSlope = (minP(2)-minP(1))/(minV(2)-minV(1));
minSlope = linFit.p1 - minSlope;

disp(['Slope: ' num2str(linFit.p1) '(+' num2str(minSlope) ',-' num2str(maxSlope) ')'])