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

%%%%% globalized model

model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1(z(2),z(1))*z(4))+epsilon))) ;
     (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2(z(4),z(3))*h2*z(3));
     a2*z(3)*(1-(z(3)/(z(4)+(b2(z(4),z(3))*z(2))+epsilon))) ;
     c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1(z(2),z(1))*h1*z(1)];
 
tstart = 1800;
tmax = 2600;
dt = 1;
t = tstart:dt:tmax;

y0 = [50000, K1, 50000, K2];

options = odeset('NonNegative',[1 2 3 4]);
[t_g,y_g] = ode45(model,t,y0,options);

S1_g = 1./(1+exp(B1 - y1*abs(y_g(:,1))./abs(y_g(:,2))));
S2_g = 1./(1+exp(B2 - y2*abs(y_g(:,3))./abs(y_g(:,4))));

TR1_g = S1_g.*y_g(:,4)+y_g(:,2);
TR2_g = S2_g.*y_g(:,2)+y_g(:,4);

%%%%% non globalized

b1 = 0 ;
b2 = 0 ;

model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1*z(4))+epsilon))) ;
     (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2*h2*z(3));
     a2*z(3)*(1-(z(3)/(z(4)+(b2*z(2))+epsilon))) ;
     c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1*h1*z(1)];
 
[t_ng,y_ng] = ode45(model,t,y0,options);

S1_ng = 1./(1+exp(B1 - y1*abs(y_ng(:,1))./abs(y_ng(:,2))))*0;
S2_ng = 1./(1+exp(B2 - y2*abs(y_ng(:,3))./abs(y_ng(:,4))))*0;

TR1_ng = S1_ng.*y_ng(:,4)+y_ng(:,2);
TR2_ng = S2_ng.*y_ng(:,2)+y_ng(:,4);
%%%% big model

total = 10;

b1 = @(R,P) 1/(1 + exp(B1-y1*P/(R))) ;
b2 = @(R,P) 1/(1 + exp(B2-y2*P/R)) ;

eval(['model = @ (t,z) ', genEqn(total)]);

eval(geny0(total));

options = odeset('NonNegative',eval(genList(total*2)));
[t_big,y_big] = ode45(model,t,y0,options);

S1_big = 1./(1+exp(B1 - y1*abs(y_big(:,1))./abs(y_big(:,1+total))));

TR1_big = S1_big.*y_big(:,12)+S1_big.*y_big(:,13)+ ...
    S1_big.*y_big(:,14)+S1_big.*y_big(:,15)+ ...
    S1_big.*y_big(:,16)+S1_big.*y_big(:,17)+ ...
    S1_big.*y_big(:,18)+S1_big.*y_big(:,19)+ ...
    S1_big.*y_big(:,20)+y_big(:,11);
%%%%% plotting

width = 4;
font = 24;

figure('name','Pop 1 all')
plot(t,y_ng(:,1),'--r','Linewidth',width)
hold on
plot(t,y_g(:,1),'-b','Linewidth',width)
plot(t,y_big(:,1),':k','Linewidth',width)
ylabel('Population (P)')
xlabel('Time in Years (t)')
legend('Isolated','Interconnected','10 Populations')

set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)

figure('name','Resources 1 all')
plot(t,y_ng(:,2),'--r','Linewidth',width)
hold on
plot(t,y_g(:,2),'-b','Linewidth',width)
plot(t,y_big(:,1+total),':k','Linewidth',width)
ylabel('Accessible Resources (R)')
xlabel('Time in Years (t)')
legend('Isolated','Interconnected','10 Populations')

set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)

figure('name','Total Resources 1 all')
plot(t,TR1_ng,'--r','Linewidth',width)
hold on
plot(t,TR1_g,'-b','Linewidth',width)
plot(t,TR1_big,':k','Linewidth',width)
xlabel('Time in Years (t)')
ylabel('Accessible Resources')
legend('Isolated','Interconnected','10 Populations')

set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)

S1_g = S1_g*100;
S1_big = S1_big*100;

figure('name','Stolen 1 all')
plot(t,S1_ng,'--r','Linewidth',width)
hold on
plot(t,S1_g,'-b','Linewidth',width)
plot(t,S1_big,':k','Linewidth',width)
ylabel('Percentage of Harvest Taken')
xlabel('Time in Years (t)')
legend('Isolated','Interconnected','10 Populations')

set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)

h = get(0,'children');


for i=1:size(h,1)
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/ModelResults/',get(h(i),'Name'),'.eps'],'epsc')
end



