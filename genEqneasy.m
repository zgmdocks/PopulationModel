function eqn = genEqneasy(total)
eqn = ['[',genPeasy(total), genReasy(total),'];'];
end

function s = genReasy(total)   
     s = '';
for i = 1:total
    curr = num2str(i);
   s = [s , ['c1','*z(',num2str(i+total),')*(1-(z(',num2str(i+total),')/K1',')) - h1', ...
       '*z(',curr,') - ', genStealeasy(i,total), ' ; '], char(10)];
end
if total == 1
    s = s(1:end-6);
else
    s = s(1:end-3);
end
end

function s = genPeasy(total)   
     s = '';
for i = 1:total
    cur = num2str(i);
   s = [s , ['a1','*z(',cur,')*(1-(z(',cur,')/(z(',num2str(i+total),') + ', genCCeasy(i,total),' + epsilon)))', ' ; '], char(10)];
end
end

function s = genStealeasy(j,total) 
s = '';
for i = 1:total
    if i == j
        continue
    end
   s = [s, ' - ', ['b1','(z(',num2str(i+total),'),','z(',num2str(i),'))', ...
        '*h1','*z(',num2str(i),')']];
end
s = s(3:end);
end

function s = genCCeasy(j,total)
s = '';
for i = 1:total
    if i == j
        continue
    end
    s = [s, ' + ', ['b1','(z(',num2str(j+total),'),','z(',num2str(j),'))', ...
        '*z(',num2str(i+total),')']];
end
s = s(3:end);
end