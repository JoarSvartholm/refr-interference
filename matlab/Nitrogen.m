filename='Nitrogen';
size =16;
Troom = 22;
ntab=1.00029873;
ntab=1+273.15/(273.15+Troom)*(ntab-1);

P = Pni(23500:end);
V = Vni(23500:end);%(3300:21600);
V = V-2.8;

figure;plot(V); hold on
count = 0;
ind = 0;
I = [];

for i = 1:length(V)
    if V(i)>upper && ind==0
        ind=1;
    elseif V(i)<lower && ind ==1
        count = count+1;
        ind =0;
        I = [I i];
    end
end

plot(I,V(I),'r*')


dP = P(I(3:end));
dP = dP-dP(1);
dN = 0:length(dP)-1;
linFit = fit(dP,dN','poly1')
fig=figure('Name','fringes vs Pressure'); hold on;grid on;
meas=plot(dP,dN,'b*');
Fit= plot(linFit);
legend([meas Fit],'Measured values','Linear fit','Location','nw');
xlabel 'Pressure change [kPa]'
ylabel 'Number of fringes'
set(gca,'FontSize',size)
saveas(fig,filename,'png')

alpha = linFit.p1*lambda*Patm/(2*L);
n = alpha+1;

disp(['Estimated refractive index: ' num2str(n,'%1.8f')])
disp(['Tabulated value at ' num2str(Troom) ': ' num2str(ntab,'%1.8f')])
disp(['Error: ' num2str(abs(n-ntab),'%1.8e')])