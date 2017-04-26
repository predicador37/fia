% estados en los que se puede encontrar la ninya
estado(dormida).
estado(despertada).
estado(banyada).
estado(aliviada).
estado(desayunando).
estado(jugando).

% posibles transiciones entre estados
transicion('despertar', 'despertarla', dormida, despierta).
transicion('dejar_mas', 'dejarla dormir un poco más', dormida, remoloneando).
transicion('despertar', 'despertarla', remoloneando, despierta).

transicion('bañar', 'bañarla', despierta, bañada).
transicion('hacer_pis', 'llevarla a hacer pis', despierta, aliviada).
transicion('desayunar', 'darle el desayuno', despierta, desayunando).
transicion('jugar_salon', 'dejarla jugar un rato en el salon', despierta, jugando).

% Estados visitables desde jugando
transicion('bañar', 'bañarla',jugando, bañada).
transicion('hacer_pis', 'llevarla a hacer pis', jugando, aliviada).
transicion('desayunar', 'darle el desayuno', jugando, desayunando).

% Estados visitables desde bañada
transicion('hacer_pis', 'llevarla a hacer pis', bañada, aliviada).
transicion('desayunar', 'darle el desayuno', bañada, desayunando).
transicion('jugar_salon', 'dejarla jugar un rato en el salon', bañada, jugando).

% Estados visitables desde aliviada
transicion('bañar', 'bañarla', aliviada, bañada).
transicion('desayunar', 'darle el desayuno', aliviada, desayunando).
transicion('jugar_salon', 'dejarla jugar un rato en el salon', aliviada, jugando).

% Estados visitables desde desayunando
transicion('hacer_pis', 'llevarla a hacer pis', desayunando, aliviada).
transicion('bañar', 'darle el desayuno', desayunando, bañada).
transicion('jugar_salon', 'dejarla jugar un rato en el salon', desayunando, jugando).

transicion('salir', 'salir', _, 'triste porque te vas').

despertar(dormida, despierta).
banyar(despierta, banyada).
hacer_pis(despierta, aliviada).
desayunar(despierta, desayunando).
jugar_salon(despierta, jugando).

% estado inicial

:-dynamic actual/1, contador/2, penalizacion/1, estados_matinales_visitados/1.
actual(dormida).
penalizacion(0).
estados_matinales_visitados([]).

% bloque de inicialización de hechos necesarios y utilizados a modo de variable.
inicio :-
  retractall(contador(_, _)),
  retractall(estados_matinales_visitados([])),
  retractall(penalizacion(_)),
  asserta(penalizacion(0)),
  asserta(estados_matinales_visitados([])),
  Humor is random(100),
  Hambre is random(100),
  random(0, 50, Piscaca),
  PiscacaInicial is 50 + Piscaca,
  asserta(contador(humor, Humor)),
  asserta(contador(hambre, Hambre)),
  asserta(contador(piscaca, PiscacaInicial)),
  asserta(contador(sueño, 0)),
  lucia.

lucia :-
  cambiar(dormida),
  writeln('*** Bienvenido a L.U.C.I.A. , acrónimo recursivo de (Lucía, Única Candidata para Inteligencia Artificial'),
  writeln('*** En el siguiente simulador, tomarás el rol de papá de una niña maravillosa llamada Lucía.'),
  writeln('*** La simulación puede tomarse como un juego; el objetivo final es que, al acabar el día, el papá disponga del mayor tiempo posible para estudiar sus asignaturas de la UNED de este cuatrimestre.'),
  writeln('*** Ello depende, en parte, de una componente aleatoria que depende del día; y en otra parte, de las acciones y decisiones que el papá vaya tomando a lo largo del día'),
  writeln('*** Se ha pretendido que la simulación sea lo más real posible dentro de lo razonable. ¡Prueba suerte y disfruta!'),
  actual(Estado),
  que_hago(Estado, Estado),
  control_principal(Estado).

% predicado con llamada recursiva para implementar el menú y control principal del programa
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

% condición de fin para el control principal
condicion_fin(Estado) :-
  actual(Estado) = actual(hasta_mañana),
  write('El juego ha terminado').
condicion_fin(Estado) :-
  actual(Estado) = actual('triste porque te vas'),
  retractall(contador(_, _)),
  retract(actual(Estado)),
  asserta(actual(dormida)),
  write('Has abandonado el juego.').

% el siguiente predicado en todas sus variantes modela los distintos sucesos que acontecen según el estado en el que se encuentra el programa
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
	writeln('nena: ¡Vamos a jugar al salón!'),
	writeln('papá: ¡¡Pero que primero hay que hacer pis!!'),
	writeln('nena: No, venga, un poquito'),
	writeln('papá: Corre, que vamos tarde...'),
	writeln('*** El humor de la niña mejora, pero sube todo lo demás... ahora tiene más hambre y ganas de hacer pis. ¡¡Cuidado!!'),
	estados_matinales_visitados(X),
	append(X, Estado,Y),
	retract(estados_matinales_visitados(X)),
	asserta(estados_matinales_visitados([Y])),
	findall(Indicador, (contador(Indicador, _),Indicador \= sueño), Suben),
	maplist(incrementa_indicador,Suben).
sucesos(EstadoAnterior, Estado) :-
	actual(Estado) = actual(desayunando),
	writeln('papá: ¡A desayunar!'),
	writeln('nena: Quiero bolitas de chocolate.'),
	writeln('papá: Vale; pero te tomas toda la leche, ¿eh?'),
	writeln('nena: Vale, papá.'),
	writeln('*** A la niña se le quita el hambre, pero tarda mucho en desayunar...'),
	estados_matinales_visitados(X),
	append(X, Estado,Y),
	retract(estados_matinales_visitados(X)),
	asserta(estados_matinales_visitados(Y)),
	reduce_indicador(hambre),
	incrementa_indicador(piscaca).
sucesos(_, _) :-
	true.
	
% comprueba el estado de los indicadores y penaliza el tiempo en consecuencia	
check_indicadores :-
	contador(piscaca,Piscaca),
	contador(humor,Humor),
	contador(hambre,Hambre),
	(Piscaca >= 80 -> penaliza_pis),
	(Hambre >= 80 -> penaliza_hambre),
	(Humor =< 30 -> penaliza_humor).
check_indicadores :-
	true.

% calcula la penalización en tiempo cuando la niña se hace pis	
penaliza_pis :-
	writeln('*** Lucía no se ha podido aguantar más y se ha hecho pis. Como es muy sensible, se ve visiblemente afectada y su humor baja. Naturalmente, hay que lavarla y cambiarla, lo que provocará un cierto retraso...'),
	reduce_indicador(humor,20),
	retract(contador(piscaca, _)),
	asserta(contador(piscaca, 10)),
	penalizacion(Penalizacion),
	retract(penalizacion(Penalizacion)),
	NuevaPenalizacion is Penalizacion + 25,
	asserta(penalizacion(NuevaPenalizacion)).

% calcula la penalización en tiempo cuando la niña tiene mucho hambre	
penaliza_hambre :-
	writeln('*** Lucía tiene mucho hambre, lo que hace que se eche a llorar de repente. No te queda más remedio que darle rápidamente algo de comer de lo que tienes por la cocina. Naturalmente, el tiempo pasa...'), 
	reduce_indicador(humor,20),
	retract(contador(hambre, _)),
	asserta(contador(hambre, 10)),
	penalizacion(Penalizacion),
	retract(penalizacion(Penalizacion)),
	NuevaPenalizacion is Penalizacion + 15,
	asserta(penalizacion(NuevaPenalizacion)).

% calcula la penalización en tiempo cuando la niña está de muy mal humor	
penaliza_humor :-
	writeln('*** Lucía tiene un humor de perros, y aunque no es normal en ella, monta un pollo de cuidado. Tienes que estar un buen rato hablándole y explicándole para que se tranquilice y se preste a colaborar... Ese tiempo era necesario, pero ya no volverá.'), 
	penalizacion(Penalizacion),
	retract(penalizacion(Penalizacion)),
	NuevaPenalizacion is Penalizacion + 10,
	asserta(penalizacion(NuevaPenalizacion)).
	

% realiza un incremento estándar sobre un indicador (10)
incrementa_indicador(Indicador) :-
	retract(contador(Indicador, AntiguoValor)),
	NuevoValor is AntiguoValor + 10,
	asserta(contador(Indicador, NuevoValor)).

% realiza un decremento estándar sobre un indicador (-10)	
reduce_indicador(Indicador) :-
	retract(contador(Indicador, AntiguoValor)),
	NuevoValor is AntiguoValor - 10,
	asserta(contador(Indicador, NuevoValor)).
	
% realiza un decremento especificado sobre un indicador	
reduce_indicador(Indicador, Valor) :-
	retract(contador(Indicador, AntiguoValor)),
	NuevoValor is AntiguoValor - Valor,
	asserta(contador(Indicador, NuevoValor)).

% este predicado modela cómo ha dormido la niña... bien o mal; depende del día
cambia_sueño(R) :-
	R == 0,
	writeln('nena: Déjameeeeee'),
	incrementa_indicador(sueño).
cambia_sueño(R) :-
	R == 1,
	writeln('nena: Muy bien, papá!!').

% forma compacta para mostrar un par clave/valor
print_par(Clave, Valor) :-
	tab(2),
    write('- '), write(Clave), write(': '), write(Valor),
    nl.
    
% predicado que comprueba si es posible una transición dada entre estados
puedo_hacer(Estado):-
  actual(EstadoActual),
  transicion(_, _, EstadoActual, Estado).
puedo_hacer(_):-
  writeln('Ahora no toca hacer eso.'),
  fail.

% predicado que cambia el estado actual por otro  
cambiar(Estado) :-
  retract(actual(_)),
  asserta(actual(Estado)).
    
% predicado que modela una transición de un estado a otro, comprobando los indicadores vitales de la niña nada más realizar el cambio    
hacer(Accion):-
	transicion(Accion, _, _, Estado),
	puedo_hacer(Estado),
	cambiar(Estado),
	check_indicadores.
	

% indica en que estado se encuentra la ninya y que se puede hacer
que_hago(EstadoAnterior, Estado) :-
  write('Lucía está '), write(Estado), nl,
  sucesos(EstadoAnterior, Estado),
  % lista los indicadores que determinan cómo se encuentra la niña, junto con sus valores
  forall(contador(P,Q), print_par(P,Q)),
  writeln('¿Qué hacemos ahora? (introduzca un comando seguido de punto . )'),
  estados_matinales_visitados(Visitados),
  writeln(Visitados),
  % lista las transiciones disponibles desde ese estado, teniendo en cuenta los ya visitados en el caso de los matinales para reducir el árbol de estados
  forall((transicion(Accion, Descripcion, Estado, EstadoDestino), \+ member(EstadoDestino, Visitados)), print_par(Accion,Descripcion))
  .
