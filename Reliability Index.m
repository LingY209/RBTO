%%
clear 
clc
bet = 2;
lateral = 6.8445e5;
hoisting1_x = 9.3478e6;
hoisting1_y = 1.0984e7;
hoisting2_x = 1.2204e7;
hoisting2_y = 1.0386e7;
yongs = 2e11;
poisson = 0.3;
%% Reliability Computation
U = [lateral, hoisting1_x, hoisting1_y, hoisting2_x, hoisting2_y, yongs, poisson];
d = 0;
count1 = 0;
while d - bet < 0
    rlateral = normrnd(lateral, 0.1*lateral, [1,1]);
    rhoisting1_x = normrnd(hoisting1_x, 0.1*hoisting1_x, [1,1]);
    rhoisting1_y = normrnd(hoisting1_y, 0.1*hoisting1_y, [1,1]);
    rhoisting2_x = normrnd(hoisting2_x, 0.1*hoisting2_x, [1,1]);
    rhoisting2_y = normrnd(hoisting2_y, 0.1*hoisting2_y, [1,1]);
    ryongs = normrnd(yongs, 0.1*yongs, [1,1]);
    rpoisson = normrnd(poisson, 0.1*poisson, [1,1]);
    R = [rlateral, rhoisting1_x, rhoisting1_y, rhoisting2_x, rhoisting2_y, ryongs, rpoisson];
    S = 0.1 * U;
    X = (R - U) ./ S;
    d = sqrt(X(1)^2 + X(2)^2 + X(3)^2 + X(4)^2 + X(5)^2 + X(6)^2 + X(7)^2);
    count1 = count1 + 1;
end
alpha = 1;
count2 = 0;
diff = 1;
while diff > 0.01
    Z = X;
    dDdX = [X(1)/d, X(2)/d, X(3)/d, X(4)/d, X(5)/d, X(6)/d, X(7)/d];
    X = X - alpha * dDdX;
    d = sqrt(X(1)^2 + X(2)^2 + X(3)^2 + X(4)^2 + X(5)^2 + X(6)^2 + X(7)^2);
if d < bet
    X = Z;
    alpha = alpha/2;
else
    diff = d - bet;
end
count2 = count2 + 1;
end
M = U + X .* S;
%% Subsequently, professional software can be used for finite element analysis.