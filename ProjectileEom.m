function dSdt = ProjectileEom(~,S,C)
    
    Rcggs = S(1:3);
    %[km]Projectile position WRT the ground station in NED coordinates.

    Vcggs = S(4:6);
    %[km/s]Projectile velocity WRT the ground station in NED coordinates.

    Wcg = S(7:9);
    %[rad/s]Projectile rotational velocity WRT the CG in Body coordinates.

    Q = S(10:13);
    %[]Projectile quaternion.


    NED.Rcge = C.GS.Rgse + Rcggs;
    %[km]Projectile position WRT the Earth in NED coordinates.

    NED.Vcge = C.GS.Vgse + cross(C.GS.We,Rcggs) + Vcggs;
    %[km/s]Projectile velocity WRT the Earth in NED coordinates.

    NED.Vinf = NED.Vcge - cross(C.GS.We,NED.Rcge);
    %[km/s]Projectile true air velocity in NED coordinates.

    %-----------------------------------------------------------------------------------------------

    NedToBody = Ned2Body(NED,Q,C);
    %[]Matrix that transforms vectors from NED coordinates to Body coordinates.

    BodyToNed = transpose(NedToBody);
    %[]Matrix that transforms vectors from Body coordinates to NED coordinates.

    %-----------------------------------------------------------------------------------------------

    Body.Rcge = NedToBody * NED.Rcge;
    %[km]Projectile position WRT the Earth in Body coordinates.

    Body.Vcge = NedToBody * NED.Vcge;
    %[km/s]Projectile velocity WRT the Earth in Body coordinates.

    Body.Vinf = NedToBody * NED.Vinf;
    %[km/s]Projectile true air velocity in Body coordinates.

    %-----------------------------------------------------------------------------------------------

    hcg = norm(NED.Rcge) - C.E.Re;
    %[km]Projectile altitude above mean equator.

    [~,~,rho] = StandardAtmosphere(hcg);
    %[kg/km^3]Atmospheric density.

    %-----------------------------------------------------------------------------------------------

    Body = Magnus(Body,Wcg,rho,C);
    %[kN,km-kN]Magnus force and Magnus moment WRT the CG in Body coordinates, respectively.

    NED.Fm = BodyToNed * Body.Fm;
    %[kN]Magnus force WRT the CG in NED coordinates.

    %-----------------------------------------------------------------------------------------------

    Body = Drag(Body,rho,C);
    %[kN,km-kN]Drag force and drag moment WRT the CG in Body coordinates, respectively.

    NED.Fd = BodyToNed * Body.Fd;
    %[kN]Drag force WRT the CG in NED coordinates.

    %-----------------------------------------------------------------------------------------------

    NED = Gravity(NED,C);
    %[km/s^2]Acceleration due to gravity in NED coordinates.

    %-----------------------------------------------------------------------------------------------

    dWdt = Euler(Wcg,Body,C);
    %[rad/s^2]Projectile rotational acceleration WRT the CG in Body coordinates.

    dQdt = Qdot(Q,Wcg);
    %[]Projectile quaternion rate of change WRT to time.

    %-----------------------------------------------------------------------------------------------
    
    dSdt = zeros(13,1);
    %[]Allocates memory for the state vector derivative.
    
    dSdt(1:3) = Vcggs;
    %[m/s]Projectile velocity WRT the ground station in NED coordinates.
    
    dSdt(4:6) = ...
        (NED.Fm + NED.Fd) / C.P.mcg  + NED.g ...
        - C.GS.Agse ...
        - cross(C.GS.We,cross(C.GS.We,Rcggs)) ...
        - 2 * cross(C.GS.We,Vcggs);
    %[m/s^2]Projectile acceleration WRT the ground station in NED coordinates.

    dSdt(7:9) = dWdt;
    %[rad/s^2]Projectile rotational acceleration WRT the CG in Body coordinates.

    dSdt(10:13) = dQdt;
    %[rad/s^2]Projectile quaternion rate of change WRT time.
    
end
%===================================================================================================