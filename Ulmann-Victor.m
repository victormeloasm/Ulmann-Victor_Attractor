% Equações complexas integro-diferenciais de 2º ordem
d2xdt2 = @(t, x, y, z, dx, dy, dz) -y - z + 0.5*x.*(1 - x^2 - y^2 - z^2);
d2ydt2 = @(t, x, y, z, dx, dy, dz) x + 0.5*y.*(1 - x^2 - y^2 - z^2);
d2zdt2 = @(t, x, y, z, dx, dy, dz) 0.5*z.*(1 - x^2 - y^2 - z^2);

% Condições iniciais
x0 = 0.5;
y0 = -0.7;
z0 = 0.4;
dx0 = 0.1;
dy0 = -0.3;
dz0 = 0.2;

% Tempo de integração
tspan = [0, 200];
t = linspace(tspan(1), tspan(2), 50000);

% Integração das equações diferenciais de segunda ordem
sol = ode45(@(t, u) [
    u(4);
    u(5);
    u(6);
    d2xdt2(t, u(1), u(2), u(3), u(4), u(5), u(6));
    d2ydt2(t, u(1), u(2), u(3), u(4), u(5), u(6));
    d2zdt2(t, u(1), u(2), u(3), u(4), u(5), u(6))
], t, [x0, y0, z0, dx0, dy0, dz0]);

% Extraindo as soluções
x_sol = real(sol.y(1, :));
y_sol = real(sol.y(2, :));
z_sol = real(sol.y(3, :));

% Criando uma paleta de cores em gradiente
colors = jet(length(x_sol));
color_gradients = zeros(length(x_sol), 3);
for i = 1:length(x_sol)
    color_gradients(i, :) = colors(i, :);
end

% Plot 3D do atrator caótico usando scatter3 colorido
figure;
scatter3(x_sol, y_sol, z_sol, 10, color_gradients, 'filled');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Ulmann-Victor Attractor');
colormap(jet);
colorbar;
grid on;
view(3); % Garante visualização em 3D

% Posicionamento da visualização
view(30, 30); % Ajuste os ângulos conforme desejado

% Salvar o gráfico como um arquivo PNG
saveas(gcf, 'chaotic_butterfly_attractor.png');

disp('Gráfico salvo como "chaotic_butterfly_attractor.png"');
