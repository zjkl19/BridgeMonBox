% —— 符号演算 —— 
syms b1 b2 h1 h2 real positive

% 面积与质心位置
A1 = b1*h1;   A2 = b2*h2;
y1 = h2 + h1/2;
y2 = h2/2;
ybar = (A1*y1 + A2*y2)/(A1 + A2);

% 各自质心惯性矩
I1c = b1*h1^3/12;
I2c = b2*h2^3/12;

% 组合惯性矩
I_total = I1c + A1*(y1 - ybar)^2 + I2c + A2*(y2 - ybar)^2;
I_simplified = simplify(I_total)

% —— 数值验证 —— 
% 例如取 b1=2, h1=1, b2=3, h2=2
vals = [2, 3, 1, 2];   % [b1, b2, h1, h2]
I_num = double( subs(I_simplified, [b1,b2,h1,h2], vals) );

% 直接用数值公式再算一次
A1n = vals(1)*vals(3);  A2n = vals(2)*vals(4);
y1n = vals(4) + vals(3)/2;
y2n = vals(4)/2;
ybar_n = (A1n*y1n + A2n*y2n)/(A1n + A2n);
I1cn = vals(1)*vals(3)^3/12;
I2cn = vals(2)*vals(4)^3/12;
I_direct = I1cn + A1n*(y1n-ybar_n)^2 + I2cn + A2n*(y2n-ybar_n)^2;

fprintf('符号化简后的 I = %s\n', char(I_simplified));
fprintf('数值例子 I_num = %.6f\n', I_num);
fprintf('直接数值计算 I_direct = %.6f\n', I_direct);
