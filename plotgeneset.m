function plotgeneset(cell_x,cell_y,data,bmus)

k=intersect(find(bmus(:,1)==cell_x),find(bmus(:,2)==cell_y));
plot(1:size(data,2),data(k,:));

