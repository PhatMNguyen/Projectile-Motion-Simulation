%{ 
Nomanclature
'ECEF' = "Earth-Centered Earth-Fixed".
'ECI' = "Earth-Centered Inertial".
'LH' = "Local Horizontal".
'NED' = "North-East-Down"
%}
clc
clear
close all

format('Compact');
format('Compact');
% Constant varibles
C = Constants;

% Numerical Integration
tm = 0:0.01:120;  % Time frame [s]
So = InitialConditions(C);  % Initial conditions [km, km/s]
Options = odeset('Reltol', 1E-10, 'Events', @(t,S) Event(t,S,C));
[t, S] = ode45(@(t,S) ProjectileEom(t,S,C), tm, So, Options);

% Post-processing
t = t';  % Time vector [s]
S = S';  % State matrix [km, km/s]
Rcggs = S(1:3, :);  % Projectile positions w.r.t. ground station [km]
Vcggs = S(4:6, :);  % Projectile velocities w.r.t. ground station [km/s]
Wcg = S(7:9, :);  % Projectile rotational velocities w.r.t. CG [rad/s]
Q = S(10:13, :);  % Projectile quaternions

% Plot Results
PlotAltitude(t, Rcggs, C);  % Altitude vs Time
PlotPosition(t, Rcggs);  % Displacements vs Time
PlotVelocity(t, Vcggs);  % Velocities vs Time
PlotAcceleration(t, S, C);  % Accelerations vs Time
PlotEulerAngles(t, Q);  % Euler angles vs Time
PlotRotationalVelocity(t, Wcg);  % Rotational velocity vs Time in Body coordination

