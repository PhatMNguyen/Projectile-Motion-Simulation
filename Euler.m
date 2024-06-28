function dWdt = Euler(Wcg,Body,C)

    M = Body.Mm + Body.Md;
    %[km-kN]Sum of the moments WRT the CG in Body coordinates.

    dWdt = C.P.Icginv * (M - cross(Wcg,C.P.Icg * Wcg));
    %[rad/s^2]Projectile rotational acceleration WRT the CG in Body coordinates.

end
