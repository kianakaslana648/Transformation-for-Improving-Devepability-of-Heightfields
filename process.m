function process(V, F, viewer, lookat, lookup, worldsize, imagesize, lambda)
%[V,F] = Load_obj(name);
image = get_depth_from_VF_advance(V, F, viewer, lookat, lookup, worldsize, imagesize);


[X, Y, Z, h] = squad_to_hex(image, worldsize);
[INT, BOU, INT_MAT] = interior(Z);

[bad, INT, BOU] = remove_badedge(Z, INT, h);

[C, C_local, normal, ind] = calculate_C(Z, h, INT);
rho = 1;
m = size(Z, 1);
n = size(Z, 2);
Z = Z(:);
H0 = C * Z;
Z = reshape(Z, m, n);
All = 1:(m*n);
fastened = setdiff(setdiff(All, INT), BOU);
background = fastened;
free = setdiff(All, fastened);
[step, H, Z] = ADMM(Z, C, H0, INT, lambda, rho, fastened, free);

Z = restore_bad(X, Y, Z, INT, background, C_local, normal, ind);

[V, F] = XYZ_to_VF(X,Y,Z,'hex');
VF_to_obj(V,F,'test.obj');

end

