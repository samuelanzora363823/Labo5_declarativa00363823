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


% --- 5. SUMA DE EXPRESIONES ALGEBRAICAS ---

% Caso: x^N + B*x^N (Ej. x^2 + 5*x^2)
suma(Var, Var^N + B*Var^N, C*Var^N) :-
    number(B), C is 1 + B, !.

% Caso: A*x^N + B*x^N (Ej. 3*x^2 + 5*x^2)
suma(Var, A*Var^N + B*Var^N, C*Var^N) :-
    number(A), number(B), C is A + B, !.

% Caso: A*x + B*x (Ej. 4*x + 2*x)
suma(Var, A*Var + B*Var, C*Var) :-
    number(A), number(B), C is A + B, !.

% Caso: x + B*x (Ej. x + 2*x)
suma(Var, Var + B*Var, C*Var) :-
    number(B), C is 1 + B, !.


% --- 6. RESTA DE EXPRESIONES ALGEBRAICAS ---

% Caso: A*x^N - B*x^N (Ej. 7*x^3 - 3*x^3)
resta(Var, A*Var^N - B*Var^N, C*Var^N) :-
    number(A), number(B), C is A - B, !.

% Caso: x^N - B*x^N (Ej. x^2 - 5*x^2)
resta(Var, Var^N - B*Var^N, C*Var^N) :-
    number(B), C is 1 - B, !.

% Caso: A*x - B*x (Ej. 8*x - 5*x)
resta(Var, A*Var - B*Var, C*Var) :-
    number(A), number(B), C is A - B, !.

% Caso: x - B*x (Ej. x - 5*x)
resta(Var, Var - B*Var, C*Var) :-
    number(B), C is 1 - B, !.

    % --- 7. UNIFICACIÓN DE BOTONES ---

    % Si presionas "Sumar" pero hay una resta, usa las reglas de resta
    suma(Var, A - B, Res) :- resta(Var, A - B, Res), !.

    % Si presionas "Restar" pero hay una suma, usa las reglas de suma
    resta(Var, A + B, Res) :- suma(Var, A + B, Res), !.

   % Caso combinado: simplificar los primeros dos términos semejantes y dejar el resto
   suma(Var, A*Var^N - B*Var^N + Resto, C*Var^N + Resto) :-
       number(A), number(B), C is A - B, !.

      % Sumar tres términos (Ej. 4*x + 2*x + 3*x)
      suma(Var, A*Var + B*Var + C*Var, Res*Var) :-
          number(A), number(B), number(C),
          Res is A + B + C, !.