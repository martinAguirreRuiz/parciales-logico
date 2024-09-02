% *********************************************
% ****************** PARTE 1 ****************** 
% *********************************************

% mago(nombre, sangre, casaOdiada)
mago(harry, mestiza, slytherin).
mago(draco, pura, hufflepuff).
mago(hermione, impura, ninguna).

mago(Mago) :-
    mago(Mago, _, _).
mago(ron).
mago(luna).

caracter(harry, corajudo).
caracter(harry, amistoso).
caracter(harry, orgulloso).
caracter(harry, inteligente).

caracter(draco, inteligente).
caracter(draco, orgulloso).

caracter(hermione, inteligente).
caracter(hermione, orgulloso).
caracter(hermione, responsable).

gustaCaracteristica(gryffindor, corajudo).

gustaCaracteristica(slytherin, orgulloso).
gustaCaracteristica(slytherin, inteligente).

gustaCaracteristica(ravenclaw, inteligente).
gustaCaracteristica(ravenclaw, responsable).

gustaCaracteristica(hufflepuff, amistoso).

casa(Casa) :-
    gustaCaracteristica(Casa, _).

% **************
% ** Punto 01 ** 
% **************

permiteEntrar(slytherin, Mago) :-
    mago(Mago),
    mago(Mago, Sangre, _),
    Sangre \= impura.

permiteEntrar(Casa, Mago) :-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.

% **************
% ** Punto 02 ** 
% **************

caracterApropiado(Mago, Casa) :-
    casa(Casa),
    mago(Mago),
    forall(gustaCaracteristica(Casa, Caracteristica), caracter(Mago, Caracteristica)).

% **************
% ** Punto 03 ** 
% **************

puedeQuedar(hermione, gryffindor).

puedeQuedar(Mago, Casa) :-
    mago(Mago),
    casa(Casa),
    caracterApropiado(Mago, Casa),
    permiteEntrar(Casa, Mago),
    mago(Mago, _, CasaOdiada),
    Casa \= CasaOdiada.

% **************
% ** Punto 04 ** 
% **************

cadenaDeAmistades(Magos) :-
    todosLosMagosSonAmistosos(Magos),
    puedeEstarEnLaCasaDelSiguiente(Magos).

todosLosMagosSonAmistosos(Magos) :-
    forall(member(Mago, Magos), caracter(Mago, amistoso)).

puedeEstarEnLaCasaDelSiguiente([_]) :- true.

puedeEstarEnLaCasaDelSiguiente([Mago, Mago2 | Resto]) :-
    puedeQuedar(Mago, Casa),
    puedeQuedar(Mago2, Casa),
    puedeEstarEnLaCasaDelSiguiente([Mago2 | Resto]).

% *********************************************
% ****************** PARTE 2 ****************** 
% *********************************************

accion(andarDeNocheFueraDeCama, mala(50)).
accion(irASeccionRestringidaBiblioteca, mala(10)).
accion(irABosque, mala(50)).
accion(irATercerPiso, mala(75)).

accion(ganarAVoldemort, buena(60)).
accion(salvarAmigosDeMuerteHorrible, buena(50)).
accion(ganarPartidaAjedrez, buena(50)).

accionMago(harry, andarDeNocheFueraDeCama).
accionMago(harry, irABosque).
accionMago(harry, irATercerPiso).
accionMago(harry, ganarAVoldemort).

accionMago(hermione, irATercerPiso).
accionMago(hermione, irASeccionRestringidaBiblioteca).
accionMago(hermione, salvarAmigosDeMuerteHorrible).

accionMago(draco, irAMazmorras).

accionMago(ron, ganarPartidaAjedrez).

esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

% **************
% ** Punto 01 ** 
% **************

% a)

buenAlumno(Mago) :-
    mago(Mago),
    forall(accionMago(Mago, Accion), not(accion(Accion, mala(_)))).

% b)

accionRecurrente(Accion) :-
    accionMago(Mago1, Accion),
    accionMago(Mago2, Accion),
    Mago1 \= Mago2.

% **************
% ** Punto 02 ** 
% **************

puntajeTotalCasa(Casa, Puntaje) :-
    casa(Casa),
    findall(Puntos, encontrarPuntosMago(Casa, Puntos), ListaPuntos),
    sumlist(ListaPuntos, Puntaje).

encontrarPuntosMago(Casa, Puntos) :-
    esDe(Mago, Casa),
    accionMago(Mago, Accion),
    puntosDeAccion(Accion, Puntos).

puntosDeAccion(Accion, Puntos) :-
    accion(Accion, buena(Puntos)).

puntosDeAccion(Accion, Puntos) :-
    accion(Accion, mala(Punto)),
    Puntos is Punto * (-1).

puntosDeAccion(Pregunta, Puntos) :-
    respuesta(_, Pregunta, Puntos, Profesor),
    Profesor \= snape.

puntosDeAccion(Pregunta, Puntos) :-
    respuesta(_, Pregunta, Punto, snape),
    Puntos is div(Punto, 2).

% **************
% ** Punto 03 ** 
% **************

casaGanadora(Casa, PuntajeGanador) :-
    casa(Casa),
    puntajeTotalCasa(Casa, PuntajeGanador),
    forall(casa(OtraCasa), puntajeSuperior(OtraCasa, PuntajeGanador)).

puntajeSuperior(Casa, Puntaje) :-
    puntajeTotalCasa(Casa, OtroPuntaje), 
    Puntaje >= OtroPuntaje.

% **************
% ** Punto 04 ** 
% **************

% respuesta(Pregunta, Dificultad, Profesor).

respuesta(hermione, dondeBezoar, 20, snape).
respuesta(hermione, levitarPluma, 25, flitwick).

% Esto es gracias al polimorfismo mega abuso de una nashei
