a1 = 0.0177; % aP is the net growth rate of the population 0.0177
K1 = 250000; % carrying capacity 1,000,000
c1 = 0.015; % growth rate of the resources 0.015
h1 = 0.016; % harvesting constant 0.008
B1 = 2; % controls the location of the mid-point of the sigmoid 3.5
y1 = 10; % controls how steep the curve is 5
a2 = 0.0075; % a is the net growth rate of the population
K2 = 1000000; % carrying capacity
c2 = 0.015; % growth rate of the resources
h2 = 0.008; % harvesting constant
B2 = 10; % controls the location of the mid-point of the sigmoid
y2 = 1; % controls how steep the curve is
epsilon = 10^-4;

steal1 = 1;
steal2 = 0;

b1 = @(R,P) 1/(1 + exp(B1-y1*P/(R)))*steal1 ;
b2 = @(R,P) 1/(1 + exp(B2-y2*P/R))*steal2 ;

model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1(z(2),z(1))*z(4))+epsilon))) ;
     (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2(z(4),z(3))*h2*z(3));
     a2*z(3)*(1-(z(3)/(z(4)+(b2(z(4),z(3))*z(2))+epsilon))) ;
     c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1(z(2),z(1))*h1*z(1)];
 
tstart = 1800;
tmax = 2300;
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

% S1 = S1.*y(:,4);
% S2 = S2.*y(:,2);

if steal1 == 1
    figure('Name','pop 1 s1')
else
    figure('Name','pop 1')
end
plot(t,y(:,1))
xlabel('Time in Years (t)')
ylabel('Population (P)')
% title('population civ 1')
% axis tight
if steal1 == 1
    figure('Name','res 1 s1')
else
    figure('Name','res 1')
end
plot(t,y(:,2),'Color',[0,0,1],'DisplayName','finalciv 1')
xlabel('Time in Years (t)')
ylabel('Accessible Resources (R)')
% title('resources civ 1')
% axis tight
if steal1 == 1
    figure('Name','steal 1 s1')
else
    figure('Name','steal 1')
end
plot(t,S1)
xlabel('Time in Years (t)')
ylabel('Percentage of Harvest Stolen')
% title('stolen harvest civ 1')
% axis tight
if steal1 == 1
    figure('Name','pop 2 s1')
else
    figure('Name','pop 2')
end
plot(t,y(:,3))
xlabel('Time in Years (t)')
ylabel('Population (P)')
% title('population civ 2')
% axis tight
if steal1 == 1
    figure('Name','res 2 s1')
else
    figure('Name','res 2')
end
plot(t,y(:,4),'Color',[0,0,1],'DisplayName','finalciv 1')
xlabel('Time in Years (t)')
ylabel('Accessible Resources (R)')
% title('resources civ 2')
% axis tight
if steal1 == 1
    figure('Name','steal 2 s1')
else
    figure('Name','steal 2')
end
plot(t,S2)
xlabel('Time in Years (t)')
ylabel('Percentage of Harvest Stolen')
% title('stolen harvest civ 2')
% axis tight

% diff2 = zeros(size(y,1),1);
% for i = 2:size(y,1)
%     diff2(i) = y(i,3) - y(i-1,3);
% end
% figure()
% plot(t,diff2);
% title('difference of 2nd population')
% diff1 = zeros(size(y,1),1);
% for i = 2:size(y,1)
%     diff1(i) = y(i,1) - y(i-1,1);
% end
% figure()
% plot(t,diff1);
% title('difference of 1st population')

% TR is the total resources available to each civ (i.e. resources
% in their patch as well as resources they are stealing)
TR1 = S1.*y(:,4)*steal1+y(:,2);
TR2 = S2.*y(:,2)*steal2+y(:,4);
if steal1 == 1
    figure('Name','TR 1 s1')
else
    figure('Name','TR 1')
end
plot(t,TR1)
xlabel('Time in Years (t)')
ylabel('Accessible Resources')
% title('TR1')
if steal1 == 1
    figure('Name','TR 2 s1')
else
    figure('Name','TR 2')
end
plot(t,TR2)
xlabel('Time in Years (t)')
ylabel('Accessible Resources')
% title('TR2')


h = get(0,'children');

for i=1:size(h,1)
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/inequal/',get(h(i),'Name'),'.eps'],'epsc')
end