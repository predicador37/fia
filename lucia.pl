:-dynamic actual/1, contador/2, penalizacion/1, estados_matutinos_visitados/1, estados_vespertinos_visitados/1, 
transicion/4.

% posibles transiciones entre estados

% Estados visitables desde dormida
transicion(despertar, 'despertarla', dormida, despierta).
transicion(dejar_mas, 'dejarla dormir un poco más', dormida, remoloneando).

% Estados visitables desde remoloneando
transicion(despertar, 'despertarla', remoloneando, despierta).

% Estados visitables desde despierta
transicion(bañar, 'bañarla', despierta, bañandose).
transicion(hacer_pis, 'llevarla a hacer pis', despierta, aliviandose).
transicion(desayunar, 'darle el desayuno', despierta, desayunando).
transicion(jugar_salon, 'dejarla jugar un rato en el salon', despierta, jugando).

% Estados visitables desde jugando
transicion(bañar, 'bañarla',jugando, bañandose).
transicion(hacer_pis, 'llevarla a hacer pis', jugando, aliviandose).
transicion(desayunar, 'darle el desayuno', jugando, desayunando).

% Estados visitables desde bañandose
transicion(hacer_pis, 'llevarla a hacer pis', bañandose, aliviandose).
transicion(desayunar, 'darle el desayuno', bañandose, desayunando).
transicion(jugar_salon, 'dejarla jugar un rato en el salon', bañandose, jugando).

% Estados visitables desde aliviandose
transicion(bañar, 'bañarla', aliviandose, bañandose).
transicion(desayunar, 'darle el desayuno', aliviandose, desayunando).
transicion(jugar_salon, 'dejarla jugar un rato en el salon', aliviandose, jugando).

% Estados visitables desde desayunando
transicion(hacer_pis, 'llevarla a hacer pis', desayunando, aliviandose).
transicion(bañar, 'bañarla', desayunando, bañandose).
transicion(jugar_salon, 'dejarla jugar un rato en el salon', desayunando, jugando).

% Estados visitables desde lista
transicion(con_muñeco, 'dejarla llevar un muñeco', lista, aprendiendo).
transicion(sin_muñeco, 'no dejarla llevar un muñeco', lista, aprendiendo).

% Estados visitables desde aprendiendo
transicion(al_parque, 'ir al parque a correr y a toboganear', aprendiendo, corriendo).
transicion(a_casa, 'ir a casa', aprendiendo, relajandose).

% Estados visitables desde corriendo
transicion(al_super, 'ir al supermercado a hacer la compra', corriendo, comprando).
transicion(a_casa, 'ir a casa', corriendo, relajandose).

% Estados visitables desde relajandose
transicion(al_super, 'ir al supermercado a hacer la compra', relajandose, comprando).
transicion(jugar_bloques, 'jugar con los bloques de plástico a hacer castillos', relajandose, construyendo).

% Estados visitables desde comprando
transicion(poner_pijama, 'volver a casa y poner el pijama directamente', comprando, empijamada).
transicion(jugar_cocinitas, 'volver a casa y jugar a las cocinitas', comprando, cocinando).

% Estados visitables desde construyendo
transicion(poner_pijama, 'poner el pijama', construyendo, empijamada).
transicion(jugar_cocinitas, 'jugar a las cocinitas', construyendo, cocinando).

% Estados visitables desde cocinando
transicion(poner_pijama, 'poner el pijama', cocinando, empijamada).

% Estados visitables desde empijamada
transicion(cenar, 'cenar', empijamada, cenando).
transicion(contar_cuento, 'contar un cuento antes de dormir', empijamada, imaginando).
transicion(hacer_pis, 'llevarla a hacer pis', empijamada, miccionando).

% Estados visitables desde cenando
transicion(contar_cuento, 'contar un cuento antes de dormir', cenando, imaginando).
transicion(hacer_pis, 'llevarla a hacer pis', cenando, miccionando).

% Estados visitables desde imaginando
transicion(hacer_pis, 'llevarla a hacer pis', imaginando, miccionando).
transicion(cenar, 'cenar', imaginando, cenando).

% Estados visitables desde miccionando
transicion(cenar, 'cenar', miccionando, cenando).
transicion(contar_cuento, 'contar un cuento antes de dormir', miccionando, imaginando).

% Este estado debe poder alcanzarse desde cualquier otro
transicion(salir, 'salir', _, 'triste porque te vas').

% estado inicial y listas de estados visitados
actual(dormida).
estados_matutinos_visitados([]).
estados_vespertinos_visitados([]).

% bloque de inicialización de hechos necesarios y utilizados a modo de variable.
inicio :-
  retractall(contador(_, _)),
  retractall(estados_matutinos_visitados([])),
  asserta(estados_matutinos_visitados([])),
  retractall(estados_vespertinos_visitados([])),
  asserta(estados_vespertinos_visitados([])),
  retractall(transicion(ir_cole, _, _, _)),
  retractall(transicion(a_dormir, _, _, _)),
  Humor is random(100),
  Hambre is random(100),
  random(50, 70, Piscaca),
  asserta(contador(humor, Humor)),
  asserta(contador(hambre, Hambre)),
  asserta(contador(piscaca, Piscaca)),
  asserta(contador(sueño, 0)),
  asserta(contador(penalizacion,0)),
  lucia.

lucia :-
  cambiar(dormida),
  writeln('*** Bienvenido a L.U.C.I.A. , acrónimo recursivo de (Lucía, Única Candidata para Inteligencia Artificial'),
  writeln('*** En el siguiente simulador, tomarás el rol de papá de una niña maravillosa llamada Lucía. ¿Y por qué no su mamá? Pues por nada en especial; porque este programa está pensado por un papá y ha decidido compartir su experiencia muy personal. No obstante, seas hombre, mujer, papá o mamá, estás invitado a probar este programa y comprobar si te recuerda a algo...),
  writeln('*** La simulación puede tomarse como un juego; el objetivo final es que, al acabar el día, el papá disponga del mayor tiempo posible para estudiar sus asignaturas de la UNED de este cuatrimestre.'),
  writeln('*** Ello es función, en parte, de una componente aleatoria que depende del día; y en otra parte, de las acciones y decisiones que el papá vaya tomando a lo largo del día. Estas decisiones afectarán a los distintos indicadores que modeln el estado de la niña (sueño, hambre, etc.). Si los indicadores superan unos umbrales máximos, ten por seguro que perderás mucho tiempo. Pueden ocurrir sucesos curiosos, como que la niña se pase de vueltas y por eso tarde más en dormirse...'),
  writeln('*** Se ha pretendido que la simulación sea lo más real posible dentro de lo razonable. ¡Prueba suerte y disfruta!'),
  actual(Estado),
  que_hago(Accion, Estado, Estado),
  control_principal(Estado).

% predicado con llamada recursiva para implementar el menú y control principal del programa
control_principal(EstadoAnterior) :-
  condicion_fin(EstadoAnterior).
control_principal(EstadoAnterior) :-
  repeat,
  write('> '),
  read(Accion),
  hacer(Accion),
  actual(NuevoEstado),
  check_indicadores,
  que_hago(Accion, EstadoAnterior, NuevoEstado),
  control_principal(NuevoEstado).

% condición de fin para el control principal
condicion_fin(Estado) :-
  actual(Estado) = actual(soñando),
  check_pasada_de_vueltas,
  writeln('papá: - ¿No se te olvida algo?'),
  writeln('nena: - Un besito a papá. ¡MUÁ!'),
  writeln('*** Finalmente Lucía se duerme como un angelito y ya puedes ponerte a estudiar.'),
  writeln('*** Teniendo en cuenta que mañana te levantas a las 6,30, lo ideal sería que durmieras qué menos que 6 horitas... O sea, que tendrías que acostarte a las 00,30.'),
  writeln('*** El cálculo de las horas disponibles se realizará de manera aproximada, restándole a 180 la penalización penalización en minutos acumulada a lo largo del día.'),
  contador(penalizacion, P),
  Estudio is 180 - P,
  write('*** Vas a poder estudiar '), write(Estudio), write(' minutos. ¿No es suficiente? Pues mañana te dormirás en el curro...'), nl,
  writeln('*** GRACIAS POR PARTICIPAR EN LA SIMULACIÓN'),
  writeln('El juego ha terminado').
condicion_fin(Estado) :-
  actual(Estado) = actual('triste porque te vas'),
  retractall(contador(_, _)),
  retract(actual(Estado)),
  asserta(actual(dormida)),
  write('Has abandonado el juego.').

% el siguiente predicado en todas sus variantes modela los distintos sucesos que acontecen según el estado en el que se encuentra el programa

% SUCESOS REMOLONEANDO
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(remoloneando),
	EstadoAnterior = dormida,
	writeln('*** Pobre niña, está entera esnucada y es tan mona de dormida... que te da pena y decides dejarla un poquito más. Eres blando... y ella tan tierna...'). 

% SUCESOS DESPIERTA SIN REMOLONEAR
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(despierta),
	EstadoAnterior = dormida,
	writeln('papá: - Que tal ha dormido mi niña?'),
	% bien o mal, es una cuestión aleatoria
	random_between(0, 1, R),
	cambia_sueño(R).

% SUCESOS DESPIERTA REMOLONEANDO
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(despierta),
	EstadoAnterior = remoloneando,
	writeln('papá: - Que tal ha dormido mi niña?'),
	writeln('nena: - Muy bien, papá!!'),
	writeln('papá: - Corre, que vamos tarde...'),
	writeln('*** El humor de la niña mejora ligeramente por dejarla remolonear, pero ahora tienes menos tiempo para prepararla...'),
	incrementa_indicador(humor),
	penaliza(5).

% SUCESOS JUGANDO EN SALON
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(jugando),
	writeln('nena: - ¡Vamos a jugar al salón!'),
	writeln('papá: - ¡¡Pero que tenemos que ir al cole!!'),
	writeln('nena: - Cinco minutos, papá.'),
	writeln('papá: - Pero nada más, que vamos tarde...'),
	writeln('*** El humor de la niña mejora, pero sube todo lo demás... ahora tiene más hambre y ganas de hacer pis. ¡¡Cuidado!!'),
	actualiza_estados_matutinos(Estado),
	penaliza(5),
	% El siguiente snippet incrementa en 10 todos los indicadores
	findall(Indicador, (contador(Indicador, _),Indicador \= sueño), Suben),
	maplist(incrementa_indicador,Suben).

% SUCESOS DESAYUNANDO
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(desayunando),
	writeln('papá: - ¡A desayunar!'),
	writeln('nena: - Quiero bolitas de chocolate.'),
	writeln('papá: - Vale; pero te tomas toda la leche, ¿eh?'),
	writeln('nena: - Vale, papá.'),
	writeln('*** A la niña se le quita el hambre, pero tarda mucho en desayunar...'),
	actualiza_estados_matutinos(Estado),
	reduce_indicador(hambre),
	incrementa_indicador(piscaca),
	penaliza(10).

% SUCESOS HACIENDO PIS
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(aliviandose),
	writeln('papá: - Vamos a hacer pis.'),
	writeln('nena: - ¡Vale, papá!'),
	writeln('*** Pones a Lucía en el reductor para el W.C. con motivos decorativos de Peppa Pig, y allí hace pis muy feliz. Le gusta mucho Peppa Pig; no en vano, el reductor ha costado 15€ frente a los 5 que cuesta uno, no sé, simplemente, azul.'),
	writeln('papá: - Muy bien, mi niña. ¡A limpiar!'),
	writeln('*** Limpias bien a la niña y le ayudas a bajarse del sanitario (o como se conoce en Cantabria, la baza)'),
	actualiza_estados_matutinos(Estado),
	reemplaza_indicador(piscaca,5),
	incrementa_indicador(humor),
	incrementa_indicador(hambre).
	
% SUCESOS BAÑANDOSE
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(bañandose),
	writeln('papá: - Venga, a bañar.'),
	writeln('nena: - Nooo, no quiero, quiero que me bañe mamá.'),
	writeln('papá: - Venga, hoy papá y otro día mamá.'),
	writeln('nena: - ¡¡No, no, no!! ¡¡Quiero mamá!!'),
	writeln('*** No te queda más remedio que acorralar a Lucía y darle un muñeco mientras le quitas el pijama y llenas la bañera. Una vez dentro, a Lucía le encanta el baño. Tanto que no quiere salir... es inevitable, llegaremos tarde.'),
	writeln('*** Después de bañarla, la vistes rápidamente con ropa que le gusta y le secas el pelo.'),
	writeln('nena: - ¡E muy bonita la camiseta de la biciceta, papá!'),
	writeln('papá: - Claro que sí. Venga, te peino y verás qué guapa.'),
	actualiza_estados_matutinos(Estado),
	penaliza(15),
	incrementa_indicador(piscaca),
	incrementa_indicador(humor),
	incrementa_indicador(hambre).
	
% SUCESOS LISTA PARA IR AL COLE
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(lista),
	writeln('nena: - Papaaaa.'),
	writeln('papá: - Dime, hija.'),
	writeln('nena: - ¿Puedo llevar un muñeco al cole?'),
	actualiza_estados_matutinos(Estado).
	
% SUCESOS YENDO AL COLE CON MUÑECO Y SALIENDO DEL COLE
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(aprendiendo),
	Accion = con_muñeco,
	writeln('papá: - Vale, ¿qué muñeco quieres?'),
	writeln('nena: - Mmmmm quiero a Sky... no, quierooo... ¡quiero al payaso!'),
	writeln('papá: - Vamos a buscarle al cajón. Pero se queda en el coche, ¿eh? Que Paula no nos deja llevar juguetes.'),
	writeln('nena: - ¡Vale, papá!'),
	writeln('*** Lucía se queda muy contenta llevando el muñeco, aunque lo tenga que dejar en el coche.'),  
	writeln('*** Pasa una ardua mañana de trabajo y de cole y vuelves a buscar a la niña.'),
	writeln('*** En el cole le dan de comer, hace pis y duerme un poco de siesta; normalmente, estos indicadores están en valores inferiores a la mitad.'),
	writeln('*** Hay un pequeño rato de conversación en el coche hasta llegar a casa, donde la pones dibujos antes de irte a comer.'),
	writeln('*** No, poner dibujos NO ES OPCIONAL.'),
	writeln('papá: - ¡¡¿¿Qué tal, mi niña??!!'),
	incrementa_indicador(humor),
	random(30, 50, Hambre),
	random(30, 50, Sueño),
	random(30, 50, Piscaca),
	reemplaza_indicador(hambre, Hambre),
	reemplaza_indicador(sueño, Sueño),
	reemplaza_indicador(piscaca,Piscaca),
	check_humor.

% SUCESOS YENDO AL COLE SIN MUÑECO Y SALIENDO DEL COLE
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(aprendiendo),
	Accion = sin_muñeco,
	writeln('papá: - No, Lucía, acuérdate que no se pueden llevar muñecos al cole. ¡Que luego nos riñen!'),
	writeln('nena: - Si... pero yo quiero llevar un muñeco...'),
	writeln('papá: - Pero al cole no se puede, ¿vale? Esta tarde lo sacamos de paseo.'),
	writeln('nena: - Vale...'),
	writeln('*** Lucía se queda un poco chafada por no poder llevar el muñeco.'), 
	writeln('*** Pasa una ardua mañana de trabajo y de cole y vuelves a buscar a la niña.'),
	writeln('*** En el cole le dan de comer, hace pis y duerme un poco de siesta; normalmente, estos indicadores están en valores inferiores a la mitad.'), 
	writeln('*** Hay un pequeño rato de conversación en el coche hasta llegar a casa, donde la pones dibujos antes de irte a comer.'),
	writeln('*** No, poner dibujos NO ES OPCIONAL.'),
	writeln('papá: - ¡¡¿¿Qué tal, mi niña??!!'),
	reduce_indicador(humor),
	random(30, 50, Hambre),
	random(30, 50, Sueño),
	random(30, 50, Piscaca),
	reemplaza_indicador(hambre, Hambre),
	reemplaza_indicador(sueño, Sueño),
	reemplaza_indicador(piscaca,Piscaca),
	check_humor.

% SUCESOS EN EL PARQUE
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(corriendo),
	writeln('papá: - Venga, vamos a un parque. ¿A cuál quieres ir?'),
	writeln('nena: - ¡¡Al de los caballitos!!'),
	writeln('papá: - Vale, venga, y te montas un viaje.'),
	writeln('nena: - ¡Bieeeeen! Yo quiero el caballito rosa...'),
	writeln('*** Lucía corretea, baja por el tobogán, se lo pasa bomba...'), 
	incrementa_indicador(humor,20),
	incrementa_indicador(sueño,15),
	incrementa_indicador(hambre).
	
% SUCESOS EN CASA
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(relajandose),
	writeln('papá: - Venga, hoy nos quedamos en casa. ¿Jugamos a los bloques?'),
	writeln('nena: - Vale, papá.'),
	writeln('*** Lucía corretea por el parque, baja por el tobogán, juega con otros niños, se monta en los caballitos....¡se lo pasa bomba!'), 
	incrementa_indicador(humor),
	incrementa_indicador(sueño,5),
	incrementa_indicador(hambre).

% SUCESOS EN EL SUPERMERCADO
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(comprando),
	writeln('papá: - Vamos a hacer compra.'),
	writeln('nena: - ¿Al Mercadona?'),
	writeln('papá: - Sí, que hay que comprar zumo verde.'),
	writeln('nena: - ¿Y zumo de naranja?'),
	writeln('papá: - También.'),
	writeln('nena: - ¡Bieeeen! Lo hago yo, papá.'),
	writeln('papá: - Vale.'),
	writeln('*** Hacéis la compra y mientras tanto, Lucía te pide un poco de pan. Dar vueltas por el súper no deja de pioneser cansado... '),
	incrementa_indicador(humor),
	reduce_indicador(hambre, 5),
	incrementa_indicador(sueño),
	penaliza(15).
	
% SUCESOS JUGANDO A LOS BLOQUES
sucesos(Accion, EstadoAnterior, Estado) :-
    actual(Estado) = actual(construyendo),
    writeln('papá: -¿Jugamos a los bloques?'),
    writeln('nena: - Vale, vamos a hacer un castillo muuuuuy aaaalto.'),
    writeln('*** A Lucía le gusta jugar a los bloques con su papá. No es una actividad que consuma mucha energía...'),
    incrementa_indicador(humor),
    incrementa_indicador(sueño,5).
    
% SUCESOS JUGANDO A LAS COCINITAS
sucesos(Accion, EstadoAnterior, Estado) :-
    actual(Estado) = actual(cocinando),
    writeln('nena: - Papá, me voy a jugar al salón. ¿Qué quieres?'),
    writeln('papá: - Mmmmmm... ¡unas lentejas!'),
    writeln('nena: - ¿Y qué más?'),
    writeln('papá: - Tortilla de patata.'),
    writeln('nena: - Vale.'),
    writeln('*** Lucía usa su cocinita para prepara concienzudamente la comanda. Después, se entretiene ella solita un rato... rato que pierde de otras cosas.'),
    incrementa_indicador(humor,5),
    incrementa_indicador(sueño,5),
    penaliza(10).
    
% SUCESOS PONIENDO EL PIJAMA
sucesos(Accion, EstadoAnterior, Estado) :-
    actual(Estado) = actual(empijamada),
    writeln('papá: - Venga, Lucía, a poner el pijama.'),
    writeln('nena: - Mira qué bonito, ¡es de Minnie!'),
    writeln('papá: - Sí, es de Minnie y es muy suave.'),
    writeln('*** Poner el pijama no lleva mucho tiempo... salvo que Lucía no esté de muy buen humor, que cuesta más'),
    check_humor_pijama.

% SUCESOS LEYENDO UN CUENTO
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(imaginando),
	writeln('nena: - Papá, ¿me lees un cuento?'),
	writeln('papá: - Claro, ¿cuál quieres?'),
	writeln('nena: - ¡El de los tres cerditos!'),
	writeln('papá: - Érase una vez una mamá cerda que vivía con sus tres cerditos. Entonces, un día...'),
	writeln('*** A Lucía le encantan los cuentos. Le gustan más que a Bella, la de la Bella y la Bestia (lo sabes porque has tenido que leérselo varias veces). Ya te sabes unos cuántos de memoria, el saber ocupa lugar... A la niña esto le encanta y le ayuda a relajarse antes de dormir.'),
	actualiza_estados_vespertinos(Estado),
	incrementa_indicador(humor,5),
	incrementa_indicador(sueño,5),
	penaliza(10).

% SUCESOS HACIENDO PIS POR LA NOCHE
sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(miccionando),
	writeln('papá: - Venga, a hacer pis antes de dormir.'),
	writeln('nena: - ¡Vale, papá!'),
	writeln('*** ¡Sorpresa!'),
	writeln('nena: - ¡He hecho caca!'),
	writeln('papá: - ¡Qué bien!'),
	writeln('*** Cielos... ¡qué pestazo! Tu tono de vez diciendo "qué bien" lo dice todo.'),
	writeln('*** LImpias bien a la niña, le subes el pijama y le ayudas a tirar de la cadena. Dejas el extractor puesto... tan pequeña y tan matona.'),
	actualiza_estados_vespertinos(Estado),
	reemplaza_indicador(piscaca,5),
	penaliza(5).

sucesos(Accion, EstadoAnterior, Estado) :-
	actual(Estado) = actual(cenando),
	writeln('papá: - Hoy para cenar hay brócoli y salmón. ¿Te apetece?'),
	writeln('nena: - Siiiiiiiiiiiii... ¡qué bien, brócoli y salmón!'),
	writeln('*** La típica cena que les encanta a los niños... pues a Lucía le chifla. Ya tendrá tiempo de echarse a perder en el Mcdonalds...'),
	writeln('nena: ¡Mira, papá! Me lo he comido todo, todo, todo.'),
	writeln('papá: Pero qué contento se pone papá. Eres una campeona... ¡choca!'),
	writeln('*** Lucía se lo come todo, pero ha tardado un ratito...'),
	actualiza_estados_vespertinos(Estado),
    reemplaza_indicador(hambre,10),
    incrementa_indicador(sueño),
    penaliza(10).

	
sucesos(_, _, _) :-
	true.
	
% comprueba el estado de los indicadores y penaliza el tiempo en consecuencia	
check_indicadores :-
	actual(EstadoIndicadores),
	\+ (EstadoIndicadores = dormida),
	\+ (EstadoIndicadores = remoloneando),
	contador(piscaca,Piscaca),
	contador(humor,Humor),
	contador(hambre,Hambre),
	(Piscaca >= 80 -> penaliza_pis; Hambre >= 80 -> penaliza_hambre; Humor =< 30 -> penaliza_humor ).
check_indicadores :-
	true.
	
check_humor :-
	contador(humor, Humor),
	( Humor =< 50 -> writeln('nena: - Mal...'),
					 writeln('papá: - Vaya, pero ¿por qué?'), 
					 writeln('nena: - No sé...'), 
					 writeln('*** Parece que no estamos teniendo buen día...'); 
	Humor >= 50 -> writeln('nena: - ¡Bien, papá!'),
				   writeln('papá: - ¿Qué habéis hecho hoy?'), 
				   writeln('*** Lucía empieza a contar historias sobre sus amiguitos, sus dibujos, sus juguetes...')).

check_humor_pijama :-
	contador(humor, Humor),
	( Humor =< 30 -> penaliza(10)).

check_pasada_de_vueltas :-
    contador(sueño, Sueño),
    ( Sueño >= 85 -> writeln('Lucía tiene tanto sueño que se ha pasado de vueltas... vas a tardar un rato en dormirla.'), penaliza(15);true).
	
actualiza_estados_matutinos(Estado) :-
    estados_matutinos_visitados(X),
	append(X, [Estado],Y),
	retract(estados_matutinos_visitados(X)),
	asserta(estados_matutinos_visitados(Y)).
		
actualiza_estados_vespertinos(Estado) :-
    estados_vespertinos_visitados(X),
	append(X, [Estado],Y),
	retract(estados_vespertinos_visitados(X)),
	asserta(estados_vespertinos_visitados(Y)).
	

% calcula la penalización en tiempo cuando la niña se hace pis	
penaliza_pis :-
	writeln('*** Lucía no se ha podido aguantar más y se ha hecho pis. Como es muy sensible, se ve visiblemente afectada y su humor baja. Naturalmente, hay que lavarla y cambiarla, lo que va a llevar un ratito...'),
	reduce_indicador(humor,20),
	retract(contador(piscaca, _)),
	asserta(contador(piscaca, 10)),
	penaliza(25).

% calcula la penalización en tiempo cuando la niña tiene mucho hambre	
penaliza_hambre :-
	writeln('*** Lucía tiene mucho hambre, lo que hace que se eche a llorar de repente. No te queda más remedio que darle rápidamente algo de comer de lo que tienes por la cocina. Naturalmente, el tiempo pasa...'), 
	reduce_indicador(humor,20),
	retract(contador(hambre, _)),
	asserta(contador(hambre, 10)),
	penaliza(15).

% calcula la penalización en tiempo cuando la niña está de muy mal humor	
penaliza_humor :-
	writeln('*** Lucía tiene un humor de perros, y aunque no es normal en ella, monta un pollo de cuidado. Tienes que estar un buen rato hablándole y explicándole para que se tranquilice y se preste a colaborar... Ese tiempo era necesario, pero ya no volverá.'), 
	retract(contador(humor, _)),
	asserta(contador(humor, 25)),
	penaliza(10).

penaliza(Valor) :-
	contador(penalizacion,Penalizacion),
	retract(contador(penalizacion, Penalizacion)),
	NuevaPenalizacion is Penalizacion + Valor,
	asserta(contador(penalizacion, NuevaPenalizacion)).
	

% realiza un incremento estándar sobre un indicador (10)
incrementa_indicador(Indicador) :-
	retract(contador(Indicador, AntiguoValor)),
	NuevoValor is AntiguoValor + 10,
	asserta(contador(Indicador, NuevoValor)).
	
incrementa_indicador(Indicador, Valor) :-
	retract(contador(Indicador, AntiguoValor)),
	NuevoValor is AntiguoValor + Valor,
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
	
reemplaza_indicador(Indicador,Valor) :-
	retract(contador(Indicador, _)),
	asserta(contador(Indicador, Valor)).
	

% este predicado modela cómo ha dormido la niña... bien o mal; depende del día
cambia_sueño(R) :-
	R == 0,
	writeln('nena: - Déjameeeeee'),
	incrementa_indicador(sueño).
cambia_sueño(R) :-
	R == 1,
	writeln('nena: - Muy bien, papá!!').

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
	cambiar(Estado).
	
lista_transiciones(Estado, VisitadosMatutinos, VisitadosVespertinos) :-
	writeln('---------------------------------------------------------------------------------------------------------------------------'),
	forall((transicion(Accion, Descripcion, Estado, EstadoDestino), \+ member(EstadoDestino, VisitadosMatutinos), \+ member(EstadoDestino, VisitadosVespertinos)), print_par(Accion,Descripcion)),
	writeln('---------------------------------------------------------------------------------------------------------------------------').

lista_indicadores :-
	writeln('==========================================================================================================================='),
	forall(contador(P,Q), print_par(P,Q)),
	writeln('===========================================================================================================================').
	

% indica en que estado se encuentra la ninya y que se puede hacer
que_hago(Accion, EstadoAnterior, Estado) :-
  writeln('.................................'),	
  write('Lucía está '), write(Estado), nl,
  writeln('.................................'),
  sucesos(Accion, EstadoAnterior, Estado),
  % lista los indicadores que determinan cómo se encuentra la niña, junto con sus valores
  lista_indicadores,
  estados_matutinos_visitados(VisitadosMatutinos),
  ( length(VisitadosMatutinos,4) -> asserta(transicion('ir_cole', 'vamos al cole ya', Estado, lista));true),
  estados_vespertinos_visitados(VisitadosVespertinos),
  ( length(VisitadosVespertinos,3) -> asserta(transicion('a_dormir', 'vamos a dormir', Estado, soñando));true),
  writeln('¿Qué hacemos ahora? (introduzca un comando seguido de punto . )'),
  % lista las transiciones disponibles desde ese estado, teniendo en cuenta los ya visitados en el caso de los matutinos para reducir el árbol de estados
  lista_transiciones(Estado, VisitadosMatutinos, VisitadosVespertinos).
