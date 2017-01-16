function plotData(x)
%PLOTDATA Plots the data points into a new figure 

figure;
hold
Markercolor = [rand() , rand(), rand()];

for i=1:9
    tmp = [rand() , rand(), rand()];
    Markercolor = [Markercolor ; tmp];
end
ypoints = linspace(min(x(:)),max(x(:)),1000);

for i=1:10
plot(x(:,i),ypoints,'ko', 'MarkerFaceColor', Markercolor(i,:),'MarkerSize', 4);
end
title('Feature Distrubution');
ylabel('Linearly spaced vector');
xlabel('Feature values')
legend('blues','classical','country','disco','hiphop','jazz','metal','pop','reggae','rock');
figEnlarge;

%plotmatrix(x,ypoints');figEnlarge;
% =========================================================================



hold off;

end
