function So = InitialConditions(C)

    Rcggs = zeros(3,1);
    %[km]Initial projectile position WRT the ground station in NED coordinates.

    %-----------------------------------------------------------------------------------------------

    Vcggs = C.P.vcggs * [ ...
         cos(C.P.Elevation) * cos(C.P.Azimuth); ...
         cos(C.P.Elevation) * sin(C.P.Azimuth); ...
        -sin(C.P.Elevation)];
    %[km/s]Initial rojectile velocity WRT the ground station in NED coordinates.

    %-----------------------------------------------------------------------------------------------

    Wcg = zeros(3,1);
    %[rad/s]Initial projectile rotational velocity in Body coordinates.

    %-----------------------------------------------------------------------------------------------

    Roll = 0;
    %[rad]Initial projectile roll angle.

    Pitch = C.P.Elevation;
    %[rad]Initial projectile pitch angle.

    Yaw = C.P.Azimuth;
    %[rad]Initial projectile yaw angle.

    T1 = [ ...
        1,          0,         0; ...
        0,  cos(Roll), sin(Roll); ...
        0, -sin(Roll), cos(Roll)];
    %[]Matrix that transforms vectors about the 1-axis by an angle Roll.

    T2 = [ ...
        cos(Pitch), 0, -sin(Pitch); ...
                 0, 1,           0; ...
        sin(Pitch), 0,  cos(Pitch)];
    %[]Matrix that transforms vectors about the 2-axis by an angle Pitch.

    T3 = [ ...
         cos(Yaw), sin(Yaw), 0; ...
        -sin(Yaw), cos(Yaw), 0; ...
                0,        0, 1];
    %[]Matrix that transforms vectors about the 3-axis by an angle Yaw.

    LhToBody = T1 * T2 * T3;
    %[]Matrix that transforms vectors from LH coordinates to Body coordinates.

    Q = DCM2Q(LhToBody);
    %[]Initial projectile quaternion.

    So = [Rcggs; Vcggs; Wcg; Q];
    %[km,km/s,rad/s,-]Initial projectile state.

end
