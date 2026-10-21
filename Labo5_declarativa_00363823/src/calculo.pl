% --- 1. Casos Base (Derivadas) ---

% Derivada de K*x^N
d(Var, K*Var^N, C*Var^Nm1) :-
    atomic(Var), number(K), number(N),
    is(C, K * N), is(Nm1, N - 1), !.

% Derivada de x^N
d(Var, Var^N, N*Var^Nm1) :-
    atomic(Var), number(N),
    is(Nm1, N - 1), !.

% Derivada de N*x
d(Var, N*Var, N) :-
    atomic(Var), number(N), !.

% Derivada de logaritmo natural
d(Var, log(Var), 1/Var) :-
    atomic(Var), !.

% Derivada de x respecto a x
d(Var, Func, 1) :-
    Var == Func, !.

% Derivada de una constante
d(Var, Func, 0) :-
    atomic(Var), number(Func), !.

% --- 2. Reglas Recursivas (Linealidad de Derivadas) ---

d(Var, F + G, DF + DG) :-
    !, d(Var, F, DF), d(Var, G, DG).

d(Var, F - G, DF - DG) :-
    !, d(Var, F, DF), d(Var, G, DG).

d(Var, K * F, K * DF) :-
    number(K), !, d(Var, F, DF).


% --- 3. Casos Base (Integrales) ---

% Integral de K*x^N
s(Var, K*Var^N, K/M*Var^M) :-
    atomic(Var), number(K), number(N),
    is(M, N + 1), !.

% Integral de x^N
s(Var, Var^N, 1/M*Var^M) :-
    atomic(Var), number(N),
    is(M, N + 1), !.

% Integral de x
s(Var, Var, 1/2*Var^2) :-
    atomic(Var), !.

% Integral de una constante
s(Var, K, K*Var) :-
    number(K), atomic(Var), !.

% --- 4. Reglas Recursivas (Linealidad de Integrales) ---

s(Var, F + G, IF + IG) :-
    !, s(Var, F, IF), s(Var, G, IG).

s(Var, F - G, IF - IG) :-
    !, s(Var, F, IF), s(Var, G, IG).

s(Var, K * F, K * IF) :-
    number(K), !, s(Var, F, IF).

    % Regla para sumar
    suma(Var, A + B, R) :-
        R is A + B.

    % Regla para restar
    resta(Var, A - B, R) :-
        R is A - B.