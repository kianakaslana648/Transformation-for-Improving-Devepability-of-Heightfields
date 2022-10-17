function [X, Y, Z, h] = squad_to_hex(image, worldsize)
%用差值方法从原网格求得新网格的值
Pi = 3.1415926;
m_input = size(image, 1);
n_input = size(image, 2);

%标准化原输入的网格
[X_input, Y_input] = meshgrid(linspace(-worldsize(1)/2, worldsize(1)/2, n_input),...
    linspace(-worldsize(2)/2, worldsize(2)/2, m_input));

%求六边形化的网格
hx = worldsize(1) / (size(X_input, 2)-1);
hy = hx * sin(Pi / 3);
h = hx;

[X, Y] = meshgrid(-worldsize(1)/2:hx:worldsize(1)/2, -worldsize(2)/2:hy:worldsize(2)/2);
m = size(X, 1);
n = size(X, 2);

if mod(m, 2) == 1
    X(2:2:(m-1),:) = X(2:2:(m-1),:) - hx / 2;
else
    X(2:2:m,:) = X(2:2:m,:) - hx / 2;
end

%从原网格上的值插值求六边形化网格上的值
image(image == 0) = NaN;
Z = interp2(X_input, Y_input, image, X, Y);
Z(isnan(Z)) = 0;
end

