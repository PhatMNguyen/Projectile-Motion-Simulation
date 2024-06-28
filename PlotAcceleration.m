function PlotAcceleration(t,S,C)

Titles = { 'X Acceleration','Y Acceleration','Z Acceleration','Total Acceleration'};  % Titles for each subplot


XLabel = 'Time (s)'; % X-axis label 

YLabels = { 'a_x (g''s)', 'a_y (g''s)', 'a_z (g''s)', 'a (g''s)'};% Y-axis labels for each subplot

n = numel(t);% Number of time steps


A = zeros(3, n);
a = zeros(1, n); % Distribute memory for acceleration vectors

% Calculate acceleration components
for k = 1:n
    Rcggs = S(1:3, k);
    Vcggs = S(4:6, k);
    Q = S(10:13, k);
    dSdt = ProjectileEom(t(k), S(:, k), C);
    Acggs = dSdt(4:6);

    % Calculate inertial acceleration in NED coordinates
    A(:, k) = C.GS.Agse + cross(C.GS.We, cross(C.GS.We, Rcggs)) + 2 * cross(C.GS.We, Vcggs) + Acggs;
    
    % Transform acceleration to Body coordinates and normalize
    NED.Rcge = C.GS.Rgse + Rcggs;
    NedToBody = Ned2Body(NED, Q, C);
    A(:, k) = NedToBody * A(:, k) / C.E.g;
    
    % Calculate acceleration magnitude
    a(k) = norm(A(:, k));
end

% Define axis limits and tick marks
XLim = [0, ceil(max(t))];
YLim = [ ...
    floor(min(A(1, :))), ceil(max(A(1, :))); ...
    floor(min(A(2, :))), ceil(max(A(2, :))); ...
    floor(min(A(3, :))), ceil(max(A(3, :))); ...
    floor(min(a)), ceil(max(a))];
XTicks = linspace(XLim(1), XLim(2), 11);
YTicks = cell(4, 1);
for k = 1:4
    YTicks{k} = linspace(YLim(k, 1), YLim(k, 2), 11);
end

% Create figure window
figure('Color', 'w', 'Name', 'PROJECTILE INERTIAL ACCELERATION IN BODY COORDINATES', ...
    'NumberTitle', 'Off', 'OuterPosition', get(0, 'ScreenSize'));

% Create subplots
Axes = zeros(1, 4);
for k = 1:4
    Axes(k) = subplot(2, 2, k, 'FontName', 'Arial', 'FontSize', 8, 'FontWeight', 'Bold', 'NextPlot', 'Add', ...
        'XGrid', 'On', 'YGrid', 'On', 'XLim', XLim, 'YLim', YLim(k, :), 'XTick', XTicks, 'YTick', YTicks{k});
    title(Titles{k}, 'FontSize', 15);
    xlabel(XLabel, 'FontSize', 12);
    ylabel(YLabels{k}, 'FontSize', 12);
end

% Plot data on subplots
for k = 1:3
    plot(Axes(k), t, A(k, :), '.', 'Color', 'k');
end
plot(Axes(4), t, a, '.', 'Color', 'k');

end
