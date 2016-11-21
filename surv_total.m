h = get(0,'children');


for k = 1:size(h,1)
    survive = 0;
    collapse = 0;
    H = findobj(h(k),'type','surface');
    c_data = get(H,'cdata');
    for i = 1:75
        for j = 1:75
            if c_data(i,j) == 2
                survive = survive + 1;
            elseif c_data(i,j) == 0
                collapse = collapse + 1;
            end
        end
    end
    get(h(k),'Name')
    survive
    collapse
    total = survive + collapse;
    surv_per = survive/total*100
    coll_per = collapse/total*100
end