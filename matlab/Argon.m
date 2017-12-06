save=0;
display=1;
fig='off';
filename='Argon';
size =16;
Troom = 22;
ntab=1.00028209;
ntab=1+273.15/(273.15+Troom)*(ntab-1);

P = Par(3300:21600);
V = Var(3300:21600);
V = V-2.8;

figure('visible',fig);plot(V); hold on
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
linFit = fit(dP,dN','poly1');
fig=figure('Name','fringes vs Pressure','visible',fig); hold on;grid on;
meas=plot(dP,dN,'b*');
Fit= plot(linFit);
legend([meas Fit],'Measured values','Linear fit','Location','nw');
xlabel 'Pressure change [kPa]'
ylabel 'Number of fringes'
set(gca,'FontSize',size)
if save
    saveas(fig,filename,'png')
end

alpha = linFit.p1*lambda*Patm/(2*L);
n = alpha+1;
%slopeError = sqrt( (SP/(P(I(end))-P(I(1))))^2 + (0.5/length(I))^2);
slopeError = mean(sqrt( (SP./dP(2:end)).^2 + (SN./dN(2:end)').^2));

R = [slopeError/linFit.p1 ; Slambda/lambda ; SP/Patm ; SL/L];
nError = sqrt(R'*R)*(n-1);


if display
    disp(['Slope: ' num2str(linFit.p1)])
    disp(['Slope error: ' num2str(slopeError)])
    disp(['Estimated refractive index: ' num2str(n,'%1.8f') ' +- ' ...
        num2str(nError,'%1.4e')])
    disp(['Tabulated value at ' num2str(Troom) ': ' num2str(ntab,'%1.4e')])
    disp(['Error: ' num2str(abs(n-ntab),'%1.4e')])
    disp(' ')
end