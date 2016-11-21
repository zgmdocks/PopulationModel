clear

total = 10;

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

a3 = 0.0177; % aP is the net growth rate of the population
K3 = 1000000; % carrying capacity
c3 = 0.015; % growth rate of the resources
h3 = 0.008; % harvesting constant
B3 = 3.5; % controls the location of the mid-point of the sigmoid
y3 = 5; % controls how steep the curve is

a4 = 0.0177; % aP is the net growth rate of the population
K4 = 1000000; % carrying capacity
c4 = 0.015; % growth rate of the resources
h4 = 0.008; % harvesting constant
B4 = 3.5; % controls the location of the mid-point of the sigmoid
y4 = 5; % controls how steep the curve is

a5 = 0.0177; % aP is the net growth rate of the population
K5 = 1000000; % carrying capacity
c5 = 0.015; % growth rate of the resources
h5 = 0.008; % harvesting constant
B5 = 3.5; % controls the location of the mid-point of the sigmoid
y5 = 5; % controls how steep the curve is

a6 = 0.0177; % aP is the net growth rate of the population
K6 = 1000000; % carrying capacity
c6 = 0.015; % growth rate of the resources
h6 = 0.008; % harvesting constant
B6 = 3.5; % controls the location of the mid-point of the sigmoid
y6 = 5; % controls how steep the curve is

a7 = 0.0177; % aP is the net growth rate of the population
K7 = 1000000; % carrying capacity
c7 = 0.015; % growth rate of the resources
h7 = 0.008; % harvesting constant
B7 = 3.5; % controls the location of the mid-point of the sigmoid
y7 = 5; % controls how steep the curve is

a8 = 0.0177; % aP is the net growth rate of the population
K8 = 1000000; % carrying capacity
c8 = 0.015; % growth rate of the resources
h8 = 0.008; % harvesting constant
B8 = 3.5; % controls the location of the mid-point of the sigmoid
y8 = 5; % controls how steep the curve is

a9 = 0.0177; % aP is the net growth rate of the population
K9 = 1000000; % carrying capacity
c9 = 0.015; % growth rate of the resources
h9 = 0.008; % harvesting constant
B9 = 3.5; % controls the location of the mid-point of the sigmoid
y9 = 5; % controls how steep the curve is

a10 = 0.0177; % aP is the net growth rate of the population
K10 = 1000000; % carrying capacity
c10 = 0.015; % growth rate of the resources
h10 = 0.008; % harvesting constant
B10 = 3.5; % controls the location of the mid-point of the sigmoid
y10 = 5; % controls how steep the curve is
epsilon = 10^-4;

b1 = @(R,P) 1/(1 + exp(B1-y1*P/(R))) ;
b2 = @(R,P) 1/(1 + exp(B2-y2*P/R)) ;
b3 = @(R,P) 1/(1 + exp(B3-y3*P/R)) ;
b4 = @(R,P) 1/(1 + exp(B4-y4*P/R)) ;
b5 = @(R,P) 1/(1 + exp(B5-y5*P/R)) ;
b6 = @(R,P) 1/(1 + exp(B6-y6*P/R)) ;
b7 = @(R,P) 1/(1 + exp(B7-y7*P/R)) ;
b8 = @(R,P) 1/(1 + exp(B8-y8*P/R)) ;
b9 = @(R,P) 1/(1 + exp(B9-y9*P/R)) ;
b10 = @(R,P) 1/(1 + exp(B10-y10*P/R)) ;

eval(['model = @ (t,z) ', genEqn(total)]);

 
tstart = 1800;
tmax = 2300;
dt = 1;
t = tstart:dt:tmax;

eval(geny0(total));

y = zeros((tmax-tstart)*(1/dt)+1,total*2);

options = odeset('NonNegative',eval(genList(total*2)));
[t,y] = ode45(model,t,y0,options);

% Calculates the stolen resources
S1 = 1./(1+exp(B1 - y1*abs(y(:,1))./abs(y(:,1+total))))*100;
% S2 = 1./(1+exp(B2 - y2*abs(y(:,2))./abs(y(:,2+total))))*100;

% S1 = S1.*y(:,4);
% S2 = S2.*y(:,2);


figure('name','Pop 1 Globalized Big')
plot(t,y(:,1))
%title('Population of Civilization 1 - Globalized')
ylabel('Population (P)')
xlabel('Time in Years (t)')
% axis tight
figure('name','Resources 1 Globalized Big')
plot(t,y(:,1+total),'Color',[0,0,1],'DisplayName','finalciv 1')
%title('Resources in Patch 1 - Globalized')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')
axis tight
figure('name','Stolen 1 Globalized Big')
plot(t,S1)
%title('Percentage of Harvest Stolen by Civilization 1 - Globalized')
ylabel('Percentage of Harvest Taken')
xlabel('Time in Years (t)')
axis tight
% figure('name','Pop 2 Globalized')
% plot(t,y(:,2))
% %title('Population of Civilization 2 - Globalized')
% ylabel('Population (P)')
% xlabel('Time in Years (t)')
% % axis tight
figure('name','Resources 2 Globalized Big')
plot(t,y(:,2+total),'Color',[0,0,1],'DisplayName','finalciv 1')
%title('Resources in Patch 2 - Globalized')
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')
% axis tight
% figure('name','Stolen 2 Globalized')
% plot(t,S2)
% %title('Percentage of Harvest Stolen by Civilization 2 - Globalized')
% xlabel('Time in Years (t)')
% ylabel('Percentage of Harvest Stolen')
% % axis tight

% TR is the total resources available to each civ (i.e. resources
% in their patch as well as resources they are stealing)
TR1 = S1.*y(:,total+2) + S1.*y(:,total+3) + S1.*y(:,total+4) + S1.*y(:,total+5) + S1.*y(:,16)... 
     + S1.*y(:,17) + S1.*y(:,18) + S1.*y(:,19) + S1.*y(:,20) + y(:,11);
% TR2 = S1.*y(:,total+1) + S1.*y(:,total+3) + S1.*y(:,total+4) + S1.*y(:,total+5);% + S1.*y(:,16)... 
%      %+ S1.*y(:,17) + S1.*y(:,18) + S1.*y(:,19) + S1.*y(:,20) + y(:,12);
figure('name','Total Resources 1 Globalized Big')
plot(t,TR1)
%title('Total Resources Accessible to Civilization 1 - Globalized')
xlabel('Time in Years (t)')
ylabel('Accessible Resources')
% figure('name','Total Resources 2 Globalized')
% plot(t,TR2)
% %title('Total Resources Accessible to Civilization 2 - Globalized')
% ylabel('Accessible Resources')
% xlabel('Time in Years (t)')

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
%     saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/Big Model/',get(h(i),'Name'),'.eps'],'epsc')
% end