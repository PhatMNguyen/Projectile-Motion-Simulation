
clc; clear; close all;
format compact; format longG;

% Load Euler angle data
load('EulerAngles.mat');

% Projectile construction
r = 0.155 / 2;  % Radius
L = 1;  % Length
dx = 100;  % Grid density
x = linspace(0, L, dx);  % Displacement vector
R = r - (r / L^2) * x.^2;  % Radius as function of length
[X, Y, Z] = cylinder(R, 20);  % Construct projectile
Z = Z - 0.4;  % Translate CG

% Initiate animation window
figure('Color', 'w', 'Name', 'Projectile Rotation', ...
                'OuterPosition', get(0, 'ScreenSize'));

% Initiate axes
Axes = axes('Box', 'On', 'CameraPosition', [-2, 2, 2], 'CameraTarget', [0, 0, 0], ...
            'Color', 'w', 'DataAspectRatio', [1, 1, 1],  'XLim', [-1, 1], 'YLim', [-1, 1], 'ZLim', [-1, 1]);
hold(Axes, 'on');
% Projectile assembly
Projectile(1) = surf(Z, X, Y, 'FaceColor', 'm');  % Render projectile
Projectile(2) = plot3(0, 0, 0, 'k.', 'MarkerSize', 50, 'Parent', Axes);  % CG
Projectile(3) = plot3([0, 1], [0, 0], [0, 0], 'b--', 'LineWidth', 3,'Parent',Axes);  % x-axis
Projectile(4) = plot3([0, 0], [0, -1], [0, 0], 'b--', 'LineWidth', 3,'Parent', Axes);  % y-axis
Projectile(5) = plot3([0, 0], [0, 0], [0, -1], 'b--', 'LineWidth', 3,'Parent', Axes);  % z-axis
Projectile(6) = text(1, 0, 0, 'X',FontSize=15);
Projectile(7) = text(0, -1, 0, 'Y',FontSize=15);
Projectile(8) = text(0, 0, -1, 'Z',FontSize=15);

Canvas = hgtransform( Axes);  % Combine projectile parts
set(Projectile, 'Parent', Canvas);  % Attach to canvas, figure will not move with projectile
%hgtransform  used to group graphics objects and apply geometric transformations

% Begin animation
Azimuth = linspace(0, 107, 108) * pi / 180;
Elevation = linspace(0, 45, 46) * pi / 180;

for k = 3:-1:0
    title(['Launch in ', num2str(k), ' seconds...'], 'FontSize', 20,'Parent', Axes);
    pause(.5);
end

for k = 1:108
    Tz = makehgtform('zrotate', -Azimuth(k));
    set(Canvas, 'Matrix', Tz);
    title(['Adjusting Azimuth (Yaw): \theta_{az} = ', num2str(Azimuth(k) * 180 / pi, '%0.0f'), '^\circ'],'FontSize', 20,'Parent',Axes);
    pause(0.1);
end

for k = 1:46
    Tz = makehgtform('zrotate', -Azimuth(end));
    Ty = makehgtform('yrotate', -Elevation(k));
    T = Tz * Ty;
    set(Canvas, 'Matrix', T);
    title(['Adjusting Elevation (pitch): \theta_{az} = ', num2str(Azimuth(end) * 180 / pi, '%0.0f'), ...
           '^\circ | \theta_{el} = ', num2str(Elevation(k) * 180 / pi, '%0.0f'), '^\circ'], ...
          'FontSize', 20,'Parent', Axes);
    pause(0.1);
end

for k = 3:-1:0
    title(['Launch in ', num2str(k), ' seconds...'], 'FontSize', 20,'Parent', Axes);
    pause(.5);
end

n = numel(t);
E = E * pi / 180;  % Convert angles to radians

for k = 1:n
    Tz = makehgtform('zrotate', -E(3, k));
    Ty = makehgtform('yrotate', -E(2, k));
    Tx = makehgtform('xrotate', E(1, k));
    T = Tz * Ty * Tx;
    set(Canvas, 'Matrix', T);
    title(['t = ', num2str(t(k), '%0.3f'), ' s | \phi = ', num2str(E(1, k) * 180 / pi, '%0.3f'), ...
           '^\circ | \theta = ', num2str(E(2, k) * 180 / pi, '%0.3f'), ...
           '^\circ | \psi = ', num2str(E(3, k) * 180 / pi, '%0.3f'), '^\circ'], ...
          'FontSize', 20, 'Parent', Axes);
    pause(0.005);
end

title(['Simulation Complete! (', num2str(t(end), '%0.3f'), ' s)'], 'FontSize', 20, 'Parent', Axes);
