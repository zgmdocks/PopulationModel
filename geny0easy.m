function s = geny0easy(total)
s = 'y0 = [';
for i=1:total
    s = [s, '50000, '];
end
for j = 1:total
    s = [s, 'K1',', '];
end
s = s(1:end-2);
s = [s,'];'];
end