%Euler angle to Quaternion
function Q = DCM2Q(DCM)

    K = zeros(4,4);
    K(1,1) = DCM(1,1) - DCM(2,2) - DCM(3,3);
    K(1,2) = DCM(2,1) + DCM(1,2);
    K(1,3) = DCM(3,1) + DCM(1,3);
    K(1,4) = DCM(2,3) - DCM(3,2);
    K(2,1) = DCM(2,1) + DCM(1,2);
    K(2,2) = -DCM(1,1) + DCM(2,2) - DCM(3,3);
    K(2,3) = DCM(3,2) + DCM(2,3);
    K(2,4) = DCM(3,1) - DCM(1,3);
    K(3,1) = DCM(3,1) + DCM(1,3);
    K(3,2) = DCM(3,2) + DCM(2,3);
    K(3,3) = -DCM(1,1) - DCM(2,2) + DCM(3,3);
    K(3,4) = DCM(1,2) - DCM(2,1);
    K(4,1) = DCM(2,3) - DCM(3,2);
    K(4,2) = DCM(3,1) - DCM(1,3);
    K(4,3) = DCM(1,2) - DCM(2,1);
    K(4,4) = DCM(1,1) + DCM(2,2) + DCM(3,3);

    K = 1 / 3 * K;
    %Eigen matrix update.

    [EigenVector,EigenValue] = eig(K);
    %Calculates the eigen values and respective eigen vectors for the eigen matrix.

    [~,Index] = max(diag(EigenValue));
    %Selects the maximum eigen value.

    Q = EigenVector(:,Index);
    %Quaternion

end
