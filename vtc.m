% Given parameters
close all;
clear all;
clc;
% Given parameters
V_DD = 5;          % Supply voltage (V)
k_n = 40e-6;       % Process transconductance parameter (A/V^2)
R_L = 100e3;       % Load resistance (Ohms)
V_T = 1.5;           % Threshold voltage (V), assumed value for typical NMOS

% Define the range for V_in
V_in = linspace(0, V_DD, 100);
V_out = zeros(size(V_in));

% Calculate V_out for each V_in
for i = 1:length(V_in)
    V_GS = V_in(i);  % Gate-source voltage
    if V_GS < V_T
        % NMOS is in cutoff region
        I_D = 0;
    else
        % NMOS is in either saturation or linear region
        V_DS = V_DD - V_out(i);  % Drain-source voltage (initial guess)
        if V_DS >= V_GS - V_T
            % NMOS is in saturation region
            I_D = k_n / 2 * (V_GS - V_T)^2;
        else
            % NMOS is in linear region
            I_D = k_n * ((V_GS - V_T) * V_DS - V_DS^2 / 2);
        end
    end
       
    V_out(i) = V_DD - I_D * R_L;
end

% Plot the Voltage Transfer Curve
figure;
plot(V_in, V_out, 'r', 'LineWidth', 2);
xlabel('V_{in} (V)');
ylabel('V_{out} (V)');
title('Voltage Transfer Curve for NMOS Inverter');
grid on;
legend('VTC', 'Ideal Inverter');
