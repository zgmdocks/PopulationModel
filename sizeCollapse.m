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

incr = 10;
t_c = zeros(1,incr-1);

for i = 1:incr-1
    total = i+1;
    eval(['model = @ (t,z) ', genEqn(total)]);
    tstart = 0;
    tmax = 10000;
    dt = 1;
    t = tstart:dt:tmax;
    eval(geny0(total));

    y = zeros((tmax-tstart)*(1/dt)+1,total*2);
    
    options = odeset('NonNegative',eval(genList(total*2)));
    [t,y] = ode45(model,t,y0,options);
    
    if isempty(find(y(:,1)<1,1))
        t_c(i) = 500;
    else
        t_c(i) = find(y(:,1)<1,1);
    end
end

width = 4;
font = 16;

plot(2:incr,t_c,'Linewidth',width)
xlabel('Number of Populations')
ylabel('Time to Collapse (T)')
set(gca,'FontSize',font)
set(findall(gcf,'type','text'),'FontSize',font)

h = get(0,'children');


for i=1:size(h,1)
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/Time to Collapse Graphs/','size collapse','.eps'],'epsc')
end

