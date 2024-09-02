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
    
% **************
% ** PUNTO 03 **
% **************

quimica(campanita, Persona) :-
    cree(Persona, campanita),
    suenioFacil(Persona).

quimica(Personaje, Persona) :-
    cree(Persona, Personaje),
    Personaje \= campanita,
    not(ambicioso(Persona)),
    sueniosPuros(Persona).

suenioFacil(Persona) :-
    suenio(Persona, Suenio),
    dificultad(Suenio, Dificultad),
    Dificultad < 5.

sueniosPuros(Persona) :-
    forall(suenio(Persona, Suenio), suenioPuro(Suenio)).

suenioPuro(futbolista(_)).
suenioPuro(cantante(Discos)) :-
    Discos < 200000.

% **************
% ** PUNTO 04 **
% **************

amigo(campanita, reyesMagos).
amigo(campanita, conejoPascua).
amigo(conejoPascua, cavenaghi).

enfermo(campanita).
enfermo(reyesMagos).
enfermo(conejoPascua).

alegraPersona(Personaje, Persona) :-
    persona(Persona),
    personaje(Personaje),
    suenio(Persona, _),
    quimica(Personaje, Persona),
    sanidad(Personaje).
    
sanidad(Personaje) :-
    not(enfermo(Personaje)).
sanidad(Personaje) :-
    amigoIndirecto(Personaje, Amigo),
    not(enfermo(Amigo)).

amigoIndirecto(Personaje, Amigo) :-
    amigo(Personaje, Amigo).

amigoIndirecto(Personaje, Amigo) :-
    amigo(Personaje, OtroAmigo),
    amigoIndirecto(OtroAmigo, Amigo).








