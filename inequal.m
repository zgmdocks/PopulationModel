a1 = 0.0177; % aP is the net growth rate of the population 0.0177
K1 = 250000; % carrying capacity 1,000,000
c1 = 0.015; % growth rate of the resources 0.015
h1 = 0.016; % harvesting constant 0.008
B1 = 2; % controls the location of the mid-point of the sigmoid 3.5
y1 = 10; % controls how steep the curve is 5
a2 = 0.0075; % a is the net growth rate of the population
K2 = 1000000; % carrying capacity
c2 = 0.01; % growth rate of the resources
h2 = 0.008; % harvesting constant
B2 = 10; % controls the location of the mid-point of the sigmoid
y2 = 1; % controls how steep the curve is
epsilon = 10^-4;

width = 4;
font = 24;

% changing steali to 1 lets population i take resources from its
% neighbors. changing the value to 0, turns off taking of resources
steal1 = 0;
steal2 = 0;

b1 = @(R,P) 1/(1 + exp(B1-y1*P/(R)))*steal1 ;
b2 = @(R,P) 1/(1 + exp(B2-y2*P/R))*steal2 ;

model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1(z(2),z(1))*z(4))+epsilon))) ;
     (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2(z(4),z(3))*h2*z(3));
     a2*z(3)*(1-(z(3)/(z(4)+(b2(z(4),z(3))*z(2))+epsilon))) ;
     c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1(z(2),z(1))*h1*z(1)];
 
tstart = 1800;
tmax = 8000;
dt = 1;
t = tstart:dt:tmax;

y0 = [50000, K1, 25000, K2];
iters = 1;
y = zeros((tmax-tstart)*(1/dt)+1,4);
ytemp = zeros((tmax-tstart)*(1/dt)+1,4);

options = odeset('NonNegative',[1 2 3 4]);
[t,y] = ode45(model,t,y0,options);

% Calculates the stolen resources
S1 = 1./(1+exp(B1 - y1*abs(y(:,1))./abs(y(:,2))))*steal1;
S2 = 1./(1+exp(B2 - y2*abs(y(:,3))./abs(y(:,4))))*steal2;

if steal1 == 1
    figure('Name','pop 1 s1')
else
    figure('Name','pop 1')
end
plot(t,y(:,1),'Linewidth',width)
xlabel('Time in Years (t)')
ylabel('Population (P)')
set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)
if steal1 == 1
    figure('Name','res 1 s1')
else
    figure('Name','res 1')
end

plot(t,y(:,2),'Linewidth',width)
xlabel('Time in Years (t)')
ylabel('Accessible Resources (R)')
set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)
if steal1 == 1
    figure('Name','steal 1 s1')
else
    figure('Name','steal 1')
end

plot(t,S1,'Linewidth',width)
xlabel('Time in Years (t)')
ylabel('Percentage of Harvest Taken')
set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)
if steal1 == 1
    figure('Name','pop 2 s1')
else
    figure('Name','pop 2')
end
plot(t,y(:,3),'Linewidth',width)
xlabel('Time in Years (t)')
ylabel('Population (P)')
set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)
if steal1 == 1
    figure('Name','res 2 s1')
else
    figure('Name','res 2')
end
plot(t,y(:,4),'Linewidth',width)
xlabel('Time in Years (t)')
ylabel('Accessible Resources (R)')
set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)
if steal1 == 1
    figure('Name','steal 2 s1')
else
    figure('Name','steal 2')
end
plot(t,S2,'Linewidth',width)
xlabel('Time in Years (t)')
ylabel('Percentage of Harvest Taken')
set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)

% TR is the total resources available to each civ (i.e. resources
% in their patch as well as resources they are stealing)
TR1 = S1.*y(:,4)*steal1+y(:,2);
TR2 = S2.*y(:,2)*steal2+y(:,4);
if steal1 == 1
    figure('Name','TR 1 s1')
else
    figure('Name','TR 1')
end
plot(t,TR1,'Linewidth',width)
xlabel('Time in Years (t)')
ylabel('Accessible Resources')
set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)
if steal1 == 1
    figure('Name','TR 2 s1')
else
    figure('Name','TR 2')
end
plot(t,TR2,'Linewidth',width)
xlabel('Time in Years (t)')
ylabel('Accessible Resources')
set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)


h = get(0,'children');

for i=1:size(h,1)
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/inequal/',get(h(i),'Name'),'.eps'],'epsc')
end