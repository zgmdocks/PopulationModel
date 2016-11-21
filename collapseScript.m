clear

both = true;
symmetric = true;

tstart = 400;
tmax = 30000;
dt = 1;
t = tstart:dt:tmax;

cap = 4000;

iters = 1;
y = zeros((tmax-tstart)*(1/dt)+1,4);
ytemp = zeros((tmax-tstart)*(1/dt)+1,4);

incr = 50;

as = linspace(0.001,0.0225,incr); %0.005,0.025
Ks = linspace(500000,1500000,incr); %500000,1500000
cs = linspace(0.005,0.03,incr); %0.005,0.03
hs = linspace(0.001,0.02,incr); %0.001,0.02
ys = linspace(0.1,10,incr); %0.1,10
bs = linspace(0.1,10,incr); %0.1,10

params = cell(10,1);
params{1} = 'a1 - Human Growth Rate';
params{2} = as;
params{3} = 'K1 - Carrying Capacity';
params{4} = Ks;
params{5} = 'c1 - Resource Growth Rate';
params{6} = cs;
params{7} = 'h1 - Harvesting Constant';
params{8} = hs;
params{9} = 'y1 - Steepness of b Function';
params{10} = ys;

ax = 0.0177;
ay = 200;
Kx = 1000000;
Ky = 200;
cx = 0.015;
cy = 200;
hx = 0.008;
hy = 200;
yx = 5;
yy = 200;

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
b1 = @(R,P) 1/(1 + exp(B1-y1*P/R)) ;
b2 = @(R,P) 1/(1 + exp(B2-y2*P/R)) ;
y0 = [50000, K1, 50000, K2];
model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1(z(2),z(1))*z(4))+epsilon))) ;
    (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2(z(4),z(3))*h2*z(3));
    a2*z(3)*(1-(z(3)/(z(4)+(b2(z(4),z(3))*z(2))+epsilon))) ;
    c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1(z(2),z(1))*h1*z(1)];
options = odeset('NonNegative',[1 2 3 4]);
[t,y] = ode45(model,t,y0,options);
if isempty(find(y(:,1)<1,1))
    ctrl_time_g = cap;
else
    ctrl_time_g = find(y(:,1)<1,1);
end

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
y0 = [50000, K1, 50000, K2];
model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1*z(4))+epsilon))) ;
    (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2*h2*z(3));
    a2*z(3)*(1-(z(3)/(z(4)+(b2*z(2))+epsilon))) ;
    c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1*h1*z(1)];
options = odeset('NonNegative',[1 2 3 4]);
[t,y] = ode45(model,t,y0,options);
if isempty(find(y(:,1)<1,1))
    ctrl_time_ng = cap;
else
    ctrl_time_ng = find(y(:,1)<1,1);
end


for j = 1:2:10
    j
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
    t_c_1_asym = zeros(1,incr);
    t_c_2_asym = zeros(1,incr);
    t_c_1_sym = zeros(1,incr);
    t_c_2_sym = zeros(1,incr);
    t_c_1_iso = zeros(1,incr);
    t_c_2_iso = zeros(1,incr);
    for i = 1:incr
        %asymmetric case
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
        b1 = @(R,P) 1/(1 + exp(B1-y1*P/R)) ;
        b2 = @(R,P) 1/(1 + exp(B2-y2*P/R)) ;
        assignin('base',char([params{j}(1),'1']),params{j+1}(i));
        y0 = [50000, K1, 50000, K2];
        model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1(z(2),z(1))*z(4))+epsilon))) ;
            (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2(z(4),z(3))*h2*z(3));
            a2*z(3)*(1-(z(3)/(z(4)+(b2(z(4),z(3))*z(2))+epsilon))) ;
            c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1(z(2),z(1))*h1*z(1)];
        options = odeset('NonNegative',[1 2 3 4]);
        [t,y] = ode45(model,t,y0,options);
        if isempty(find(y(:,1)<1,1))
            t_c_1_asym(i) = cap;
        else
            t_c_1_asym(i) = find(y(:,1)<1,1);
            if t_c_1_asym(i) > cap
                t_c_1_asym(i) = cap;
            end
        end
        if isempty(find(y(:,3)<1,1))
            t_c_2_asym(i) = cap;
        else
            t_c_2_asym(i) = find(y(:,3)<1,1);
            if t_c_2_asym(i) > cap
                t_c_2_asym(i) = cap;
            end
        end
        % non globalized case asymmetric
        b1 = 0;
        b2 = 0;
        model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1*z(4))+epsilon))) ;
            (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2*h2*z(3));
            a2*z(3)*(1-(z(3)/(z(4)+(b2*z(2))+epsilon))) ;
            c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1*h1*z(1)];
        [t,y] = ode45(model,t,y0,options);
        if isempty(find(y(:,1)<1,1))
            t_c_1_iso(i) = cap;
        else
            t_c_1_iso(i) = find(y(:,1)<1,1);
            if t_c_1_iso(i) > cap
                t_c_1_iso(i) = cap;
            end
        end
        if isempty(find(y(:,3)<1,1))
            t_c_2_iso(i) = cap;
        else
            t_c_2_iso(i) = find(y(:,3)<1,1);
            if t_c_2_iso(i) > cap
                t_c_2_iso(i) = cap;
            end
        end
        % symmetric case
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
        b1 = @(R,P) 1/(1 + exp(B1-y1*P/R)) ;
        b2 = @(R,P) 1/(1 + exp(B2-y2*P/R)) ;
        assignin('base',char([params{j}(1),'1']),params{j+1}(i));
        assignin('base',char([params{j}(1),'2']),params{j+1}(i));
        y0 = [50000, K1, 50000, K2];
        model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1(z(2),z(1))*z(4))+epsilon))) ;
            (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2(z(4),z(3))*h2*z(3));
            a2*z(3)*(1-(z(3)/(z(4)+(b2(z(4),z(3))*z(2))+epsilon))) ;
            c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1(z(2),z(1))*h1*z(1)];
        options = odeset('NonNegative',[1 2 3 4]);
        [t,y] = ode45(model,t,y0,options);
        if isempty(find(y(:,1)<1,1))
            t_c_1_sym(i) = cap;
        else
            t_c_1_sym(i) = find(y(:,1)<1,1);
            if t_c_1_sym(i) > cap
                t_c_1_sym(i) = cap;
            end
        end
        if isempty(find(y(:,3)<1,1))
            t_c_2_sym(i) = cap;
        else
            t_c_2_sym(i) = find(y(:,3)<1,1);
            if t_c_2_sym(i) > cap
                t_c_2_sym(i) = cap;
            end
        end
    end
    if symmetric
        figure('name',[params{j}(1), ' - Collapse Time''_', datestr(clock,0),'_sym'])
    else
        figure('name',[params{j}(1), ' - Collapse Time''_', datestr(clock,0),'_asym'])
    end
    plot(params{j+1},t_c_1_iso,'ob');
    hold on
    plot(params{j+1},t_c_2_iso, 'or');
    plot(params{j+1},t_c_1_asym,'o','Color', [0.4,0.4,0.4]);
    plot(params{j+1},t_c_2_asym, 'ok');
    plot(params{j+1},t_c_1_sym,'om');
    plot(params{j+1},t_c_2_sym, 'oc');
    xlabel([params{j}(1),params{j}(3:end)]);
    ylabel('Time to collapse (t)');
    legend('Pop 1 - Non-globalization','Pop 2 - Non-globalization', ...
        'Pop 1 - Globalized Asymmetric','Pop 2 - Globalized Asymmetric', ...
        'Pop 1 - Globalized Symmetric','Pop 2 - Globalized Symmetric')
    if j == 1
        plot(ax,ctrl_time_g,'*g')
        plot(ax,ctrl_time_ng,'*y')
    elseif j == 3
        plot(Kx, ctrl_time_g,'*g')
        plot(Kx, ctrl_time_ng,'*y')
    elseif j == 5
        plot(cx, ctrl_time_g,'*g')
        plot(cx, ctrl_time_ng,'*y')
    elseif j == 7
        plot(hx, ctrl_time_g,'*g')
        plot(hx, ctrl_time_ng,'*y')
    elseif j == 9
        plot(yx, ctrl_time_g,'*g')
        plot(yx, ctrl_time_ng,'*y')
    end
end

h = get(0,'children');

for i=1:size(h,1)
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/Time to Collapse Graphs/Figures/',get(h(i),'Name'),'.fig'])
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/Time to Collapse Graphs/Individual PDFs/',get(h(i),'Name'),'.pdf'])
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/Time to Collapse Graphs/EPS/',get(h(i),'Name'),'.eps'],'epsc')
end
