function PlotEulerAngles(t,Q)
Titles = {'Roll', 'Pitch', 'Yaw'};  % Axes titles
XLabels = 'Time (s)';  % X-axis label
YLabels = {'\phi (\circ)', '\theta (\circ)', '\psi (\circ)'};  % Y-axis labels

n = numel(t);  % Number of time points
E = zeros(3, n);  % Preallocate Euler angles array

% Calculate Euler angles
for k = 1:n
    DCM = Q2DCM(Q(:, k));  % Direction Cosine Matrix from quaternions
    E(1, k) = atan2(DCM(2, 3), DCM(3, 3));  % Roll angle
    E(2, k) = asin(-DCM(1, 3));  % Pitch angle
    E(3, k) = atan2(DCM(1, 2), DCM(1, 1));  % Yaw angle
end

E = E * 180 / pi;  % Convert radians to degrees

% Define axis limits and ticks
XLim = [0, ceil(max(t))];  % X-axis limits
YLim = zeros(3, 2);  % Y-axis limits with buffer
for k = 1:3
    YLim(k, :) = [floor(min(E(k, :))), ceil(max(E(k, :))) + 1];
end

XTicks = linspace(XLim(1), XLim(2), 21);  % X-axis ticks
YTicks = cell(3, 1);  % Preallocate YTicks
for k = 1:3
    YTicks{k} = linspace(YLim(k, 1), YLim(k, 2), 11);  % Y-axis ticks
end

Window = figure('Color', 'w', 'Name', 'PROJECTILE EULER ANGLES', 'NumberTitle', 'Off', 'OuterPosition', get(0, 'ScreenSize'));

Axes = zeros(1, 3);  % Preallocate Axes
for k = 1:3
    Axes(k) = subplot(3, 1, k, 'FontName', 'Arial', 'FontSize', 8, 'FontWeight', 'Bold', 'NextPlot', 'Add', ...
        'XGrid', 'On', 'YGrid', 'On', 'XLim', XLim, 'YLim', YLim(k, :), 'XTick', XTicks, 'YTick', YTicks{k}, 'Parent', Window);
    title(Axes(k), Titles{k}, 'FontSize', 16);
    xlabel(Axes(k), XLabels, 'FontSize', 12);
    ylabel(Axes(k), YLabels{k}, 'FontSize', 12);
end

for k = 1:3
    plot(Axes(k), t, E(k, :), 'Color', 'k', 'LineStyle', 'None', 'Marker', '.');
end

save('EulerAngles.mat', 't', 'E');  % Save Euler angles

end
