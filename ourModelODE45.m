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

% S1 = S1.*y(:,4);
% S2 = S2.*y(:,2);


figure('name','Pop 1 Globalized')
plot(t,y(:,1))
%title('Population of Civilization 1 - Globalized')
ylabel('Population (P)')
xlabel('Time in Years (t)')
% axis tight
figure('name','Resources 1 Globalized')
plot(t,y(:,2),'Color',[0,0,1],'DisplayName','finalciv 1')
%title('Resources in Patch 1 - Globalized')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')
% axis tight
figure('name','Stolen 1 Globalized')
plot(t,S1)
%title('Percentage of Harvest Stolen by Civilization 1 - Globalized')
ylabel('Percentage of Harvest Taken')
xlabel('Time in Years (t)')
% axis tight
figure('name','Pop 2 Globalized')
plot(t,y(:,3))
%title('Population of Civilization 2 - Globalized')
ylabel('Population (P)')
xlabel('Time in Years (t)')
% axis tight
figure('name','Resources 2 Globalized')
plot(t,y(:,4),'Color',[0,0,1],'DisplayName','finalciv 1')
%title('Resources in Patch 2 - Globalized')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')
% axis tight
figure('name','Stolen 2 Globalized')
plot(t,S2)
%title('Percentage of Harvest Stolen by Civilization 2 - Globalized')
xlabel('Time in Years (t)')
ylabel('Percentage of Harvest Taken')
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
TR1 = S1.*y(:,4)+y(:,2);
TR2 = S2.*y(:,2)+y(:,4);
figure('name','Total Resources 1 Globalized')
plot(t,TR1)
%title('Total Resources Accessible to Civilization 1 - Globalized')
xlabel('Time in Years (t)')
ylabel('Accessible Resources')
figure('name','Total Resources 2 Globalized')
plot(t,TR2)
%title('Total Resources Accessible to Civilization 2 - Globalized')
ylabel('Accessible Resources')
xlabel('Time in Years (t)')

% calculates derivative
% d = zeros(size(y,1),4);
% for i = 1:size(y,1)
%     d(i,1:4) = model(t(i),[y(i,1),y(i,2),y(i,3),y(i,4)]);
% end
% figure()
% plot(t,d(:,1));
% title('derivative of pop1')
% figure()
% plot(t,d(:,3));
% title('derivative of pop2')
% figure()
% plot(t,d(:,2));
% title('derivative of res1')
% figure()
% plot(t,d(:,4));
% title('derivative of res2')

% h = get(0,'children');
% 
% for i=1:size(h,1)
%     saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/Globalized/',get(h(i),'Name'),'.fig'])
%     saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/Globalized/',get(h(i),'Name'),'.eps'],'epsc')
% end