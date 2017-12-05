data=importdata('calibrationdata.xls');

P = data.data(:,1); %mbar error 0.5
V = data.data(:,2); %V error 0.05

P = P/10; %kPa error 0.05


linFit = fit(V,P,'poly1');

cal = figure('Name','Pressure calibration curve');hold on
meas = plot(V,P,'*');
Fit = plot(linFit);
legend([meas Fit],'Measured values','Fitted curve','Location','nw')
xlabel 'Voltage [V]'
ylabel 'Pressure [kPa]'
set(gca,'FontSize',14)
saveas(cal,'calibration','png')
close all