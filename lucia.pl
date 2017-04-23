% estados en los que se puede encontrar la ninya
estado(dormida).
estado(despertada).
estado(banyada).
estado(hecho_pis).
estado(desayunada).
estado(jugado).

% posibles transiciones entre estados
transicion('despertar', 'despertarla', dormida, despierta).
transicion('dejar_mas', 'dejarla dormir un poco más', dormida, remoloneando).
transicion('despertar', 'despertarla', remoloneando, despierta).
transicion('bañar', 'bañarla', despierta, bañada).
transicion('hacer_pis', 'llevarla a hacer pis', despierta, hecho_pis).
transicion('desayunar', 'darle el desayuno', despierta, desayunada).
transicion('jugar_salon', 'dejarla jugar un rato en el salon', despierta, jugado).
transicion('salir', 'salir', Estado, 'triste porque te vas').

despertar(dormida, despierta).
banyar(despierta, banyada).
hacer_pis(despierta, hecho_pis).
desayunar(despierta, desayunada).
jugar_salon(despierta, jugado).

% estado inicial
:-dynamic actual/1, contador/2.
actual(dormida).



inicio :-
  A is random(100),
  assert(contador(humor, A)),
  B is random(100),
  assert(contador(hambre, B)),
  assert(contador(sueño,0)),
 
  lucia.

lucia :-
  cambiar(dormida),
  write('Bienvenido a L.U.C.I.A'),
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
  write('has abandonado el juego').

sucesos(EstadoAnterior, Estado) :-
	actual(Estado) = actual(despierta),
	EstadoAnterior = dormida,
	writeln('papá: Que tal ha dormido mi niña?'),
	random_between(0, 1, R),
	cambia_sueño(R).
sucesos(EstadoAnterior, Estado) :-
	actual(Estado) = actual(despierta),
	EstadoAnterior = remoloneando,
	writeln('papá: Que tal ha dormido mi niña?'),
	writeln('nena: Muy bien, papá!!'),
	writeln('papá: Corre, que vamos tarde...').
sucesos(EstadoAnterior, Estado) :-
	true.

cambia_sueño(R) :-
	R == 0,
	writeln('nena: Déjameeeeee'),
	retract(contador(sueño, S)),
	NuevoSueño is S + 10,
	asserta(contador(sueño,NuevoSueño)).
cambia_sueño(R) :-
	R == 1,
	writeln('nena: Muy bien, papá!!').

% muestra las transiciones posibles desde un estado dado
listar_transiciones(Estado) :-
	
  transicion(Accion, Descripcion, Estado, EstadoDestino),
  tab(2),
  write('- '), write(Accion), write(': '), write(Descripcion),
  nl,
  fail.
listar_transiciones(_).

% mostrar indicadores de la niña
listar_indicadores :-
  contador(humor,A),
  contador(hambre,B),
  contador(sueño,C),
  tab(2),
  write('- Humor = '), write(A), nl,
  tab(2),
  write('- Hambre = '), write(B), nl,
  tab(2),
  write('- Sueño = '), write(C), nl.


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
  listar_indicadores,
  writeln('¿Qué hacemos ahora? (introduzca un comando seguido de punto . )'),
  listar_transiciones(Estado).
