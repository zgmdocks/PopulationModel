clear
a1 = 0.0177; % aP is the net growth rate of the population 0.0177
K1 = 1000000; % carrying capacity 1,000,000
c1 = 0.015; % growth rate of the resources 0.015
h1 = 0.008; % harvesting constant 0.008
B1 = 3.5; % controls the location of the mid-point of the sigmoid 3.5
y1 = 5; % controls how steep the curve is 5
a2 = 0.0177; % aP is the net growth rate of the population
K2 = 1000000; % carrying capacity
c2 = 0.015; % growth rate of the resources
h2 = 0.008; % harvesting constant
B2 = 3.5; % controls the location of the mid-point of the sigmoid
y2 = 5; % controls how steep the curve is
epsilon = 10^-4;

b1 = 0 ;
b2 = 0 ;

model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1*z(4))+epsilon))) ;
     (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2*h2*z(3));
     a2*z(3)*(1-(z(3)/(z(4)+(b2*z(2))+epsilon))) ;
     c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1*h1*z(1)];
 
tstart = 1800;
tmax = 3000;
dt = 1;
t = tstart:dt:tmax;

y0 = [50000, K1, 50000, K2];
iters = 1;
y = zeros((tmax-tstart)*(1/dt)+1,4);
ytemp = zeros((tmax-tstart)*(1/dt)+1,4);
wins1 = 0;
wins2 = 0;
for i = 1:iters
    options = odeset('NonNegative',[1 2 3 4]);
    [t,y] = ode45(model,t,y0,options);
end

% Calculates the stolen resources
S1 = 1./(1+exp(B1 - y1*abs(y(:,1))./abs(y(:,2))))*0;
S2 = 1./(1+exp(B2 - y2*abs(y(:,3))./abs(y(:,4))))*0;


figure('name','Pop 1 nonGlobalized')
plot(t,y(:,1))
ylabel('Population (P)')
xlabel('Time in Years (t)')

figure('name','Resources 1 nonGlobalized')
plot(t,y(:,2),'Color',[0,0,1],'DisplayName','finalciv 1')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')

figure('name','Stolen 1 nonGlobalized')
plot(t,S1)
ylabel('Percentage of Harvest Stolen')
xlabel('Time in Years (t)')

figure('name','Pop 2 nonGlobalized')
plot(t,y(:,3))
ylabel('Population (P)')
xlabel('Time in Years (t)')

figure('name','Resources 2 nonGlobalized')
plot(t,y(:,4),'Color',[0,0,1],'DisplayName','finalciv 1')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')

figure('name','Stolen 2 nonGlobalized')
plot(t,S2)
xlabel('Time in Years (t)')
ylabel('Percentage of Harvest Stolen')

% TR is the total resources available to each civ (i.e. resources
% in their patch as well as resources they are stealing)
TR1 = S1.*y(:,4)+y(:,2);
TR2 = S2.*y(:,2)+y(:,4);
figure('name','Total Resources 1 Not Globalized')
plot(t,TR1)
xlabel('Time in Years (t)')
ylabel('Accessible Resources')
figure('name','Total Resources 2 Not Globalized')
plot(t,TR2)
xlabel('Time in Years (t)')
ylabel('Accessible Resources')


for i=1:size(h,1)
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/Not Globalized/',get(h(i),'Name'),'.fig'])
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/Not Globalized/',get(h(i),'Name'),'.eps'],'epsc')
end
