function Body = Drag(Body,rho,C)

    Body.Fd = -0.5 * C.P.Cd * rho * C.P.A * norm(Body.Vinf) * Body.Vinf;
    %{kN}Drag force WRT to the CG in Body coordinates.

    Body.Md = cross(C.P.Rcpcg,Body.Fd);
    %{km-kN}Drag moment WRT the CG in Body coordinates.

end
