% escribio(?Autor, ?Escrito) tiene exito si Autor escribio ́Escrito
escribio(gottlob, begriffsschrift).% C1
escribio(bertrand, principia).% C2
escribio(alfred, principia).% C3
escribio(terry, shrdlu).% C4
escribio(bill, lunar).% C5
escribio(bill, solar).% C7
escribio(roger, sam).% C6

% libro(?Libro) tiene  ́exito si Libro es un libro
libro(begriffsschrift).% C7
libro(principia).% C8

% programa(?Prog) tiene exito si Prog es un programa
programa(lunar).% C9
programa(solar).
programa(sam).% C10
programa(shrdlu).% C11

% autor(?Persona) tiene  ́exito si Persona ha escrito un libro
autor(Persona) :-% C12
libro(Libro),
escribio(Persona, Libro).

% autor_de(?Persona, ?Libro) tiene  ́exito si Persona ha escrito Libro
autor_de(Persona, Libro) :- % C13
libro(Libro),
escribio(Persona, Libro).

% autor_de(?Persona, ?Programa) tiene  ́exito si Persona ha escrito Programa
autor_de(Persona, Programa) :- % C13
programa(Programa),
escribio(Persona, Programa).

