% estados en los que se puede encontrar la ninya
estado(dormida).
estado(despertada).
estado(banyada).
estado(aliviada).
estado(desayunada).
estado(jugando).

% posibles transiciones entre estados
transicion('despertar', 'despertarla', dormida, despierta).
transicion('dejar_mas', 'dejarla dormir un poco más', dormida, remoloneando).
transicion('despertar', 'despertarla', remoloneando, despierta).

transicion('bañar', 'bañarla', despierta, bañada).
transicion('hacer_pis', 'llevarla a hacer pis', despierta, aliviada).
transicion('desayunar', 'darle el desayuno', despierta, desayunada).
transicion('jugar_salon', 'dejarla jugar un rato en el salon', despierta, jugando).

% Estados visitables desde jugando
transicion('bañar', 'bañarla',jugando, bañada).
transicion('hacer_pis', 'llevarla a hacer pis', jugando, aliviada).
transicion('desayunar', 'darle el desayuno', jugando, desayunada).

% Estados visitables desde bañada
transicion('hacer_pis', 'llevarla a hacer pis', bañada, aliviada).
transicion('desayunar', 'darle el desayuno', bañada, desayunada).
transicion('jugar_salon', 'dejarla jugar un rato en el salon', bañada, jugando).

transicion('salir', 'salir', Estado, 'triste porque te vas').

despertar(dormida, despierta).
banyar(despierta, banyada).
hacer_pis(despierta, aliviada).
desayunar(despierta, desayunada).
jugar_salon(despierta, jugando).

% estado inicial

:-dynamic actual/1, contador/2, estados_matinales_visitados/1.
actual(dormida).
estados_matinales_visitados([]).

inicio :-
  retractall(contador(X, Y)),
  retractall(estados_matinales_visitados([])),
  asserta(estados_matinales_visitados([])),
  Humor is random(100),
  Hambre is random(100),
  Piscaca is random(100),
  asserta(contador(humor, Humor)),
  asserta(contador(hambre, Hambre)),
  asserta(contador(piscaca, Piscaca)),
  asserta(contador(sueño, 0)),
  lucia.

lucia :-
  cambiar(dormida),
  write('*** Bienvenido a L.U.C.I.A'),
  nl,
  actual(Estado),

  que_hago(Estado, Estado),
  control_principal(Estado).


control_principal(EstadoAnterior) :-
  condicion_fin(EstadoAnterior).
control_principal(EstadoAnterior) :-
  repeat,
  write('> '),
  read(X),
  hacer(X),
  actual(NuevoEstado),
  que_hago(EstadoAnterior, NuevoEstado),
  control_principal(NuevoEstado).

% condicion de fin

condicion_fin(Estado) :-
  actual(Estado) = actual(hasta_mañana),
  write('El juego ha terminado').
condicion_fin(Estado) :-
  actual(Estado) = actual('triste porque te vas'),
  retractall(contador(X, Y)),
  retract(actual(Estado)),
  asserta(actual(dormida)),
  write('Has abandonado el juego.').

sucesos(EstadoAnterior, Estado) :-
	actual(Estado) = actual(despierta),
	EstadoAnterior = dormida,
	writeln('papá: Que tal ha dormido mi niña?'),
	% bien o mal, es una cuestión aleatoria
	random_between(0, 1, R),
	cambia_sueño(R).
sucesos(EstadoAnterior, Estado) :-
	actual(Estado) = actual(despierta),
	EstadoAnterior = remoloneando,
	writeln('papá: Que tal ha dormido mi niña?'),
	writeln('nena: Muy bien, papá!!'),
	writeln('papá: Corre, que vamos tarde...').
sucesos(EstadoAnterior, Estado) :-
	actual(Estado) = actual(jugando),
	EstadoAnterior = despierta,
	writeln('nena: ¡Vamos a jugar al salón!'),
	writeln('papá: ¡¡Pero que primero hay que hacer pis!!'),
	writeln('nena: No, venga, un poquito'),
	writeln('papá: Corre, que vamos tarde...'),
	writeln('*** El humor de la niña mejora, pero sube todo lo demás... ahora tiene más hambre y ganas de hacer pis. ¡¡Cuidado!!'),
	estados_matinales_visitados(X),
	append(X, Estado,Y),
	retract(estados_matinales_visitados(X)),
	asserta(estados_matinales_visitados([Y])),
	findall(Indicador, (contador(Indicador, Valor),Indicador \= sueño), Suben),
	maplist(incrementa_indicador,Suben).
	
sucesos(EstadoAnterior, Estado) :-
	true.

incrementa_indicador(Indicador) :-
	retract(contador(Indicador, AntiguoValor)),
	NuevoValor is AntiguoValor + 10,
	asserta(contador(Indicador, NuevoValor)).
	
reduce_indicador(Indicador) :-
	retract(contador(Indicador, AntiguoValor)),
	NuevoValor is AntiguoValor - 10,
	asserta(contador(Indicador, NuevoValor)).

cambia_sueño(R) :-
	R == 0,
	writeln('nena: Déjameeeeee'),
	incrementa_indicador(sueño).
cambia_sueño(R) :-
	R == 1,
	writeln('nena: Muy bien, papá!!').

% muestra las transiciones posibles desde un estado dado
listar_transiciones(Estado) :-
 
  constraint_transiciones(Estado, Accion, Descripcion),
  tab(2),
  write('- '), write(Accion), write(': '), write(Descripcion),
  nl,
  fail.
listar_transiciones(_).

print_indicador(Indicador, Valor) :-
	tab(2),
    write('- '), write(Indicador), write(': '), write(Valor),
    nl.
    
constraint_transiciones(Estado, Accion, Descripcion) :-
    transicion(Accion, Descripcion, Estado, EstadoDestino), 
    estados_matinales_visitados(Visitados), 
    not(member(EstadoDestino, Visitados)).
    

puedo_hacer(Estado):-
  actual(EstadoActual),
  transicion(Accion, Descripcion, EstadoActual, EstadoDestino).
puedo_hacer(EstadoDestino):-
  writeln('Ahora no toca hacer eso.'),
  fail.
  
cambiar(Estado) :-
  retract(actual(X)),
  asserta(actual(Estado)).
    
hacer(Accion):-
	transicion(Accion, Descripcion, EstadoActual, Estado),
	puedo_hacer(Estado),
	cambiar(Estado).

% indica en que estado se encuentra la ninya y que se puede hacer
que_hago(EstadoAnterior, Estado) :-
  write('Lucía está '), write(Estado), nl,
  sucesos(EstadoAnterior, Estado),
  forall(contador(P,Q), print_indicador(P,Q)),
  writeln('¿Qué hacemos ahora? (introduzca un comando seguido de punto . )'),
  estados_matinales_visitados(Visitados),
  writeln(Visitados),
  forall((transicion(Accion, Descripcion, Estado, EstadoDestino), \+ member(EstadoDestino, Visitados)), print_indicador(Accion,Descripcion))
  .
  %listar_transiciones(Estado).
