function PlotRotationalVelocity(t,Wcg)

    % Titles and Labels
Titles = {'X Angular Rate', 'Y Angular Rate', 'Z Angular Rate', 'Total Angular Rate'}; %{Axes titles}
XLabels = 'Time (s)'; %{X-axis label}
YLabels = {'Wx (deg/s)', 'Wy (deg/s)', 'Wz (deg/s)', 'W (km/s)'}; %{Y-axis labels}

% Number of Elements in Time Vector
n = numel(t); %Number of elements in time vector

% Allocate Memory for Speeds
W = zeros(1, n); %Preallocate rotational speed array

    for k = 1:n
        W(k) = norm(Wcg(:,k)) * 180 / pi; %{deg/s}Aircraft rotational speed.
    end

    Wcg = Wcg * 180 / pi;%{deg/s} rotational speed WRT the CG in Body coordinates.

    % X and Y Axis Limits
    XLim = [0,ceil(max(t))]; 
    YLim = zeros(4,2); %allocate Y-lim matrix

    %Y-axis limit for X,Y,Z Angular rate
    for k = 1:3 
        if min(Wcg(k,:)) == max(Wcg(k,:))
            YLim(k,:) = [floor(min(Wcg(k,:))) - 1, ceil(max(Wcg(k,:))) + 1];%{rad/s}Y-axis limit.
        else
            YLim(k,:) = [floor(min(Wcg(k,:))), ceil(max(Wcg(k,:)))];%{rad/s}Y-axis limit.
        end
    end

    %Y-axis limit for Total Angular rate
    if max(W) == 0
        YLim(4,:) = [floor(min(W)) - 1, ceil(max(W)) + 1]; %{rad/s}Y-axis range.
    else
        YLim(4,:) = [0, ceil(max(W))]; %{rad/s}Y-axis range.
    end

    % Screen and Figure Setup
    Window = figure('Color', 'w','Name', 'PROJECTILE VELOCITY WRT GROUND STATION','OuterPosition', get(0, 'ScreenSize')); %Create figure window

    Axes = zeros(1,4);

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
        plot(t,Wcg(k,:), 'Color', 'k', 'Marker', '.','Parent', Axes(k));%Plot data for rotational speeds
    end

    plot(t,W,'Color', 'k', 'Marker', '.', 'Parent', Axes(4)); 
    %Plot data for Total speed 'Parent', Axes() is used to make sure the
    %plot is plot in right subplot

end
