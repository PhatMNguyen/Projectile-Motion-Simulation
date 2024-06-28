function dQdt = Qdot(Q,Wcg)

    Omega = [ ...
              0,  Wcg(3), -Wcg(2), Wcg(1); ...
        -Wcg(3),       0,  Wcg(1), Wcg(2); ...
         Wcg(2), -Wcg(1),       0, Wcg(3); ...
        -Wcg(1), -Wcg(2), -Wcg(3),      0];
    %[rad/s]Rotational velocity matrix.

    dQdt = 0.5 * Omega * Q;
    %[]Quaternion rate of change WRT time.

end
%===================================================================================================