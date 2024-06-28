function Body = Magnus(Body,Wcg,rho,C)

    if norm(Wcg) == 0

        Body.Fm = zeros(3,1);
        %[kN]Magnus force WRT the CG in Body coordinates.

    else

        Dot = dot(Body.Vinf,Body.Vinf);
        %[km^/s^2]True air speed squared.

        Cross = cross(Wcg,Body.Vinf);
        %[km/s^2]Cross product of the projectile's rotational velocity in body coordinates and the
        %projectile's true air velocity in Body coordinates.

        Direction = Cross / norm(Cross);
        %[]Magnus force direction in Body coordinates.

        Body.Fm = 0.5 * C.P.Cl * rho * C.P.A * Dot * Direction;
        %[kN]Magnus force WRT the CG in Body coordinates.

    end

    Body.Mm = cross(C.P.Rcpcg,Body.Fm);
    %[km-kN]Magnus moment WRT the CG in Body coordinates.

end
