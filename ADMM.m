function [step, H, Z] = ADMM(Z_prev, C, H, INT, lambda, rho, fastened, free)
%ADMM过程
m = size(Z_prev, 1);
n = size(Z_prev, 2);
U = zeros(4 * m * n, 1);
Z = Z_prev(:);
maxStep = 1000;
eps_abs = 10e-8;
eps_rel = 10e-6;
mu = 10;
tau_inc = 2;
tau_dec = 2;
% counterEnd_H = 0;
% counterEnd_Z = 0;
% counterEnd_U = 0;
% counterEnd_other = 0;
for curStep = 1:maxStep
    curStep
    %counterStart_H = cputime;
    H = update_H(Z, U, C, INT, rho);
    %counterEnd_H = counterEnd_H + cputime - counterStart_H;
    
    %counterStart_Z = cputime;
    Z0 = Z;
    Z = update_z(Z, H, U, C, lambda, rho, fastened, free);
    %counterEnd_Z = counterEnd_Z + cputime - counterStart_Z;
    
    %counterStart_U = cputime;
    U = U + H - C * Z;
    %counterEnd_U = counterEnd_U + cputime - counterStart_U;
    
    %counterStart_other = cputime;
    Residual = norm(C * Z - H);
    Residual_dual = norm(rho * C * (Z - Z0));
    eps_pri = sqrt(4 * m * n) * eps_abs + eps_rel * max([norm(C * Z), norm(H)]);
    eps_dual = sqrt(m * n) * eps_abs + eps_rel * norm(rho * C' * U);
    %counterEnd_other = counterEnd_other + cputime - counterStart_other;
    
    if Residual < eps_pri && Residual_dual < eps_dual
        break;
    end
    if Residual > mu * Residual_dual
        rho = rho * tau_inc;
        U = U * tau_inc;
    elseif Residual_dual > mu * Residual
        rho = rho / tau_dec;
        U = U / tau_dec;
    end
end
%counter_all = counterEnd_H + counterEnd_Z + counterEnd_U + counterEnd_other;
% counterEnd_H = counterEnd_H / counter_all
% counterEnd_Z = counterEnd_Z / counter_all
% counterEnd_U = counterEnd_U / counter_all
% counterEnd_other = counterEnd_other / counter_all

step = curStep;
Z = reshape(Z, m, n);
end

