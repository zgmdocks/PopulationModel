function s = genList(total)
s = '[';
for i=1:total
    s = [s,num2str(i),', '];
end
s = s(1:end-2);
s = [s,'];'];
end