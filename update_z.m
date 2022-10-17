function Z = update_z(Z0, H, U, C, lambda, rho, fastened, free)
%求解argmin_z(lambda * ||z - z0||^2 + rho / 2 * ||h - Cz + u||^2)
C = sparse(C);
%reserve = Z0;
Z0(fastened) = 0;
free = free(:);
temp_eye = sparse(free, free, ones(length(free),1), size(C,2), size(C,2));
%temp_eye = full(temp_eye);
A = rho * (C' * C);
A = A + 2 * lambda * temp_eye;
%A = sparse(A);
B = -2 * lambda * Z0 - rho * C' * (H + U);
B = sparse(B);
%options = optimset('Largescale','on','MaxIter',10);
options = optimoptions('quadprog');
%options = optimset('Algorithm', 'interior-point-convex');
%fastened = fastened(:);
%free = free(:);
%Aeq = sparse(fastened, fastened, ones(length(fastened), 1), size(C, 2), size(C, 2));
%spy(Aeq)
%Beq = Z0;
%Beq(free) = 0;
%Beq = sparse(Beq);
%lb = zeros(size(Z0,1), 1);
%lb = zeros(1, size(Z0,1));
Z = quadprog(A, B, [], [], [], [], [], [], [], options);
%Z(fastened) = reserve(fastened);
%fun = @(z)norm(z - Z0)^2 + rho / 2 * norm(C * z - H + U)^2;
%fun = @(z)z'* A *z + B' * z;
%Z = fmincon(fun, Z0, [], [], Aeq, Beq, lb, [], [], options);
end