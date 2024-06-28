function C = Constants

% Launch Date and Time
C.T.UTC = datetime([2022, 12, 2, 17, 37, 27]); %{year, month, day, hour, minute, second} UTC at launch
C.T.JDo = juliandate(C.T.UTC); %{solar days} Julian date at launch

   % Earth Constants
C.E.mu = 398600.44; %{km^3/s^2} Gravitational parameter of Earth
C.E.Re = 6378.137; %{km} Mean equatorial radius of Earth
C.E.we = 2 * pi / 86164.1; %{rad/s} Rotational speed of Earth
C.E.g = 9.81 / 1000; %{km/s^2} Mean acceleration due to gravity

  % Ground Station Constants
C.GS.phi = deg2rad(32 + 44 / 60 + 52 / 3600); %{rad} Ground station latitude
C.GS.lambda = deg2rad(-(97 + 5 / 60 + 34 / 3600)); %{rad} Ground station longitude
C.GS.hgs = 0.185; %{km} Ground station altitude above mean equator
C.GS.We = C.E.we * [cos(C.GS.phi); 0; -sin(C.GS.phi)]; %{rad/s} Earth's rotational velocity in NED coordinates
C.GS.Rgse = (C.E.Re + C.GS.hgs) * [0; 0; -1]; %{km} Ground station position in NED coordinates
C.GS.Vgse = cross(C.GS.We, C.GS.Rgse); %{km/s} Ground station velocity in NED coordinates
C.GS.Agse = cross(C.GS.We, C.GS.Vgse); %{km/s^2} Ground station acceleration in NED coordinates
C.GS.EcefToNed = Ecef2Ned(C.GS.phi, C.GS.lambda); %{} ECEF to NED transformation matrix
C.GS.NedToEcef = transpose(C.GS.EcefToNed); %{} NED to ECEF transformation matrix

% Projectile Constants
C.P.mcg = 35; %{kg} Projectile mass
C.P.Cl = 0.173; %{} Projectile lift coefficient
C.P.Cd = 0.820; %{} Projectile drag coefficient
C.P.A = 6006.25 * pi * 1E-12; %{km^2} Projectile reference area
C.P.Ixx = 0.063065625E-6; %{kg-km^2} Moment of inertia about the x-axis
C.P.Iyy = 1.3440328125E-6; %{kg-km^2} Moment of inertia about the y-axis
C.P.Izz = 1.3440328125E-6; %{kg-km^2} Moment of inertia about the z-axis
C.P.Icg = diag([C.P.Ixx, C.P.Iyy, C.P.Izz]); %{kg-km^2} Moment of inertia matrix at the CG
C.P.Icginv = inv(C.P.Icg); %{1/(kg-km^2)} Inverse moment of inertia matrix at the CG
C.P.Rcpcg = -1E-6 * [1; 0; 0]; %{km} Center of pressure position WRT the CG
C.P.vcggs = 0.827; %{km/s} Speed WRT the ground station at launch
C.P.Azimuth = deg2rad(107); %{rad} Azimuth angle at launch
C.P.Elevation = deg2rad(45); %{rad} Elevation angle at launch
end
