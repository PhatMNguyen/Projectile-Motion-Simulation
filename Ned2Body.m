function NedToBody = Ned2Body(NED,Q,C)

    ECEF.Rcge = C.GS.NedToEcef * NED.Rcge;
    %[km]Projectile position WRT the Earth in ECEF coordinates.

    %-----------------------------------------------------------------------------------------------

    x = ECEF.Rcge(1);
    %[km]Projectile x-position WRT the Earth in ECEF coordinates.

    y = ECEF.Rcge(2);
    %[km]Projectile y-position WRT the Earth in ECEF coordinates.

    z = ECEF.Rcge(3);
    %[km]Projectile z-position WRT the Earth in ECEF coordinates.

    rcge = norm(ECEF.Rcge);
    %[km]Projectile range WRT the Earth.

    %-----------------------------------------------------------------------------------------------

    phi = asin(z / rcge);
    %[rad]Projectile latitude WRT the Earth.

    lambda = atan2(y,x);
    %[rad]Projectile longitude WRT the Earth.

    %-----------------------------------------------------------------------------------------------

    EcefToLH = Ecef2LH(phi,lambda);
    %[]Matrix that transforms vectors from ECEF coordinates to LH coordinates.

    LHToBody = Q2DCM(Q);
    %[]Matrix that transforms vectors from LH coordinates to Body coordinates.

    NedToBody = LHToBody * EcefToLH * C.GS.NedToEcef;
    %[]Matrix that transforms vectors from NED coordinates to Body coordinates.

end
