function [T, P, D] = StandardAtmosphere(h)
    
    h = h * 1000; % Convert altitude from kilometers to meters
    
    g = 9.81; % Sea-level acceleration due to gravity (m/s^2)
    R = 287; % Specific gas constant (J/kg/K)
    
    if h < 0
        T = 288.16; % Generic atmospheric temperature (K)
        P = 101325; % Generic atmospheric pressure (Pa)
        D = 2.65E12; % Generic atmospheric density (kg/km^3)
        fprintf('The object is below Earth mean equator!\n');
        return;
        
    elseif h == 0
        T = 288.16; % Sea-level atmospheric temperature (K)
        P = 101325; % Sea-level atmospheric pressure (Pa)
        D = 1.225 * 1E9; % Sea-level atmospheric density (kg/km^3)
        return;
        
    elseif (h > 0) && (h <= 11e3)
        a = (216.66 - 288.16) / 11e3; % Temperature gradient (K/m)
        T = 288.16 + a * h;
        P = 101325 * (T / 288.16)^(-g / (a * R));
        D = 1.225 * (T / 288.16)^(-g / (a * R) - 1) * 1E9;
        return;
        
    elseif (h > 11e3) && (h <= 25e3)
        T = 216.66; % Constant temperature (K)
        P = 22650.1684742737 * exp(-g / (R * T) * (h - 11e3));
        D = 0.364204971415039 * exp(-g / (R * T) * (h - 11e3)) * 1E9;
        return;
        
    elseif (h > 25e3) && (h <= 47e3)
        a = (282.66 - 216.66) / (47e3 - 25e3); % Temperature gradient (K/m)
        T = 216.66 + a * (h - 25e3);
        P = 2493.58245271879 * (T / 216.66)^(-g / (a * R));
        D = 0.0400957338107663 * (T / 216.66)^(-g / (a * R) - 1) * 1E9;
        return;
        
    elseif (h > 47e3) && (h <= 53e3)
        T = 282.66; % Constant temperature (K)
        P = 120.879682128688 * exp(-g / (R * T) * (h - 47e3));
        D = 0.001489848563098 * exp(-g / (R * T) * (h - 47e3)) * 1E9;
        return;
        
    elseif (h > 53e3) && (h <= 79e3)
        a = (165.66 - 282.66) / (79e3 - 53e3); % Temperature gradient (K/m)
        T = 282.66 + a * (h - 53e3);
        P = 58.5554504138705 * (T / 282.66)^(-g / (a * R));
        D = 0.000721699065751904 * (T / 282.66)^(-g / (a * R) - 1) * 1E9;
        return;
        
    elseif (h > 79e3) && (h <= 90e3)
        T = 165.66; % Constant temperature (K)
        P = 1.01573256565262 * exp(-g / (R * T) * (h - 79e3));
        D = 2.1360671021146e-005 * exp(-g / (R * T) * (h - 79e3)) * 1E9;
        return;
        
    elseif (h > 90e3) && (h <= 105e3)
        a = (225.66 - 165.66) / (105e3 - 90e3); % Temperature gradient (K/m)
        T = 165.66 + a * (h - 90e3);
        P = 0.105215646463089 * (T / 165.66)^(-g / (a * R));
        D = 2.21266589885421e-006 * (T / 165.66)^(-g / (a * R) - 1) * 1E9;
        return;
        
    elseif (h > 105e3) && (h <= 500e3)
        a = (4 - 225.66) / (500e3 - 105e3); % Temperature gradient (K/m)
        T = 225.66 + a * (h - 105e3);
        P = 0.00751891790761519 * (T / 225.66)^(-g / (a * R));
        D = 1.1607907298299e-007 * (T / 225.66)^(-g / (a * R) - 1) * 1E9;
        return;
        
    elseif (h > 500e3)
        T = 4; % Constant temperature (K)
        P = 0; % Pressure (Pa)
        D = 0; % Density (kg/m^3)
        return;
    end
    
end