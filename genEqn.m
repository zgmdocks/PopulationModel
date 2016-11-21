function eqn = genEqn(total)
eqn = ['[',genP(total), genR(total),'];'];
end

function s = genR(total)   
     s = '';
for i = 1:total
    curr = num2str(i);
   s = [s , ['c',curr,'*z(',num2str(i+total),')*(1-(z(',num2str(i+total),')/K',curr,')) - h', ...
       curr,'*z(',curr,') - ', genSteal(i,total), ' ; '], char(10)];
end
if total == 1
    s = s(1:end-6);
else
    s = s(1:end-3);
end
end

function s = genP(total)   
     s = '';
for i = 1:total
    cur = num2str(i);
   s = [s , ['a',cur,'*z(',cur,')*(1-(z(',cur,')/(z(',num2str(i+total),') + ', genCC(i,total),' + epsilon)))', ' ; '], char(10)];
end
end

function s = geny0(total)
s = 'y0 = [';
for i=1:total
    s = [s, '50000, '];
end
for j = 1:total
    s = [s, 'K',num2str(j),', '];
end
s = s(1:end-2);
s = [s,'];'];
end

function s = genCC(j,total)
s = '';
for i = 1:total
    if i == j
        continue
    end
    s = [s, ' + ', ['b',num2str(j),'(z(',num2str(j+total),'),','z(',num2str(j),'))', ...
        '*z(',num2str(i+total),')']];
end
s = s(3:end);
end

function s = genSteal(j,total) 
s = '';
for i = 1:total
    if i == j
        continue
    end
   s = [s, ' - ', ['b',num2str(i),'(z(',num2str(i+total),'),','z(',num2str(i),'))', ...
        '*h',num2str(i),'*z(',num2str(i),')']];
end
s = s(3:end);
end

function s = genList(total)
s = '[';
for i=1:total
    s = [s,num2str(i),', '];
end
s = s(1:end-2);
s = [s,'];'];
end