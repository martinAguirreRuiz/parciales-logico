% **************
% ** PUNTO 01 **
% **************

persona(Persona) :-
    cree(Persona, _).

personaje(Personaje) :-
    cree(_, Personaje).

cree(gabriel, campanita).
cree(gabriel, magoDeOz).
cree(gabriel, cavenaghi).

cree(juan, conejoPascua).

cree(macarena, reyesMagos).
cree(macarena, campanita).
cree(macarena, magoCapria).

% cree(diego, nadie).

suenio(gabriel, loteria([5,9])).
suenio(gabriel, futbolista(arsenal)).

suenio(juan, cantante(100000)).

suenio(macarena, cantante(10000)).

% **************
% ** PUNTO 02 **
% **************

equipoChico(arsenal).
equipoChico(aldosivi).

dificultad(cantante(Discos), 6) :-
    Discos > 500000.
dificultad(cantante(Discos), 4) :-
    Discos =< 500000.

dificultad(loteria(NumerosApostados), Dificultad) :-
    length(NumerosApostados, Cantidad),
    Dificultad is Cantidad * 10.

dificultad(futbolista(Equipo), 3) :-
    equipoChico(Equipo).
dificultad(futbolista(Equipo), 16) :-
    not(equipoChico(Equipo)).
    
ambicioso(Persona) :-
    persona(Persona),
    sueniosDificiles(Persona).
    
sueniosDificiles(Persona) :-
    findall(Dificultad, (suenio(Persona, Suenio), dificultad(Suenio, Dificultad)), Dificultades),
    sum_list(Dificultades, Suma),
    Suma > 20.