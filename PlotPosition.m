function PlotPosition(t,Rcggs)

    Titles = {'Northern Displacement','Eastern Displacement','Zenith Displacement','Linear Range'}; %Axes titles.
    XLabels = 'Time (s)';%X-axes labels.
    YLabels = {'North (km)','East (km)','Zenith (km)','Range (km)'};%Y-axes labels.

    n = numel(t); %Number of elements in the modeling time vector.

    Range = zeros(1,n);  %Allocates memory for the projectile linear ranges WRT the ground station.

    for k = 1:n
        Range(k) = norm(Rcggs(:,k));%{km}Projectile range WRT the ground station in NED coordinates.
    end

    % Displacements WRT the GS in NED coordinates.
    Rcggs(3,:) = -Rcggs(3,:);
  
  %{km} X, Y-axis ranges.
    XLim = [0,ceil(max(t))];
    YLim = [ ...
        floor(min(Rcggs(1,:))), ceil(max(Rcggs(1,:))); ...
        floor(min(Rcggs(2,:))), ceil(max(Rcggs(2,:))); ...
        floor(min(Rcggs(3,:))), ceil(max(Rcggs(3,:))); ...
        floor(min(Range)), ceil(max(Range))];
  

    Window = figure( 'Name','PROJECTILE POSITION WITH RESPECT TO THE GROUND STATION', ...
        'OuterPosition',get(0,'ScreenSize'));
    %[]Opens a new window and adjusts its properties.

    %-----------------------------------------------------------------------------------------------

    Axes = zeros(1,4);
    %[]Allocates memory for the subplot axes.

    for k = 1:4

        Axes(k) = subplot(2, 2, k, ...
        'FontName', 'Arial', ...
        'FontSize', 8, ...
        'FontWeight', 'Bold', ...
        'NextPlot', 'Add', ...
        'XGrid', 'On', ...
        'YGrid', 'On', ...
        'XLim', XLim, ...
        'YLim', YLim(k, :)); %Setup subplot; 'nextplot','add' to avoid next title or axes being replaced by default
    title(Titles{k}, 'FontSize', 16, 'Parent', Axes(k)); %Add title
    xlabel(XLabels, 'FontSize', 12, 'Parent', Axes(k)); %Add X-axis label
    ylabel(YLabels{k}, 'FontSize', 12, 'Parent', Axes(k)); %Add Y-axis label
    end


    for k = 1:3

        plot(t,Rcggs(k,:),'Color', 'k', 'Marker', '.','Parent', Axes(k)); 
%Plot data for Range 'Parent', Axes() is used to make sure the plot is plot in right subplot

    end

    plot(t,Range, 'Color', 'k', 'Marker', '.', 'Parent', Axes(4)); 
   %Plot data for Total Range 'Parent', Axes() is used to make sure the plot is plot in right subplot


end
