function NED = Gravity(NED,C)

    rcge = norm(NED.Rcge);
    %[km]Projectile range WRT the Earth.

    NED.g = -C.E.mu * NED.Rcge / rcge^3;
    %[km/s^2]Acceleration due to gravity in NED coordinates.

end
