function PlotAltitude(t,Rcggs,C)

    n = numel(t);%Number of elements in the modeling time vector.

    hcg = zeros(1,n);%Allocates memory for the projectile height above mean equator.

    for k = 1:n

        Rcge = C.GS.Rgse + Rcggs(:,k);
        %{km}Projectile position in Vector Form WRT the Earth Center in NED coordinates.
        rcge = norm(Rcge); %{km}Projectile range WRT the Earth Center in NED coordinates.
        hcg(k) = rcge - C.E.Re; %{km}Projectile altitude above mean equator.
    end

    %set X-Y limits
    XLim = [0,ceil(max(t))];
    YLim = [0,ceil(max(hcg))];


   figure('Color', 'w', 'Name', 'PROJECTILE ALTITUDE ABOVE MEAN EQUATOR', 'OuterPosition', get(0, 'ScreenSize'));

    Axes = axes( 'FontSize',10,'FontWeight','Bold','XLim',XLim, 'YLim',YLim','nextplot', 'Add');
    % 'NextPlot','Add' to plot the next plot on same Axes, instead of being replaced
    title('Projectile Altitude Above Mean Equator', 'FontSize', 16, 'Parent', Axes); %Add title
    xlabel('Time (s)', 'FontSize', 12, 'Parent', Axes); %Add X-axis label
    ylabel('Altitude (km)', 'FontSize', 12, 'Parent', Axes); %Add Y-axis label
    
    plot(t,hcg,'Color','k','Marker','.','Parent',Axes) %plot Altitude 
end
