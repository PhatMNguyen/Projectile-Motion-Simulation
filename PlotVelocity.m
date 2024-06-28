function PlotVelocity(t,Vcggs)

% Titles and Labels
Titles = {'Northern Speed', 'Eastern Speed', 'Zenith Speed', 'Total Speed'}; %{Axes titles}
XLabels = 'Time (s)'; %{X-axis label}
YLabels = {'North (km/s)', 'East (km/s)', 'Zenith (km/s)', 'Total (km/s)'}; %{Y-axis labels}

% Number of Elements in Time Vector
n = numel(t); %Number of elements in time vector

% Allocate Memory for Speeds
Speed = zeros(1, n); %Preallocate speed array

% Calculate Speed WRT Ground Station
for k = 1:n
    Speed(k) = norm(Vcggs(:, k)); %{km/s} Projectile speed WRT ground station
end

% Adjust Zenith Speed to NED Coordinates
Vcggs(3, :) = -Vcggs(3, :); %{km/s} Adjust zenith speed

% X and Y Axis Limits
XLim = [0, ceil(max(t))]; %{s} X-axis range
YLim = [ ...
    floor(min(Vcggs(1, :))), ceil(max(Vcggs(1, :))); ...
    floor(min(Vcggs(2, :))), ceil(max(Vcggs(2, :))); ...
    floor(min(Vcggs(3, :))), ceil(max(Vcggs(3, :))); ...
    floor(min(Speed)), ceil(max(Speed))]; %{km} Y-axis ranges

% Screen and Figure Setup
Window = figure('Color', 'w','Name', 'PROJECTILE VELOCITY WRT GROUND STATION','OuterPosition', get(0, 'ScreenSize')); %Create figure window

% Setup Subplot Axes
Axes = zeros(1, 4); %Preallocate subplot axes
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

% Plot Data
for k = 1:3
    plot(t, Vcggs(k, :),'Color', 'k', 'Marker', '.','Parent', Axes(k));  %Plot data for North, East, Zenith speeds
end
plot(t, Speed, 'Color', 'k', 'Marker', '.', 'Parent', Axes(4)); 
%Plot data for Total speed 'Parent', Axes() is used to make sure the plot is plot in right subplo

end
