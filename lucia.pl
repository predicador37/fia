% estados en los que se puede encontrar la ninya
estado(dormida).
estado(despertada).
estado(banyada).
estado(hecho_pis).
estado(desayunada).
estado(jugado).

% posibles transiciones entre estados
transicion('despertar', 'despertarla', dormida, despierta).
transicion('banyar', 'dejarla dormir un poco más', dormida, despierta).
transicion('hacer_pis', 'banyarla', despierta, banyada).
transicion('desayunar', 'llevarla a hacer pis', despierta, hecho_pis).
transicion('desayunar', 'darle el desayuno', despierta, desayunada).
transicion('jugar_salon', 'dejarla jugar en el salon', despierta, jugado).
transicion('salir', 'salir', Estado, fin).

despertar(dormida, despierta).
banyar(despierta, banyada).
hacer_pis(despierta, hecho_pis).
desayunar(despierta, desayunada).
jugar_salon(despierta, jugado).

% estado inicial
:-dynamic actual/1, sueño/1.
sueño(0). 
actual(dormida).

inicio :-
  cambiar(dormida),
  lucia.

lucia :-
  write('Bienvenido a L.U.C.I.A'),
  nl,
  actual(Estado),
  que_hago(Estado),
  control_principal(Estado).


control_principal(Estado) :-
  condicion_fin(Estado).
control_principal(Estado) :-
  repeat,
  write('> '),
  read(X),
  ir(X),
  actual(NuevoEstado),
  que_hago(NuevoEstado),
  control_principal(NuevoEstado).

% condicion de fin

condicion_fin(Estado) :-
  actual(Estado) = actual(hasta_manyana),
  write('El juego ha terminado').
condicion_fin(Estado) :-
  actual(Estado) = actual(fin),
  write('has abandonado el juego').

sucesos(Estado) :-
	actual(Estado) = actual(despierta),
	writeln('Que tal ha dormido mi niña?'),
	random_between(0, 1, R),
	cambia_sueño(R).
sucesos(Estado) :-
	true.

cambia_sueño(R) :-
	R == 0,
	writeln('Déjameeeeee'),
	retract(sueño(S)),
	NuevoSueño is S + 10,
	asserta(sueño(NuevoSueño)).
cambia_sueño(R) :-
	R == 1,
	writeln('Muy bien, papá!!').

% muestra las transiciones posibles desde un estado dado
listar_transiciones(Estado) :-
	
  transicion(Accion, Descripcion, Estado, EstadoDestino),
  tab(2),
  write(Descripcion),
  write(': Escriba '),
  write(Accion),
  nl,
  fail.
listar_transiciones(_).

puedo_ir(Estado):-
  actual(EstadoActual),
  transicion(Accion, Descripcion, EstadoActual, EstadoDestino).
puedo_ir(EstadoDestino):-
  writeln('Ahora no toca hacer eso.'),
  fail.
  
cambiar(Estado) :-
  retract(actual(X)),
  asserta(actual(Estado)).
    
ir(Accion):-
	transicion(Accion, Descripcion, EstadoActual, Estado),
	puedo_ir(Estado),
	cambiar(Estado).

% indica en que estado se encuentra la ninya y que se puede hacer
que_hago(Estado) :-
  write('Lucia esta '), write(Estado), nl,
  sucesos(Estado),
  sueño(S),
  write('Sueño = '), write(S), nl,
  writeln('Que hacemos?:'),
  listar_transiciones(Estado).
