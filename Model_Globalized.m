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

b1 = @(R,P) 1/(1 + exp(B1-y1*P/(R))) ;
b2 = @(R,P) 1/(1 + exp(B2-y2*P/R)) ;

model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1(z(2),z(1))*z(4))+epsilon))) ;
     (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2(z(4),z(3))*h2*z(3));
     a2*z(3)*(1-(z(3)/(z(4)+(b2(z(4),z(3))*z(2))+epsilon))) ;
     c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1(z(2),z(1))*h1*z(1)];
 
tstart = 1800;
tmax = 2300;
dt = 1;
t = tstart:dt:tmax;

y0 = [50000, K1, 50000, K2];
iters = 1;
y = zeros((tmax-tstart)*(1/dt)+1,4);
ytemp = zeros((tmax-tstart)*(1/dt)+1,4);

options = odeset('NonNegative',[1 2 3 4]);
[t,y] = ode45(model,t,y0,options);

% Calculates the stolen resources
S1 = 1./(1+exp(B1 - y1*abs(y(:,1))./abs(y(:,2))));
S2 = 1./(1+exp(B2 - y2*abs(y(:,3))./abs(y(:,4))));

figure('name','Pop 1 Globalized')
plot(t,y(:,1))
ylabel('Population (P)')
xlabel('Time in Years (t)')

figure('name','Resources 1 Globalized')
plot(t,y(:,2),'Color',[0,0,1],'DisplayName','finalciv 1')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')

figure('name','Stolen 1 Globalized')
plot(t,S1)
ylabel('Percentage of Harvest Taken')
xlabel('Time in Years (t)')

figure('name','Pop 2 Globalized')
plot(t,y(:,3))
ylabel('Population (P)')
xlabel('Time in Years (t)')

figure('name','Resources 2 Globalized')
plot(t,y(:,4),'Color',[0,0,1],'DisplayName','finalciv 1')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')

figure('name','Stolen 2 Globalized')
plot(t,S2)
xlabel('Time in Years (t)')
ylabel('Percentage of Harvest Taken')


% TR is the total resources available to each civ (i.e. resources
% in their patch as well as resources they are stealing)
TR1 = S1.*y(:,4)+y(:,2);
TR2 = S2.*y(:,2)+y(:,4);

figure('name','Total Resources 1 Globalized')
plot(t,TR1)
xlabel('Time in Years (t)')
ylabel('Accessible Resources')

figure('name','Total Resources 2 Globalized')
plot(t,TR2)
ylabel('Accessible Resources')
xlabel('Time in Years (t)')
