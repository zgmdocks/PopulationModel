function s = geny0(total)
s = 'y0 = [';
for i=1:total
    s = [s, '500000, '];
end
for j = 1:total
    s = [s, 'K',num2str(j),', '];
end
s = s(1:end-2);
s = [s,'];'];
end