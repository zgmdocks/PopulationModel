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
%     for j = 1:size(ytemp,1)
%         if ytemp(j,2) <= 0
%             if ytemp(j,4) <= 0
%                 break
%             end
%             wins1 = wins1 + 1;
%             break
%         elseif ytemp(j,4) <= 0
%             wins2 = wins2 + 1;
%             break
%         end 
%     end
end

% Calculates the stolen resources
S1 = 1./(1+exp(B1 - y1*abs(y(:,1))./abs(y(:,2))))*0;
S2 = 1./(1+exp(B2 - y2*abs(y(:,3))./abs(y(:,4))))*0;

% S1 = S1.*y(:,4);
% S2 = S2.*y(:,2);


figure('name','Pop 1 nonGlobalized')
plot(t,y(:,1))
%title('Population of Civilization 1 - nonGlobalized')
ylabel('Population (P)')
xlabel('Time in Years (t)')
% axis tight
figure('name','Resources 1 nonGlobalized')
plot(t,y(:,2),'Color',[0,0,1],'DisplayName','finalciv 1')
%title('Resources in Patch 1 - nonGlobalized')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')
% axis tight
figure('name','Stolen 1 nonGlobalized')
plot(t,S1)
%title('Percentage of Harvest Stolen by Civilization 1 - nonGlobalized')
ylabel('Percentage of Harvest Stolen')
xlabel('Time in Years (t)')
% axis tight
figure('name','Pop 2 nonGlobalized')
plot(t,y(:,3))
%title('Population of Civilization 2 - nonGlobalized')
ylabel('Population (P)')
xlabel('Time in Years (t)')
% axis tight
figure('name','Resources 2 nonGlobalized')
plot(t,y(:,4),'Color',[0,0,1],'DisplayName','finalciv 1')
%title('Resources in Patch 2 - nonGlobalized')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')
% axis tight
figure('name','Stolen 2 nonGlobalized')
plot(t,S2)
%title('Percentage of Harvest Stolen by Civilization 2 - nonGlobalized')
xlabel('Time in Years (t)')
ylabel('Percentage of Harvest Stolen')
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
figure('name','Total Resources 1 Not Globalized')
plot(t,TR1)
%title('Total Resources Consumed by Civilization 1 - Non-Globalized')
xlabel('Time in Years (t)')
ylabel('Accessible Resources')
figure('name','Total Resources 2 Not Globalized')
plot(t,TR2)
%title('Total Resources Consumed by Civilization 2 - Not Globalized')
xlabel('Time in Years (t)')
ylabel('Accessible Resources')

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
h = get(0,'children');

for i=1:size(h,1)
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/Not Globalized/',get(h(i),'Name'),'.fig'])
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/Not Globalized/',get(h(i),'Name'),'.eps'],'epsc')
end