clear

symmetric = false;
both = true;

tstart = 400;
tmax = 20000;
dt = 1;
t = tstart:dt:tmax;


iters = 1;
y = zeros((tmax-tstart)*(1/dt)+1,4);
ytemp = zeros((tmax-tstart)*(1/dt)+1,4);

incr = 76; % set 1 more than you want since pcolor cuts off last row and
          % column
as = linspace(0.001,0.0225,incr); %0.001,0.0225
Ks = linspace(500000,1500000,incr); %500000,1500000
cs = linspace(0.005,0.03,incr); %0.005,0.03
hs = linspace(0.0001,0.02,incr); %0.001,0.02
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
params{11} = 'B1 - Controls the Mid-point of Sigmoid';
params{12} = bs;


for q = 1:2
    if q == 2 && both
        fprintf('\n\nhalfway done\n\n\n')
        symmetric = ~symmetric;
    elseif q == 2 && both == false
        continue
    end
    for j = 1:2:12
        if j > 2
            break
        end
        j
        for i = j+2:2:12
            i
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
            result = zeros(incr);
            % This part is with globalization
            for n = 1:incr
                assignin('base',char([params{j}(1),'1']),params{j+1}(n));
                if symmetric
                    assignin('base',char([params{j}(1),'2']),params{j+1}(n));
                end
                for u = 1:incr
                    assignin('base',char([params{i}(1),'1']),params{i+1}(u));
                    if symmetric
                        assignin('base',char([params{i}(1),'2']),params{i+1}(u));
                    end
                    y0 = [50000, K1, 50000, K2]; % 50000 k
                    model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1(z(2),z(1))*z(4))+epsilon))) ;
                        (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2(z(4),z(3))*h2*z(3));
                        a2*z(3)*(1-(z(3)/(z(4)+(b2(z(4),z(3))*z(2))+epsilon))) ;
                        c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1(z(2),z(1))*h1*z(1)];
                    options = odeset('NonNegative',[1 2 3 4]);
                    [t,y] = ode45(model,t,y0,options);
                    if y(end,1) > 0.1 && y(end,3) > 0.1
                        result(u,n) = 2;
                    elseif y(end,1) > 0.1
                        result(u,n) = 1;
                    elseif y(end,3) > 0.1
                        result(u,n) = -1;
                    end
                end
            end
            params{i}(1)
            params{j}(1)
            if symmetric
            	figure('name',[params{j}(1),' vs ',params{i}(1),' - Globalized','_', datestr(clock,0),'_',num2str(incr),'_sym']);
            else
                figure('name',[params{j}(1),' vs ',params{i}(1),' - Globalized', '_', datestr(clock,0),'_',num2str(incr),'_asym']);
            end
            result(end,1) = 2;
            result(end,2) = -1;
            pcolor(params{j+1},params{i+1},result)
%             if symmetric
%                 title(['Survivability in terms of ',params{j}(1),' and ',params{i}(1),' - Globalized',' - Symmetric'])
%             else
%                 title(['Survivability in terms of ',params{j}(1),' and ',params{i}(1),' - Globalized',' - Asymmetric'])
%             end
            ylabel([params{i}(1),params{i}(3:end)])
            xlabel([params{j}(1),params{j}(3:end)])
            colorbar
            axis tight
            
            % Below is without globablization
            if q == 2  % because I only need to do the symmetric case for
                continue % not globalized
            end
            b1 = 0 ;
            b2 = 0 ;
            result = zeros(incr);
            if j > 10 || i > 10
                continue
            end
            for n = 1:incr
                assignin('base',char([params{j}(1),'1']),params{j+1}(n));
                assignin('base',char([params{j}(1),'2']),params{j+1}(n));
                for u = 1:incr
                    assignin('base',char([params{i}(1),'1']),params{i+1}(u));
                    assignin('base',char([params{i}(1),'2']),params{i+1}(u));
                    y0 = [50000, K1, 50000, K2];
                    model = @(t,z) [a1*z(1)*(1-(z(1)/(z(2)+(b1*z(4))+epsilon))) ;
                        (c1*z(2)*(1-(z(2)/K1)) - h1*z(1) - b2*h2*z(3));
                        a2*z(3)*(1-(z(3)/(z(4)+(b2*z(2))+epsilon))) ;
                        c2*z(4)*(1-(z(4)/K2)) - h2*z(3) - b1*h1*z(1)];
                    options = odeset('NonNegative',[1 2 3 4]);
                    [t,y] = ode45(model,t,y0,options);
                    if y(end,1) > 0.1 && y(end,3) > 0.1
                        result(u,n) = 2;
                    elseif y(end,1) > 0.1
                        result(u,n) = 1;
                    elseif y(end,3) > 0.1
                        result(u,n) = -1;
                    end
                end
            end
            params{i}(1)
            params{j}(1)
            figure('name',[params{j}(1),' vs ',params{i}(1),' - Not Globalized','_', datestr(clock,0),'_',num2str(incr),'_sym'])
            result(end,1) = 2;
            result(end,2) = -1;
            pcolor(params{j+1},params{i+1},result)
%             title(['Survivability in terms of ',params{j}(1),' and ',params{i}(1),' - Not Globalized',' - Symmetric'])
            ylabel([params{i}(1),params{i}(3:end)])
            xlabel([params{j}(1),params{j}(3:end)])
            colorbar
            axis tight
        end
    end
end

h = get(0,'children');


for i = 1:size(h,1)
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/Plane analysis Graphs/individual PDFs/',get(h(i),'Name'),'.pdf'])
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/Plane analysis Graphs/Figures/',get(h(i),'Name'),'.fig'])
    saveas(h(i),['/Users/zgmdocks/Documents/Coupled EWS/Population Collapse/Graphs/Plane analysis Graphs/EPS/',get(h(i),'Name'),'.eps'],'epsc')
end
