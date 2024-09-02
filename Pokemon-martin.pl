% *********************
% ****** PARTE 1 ******
% *********************

% pokemon(Nombre, Tipo).
pokemon(pikachu, electrico).
pokemon(charizard, fuego).
pokemon(venusaur, planta).
pokemon(blastoise, agua).
pokemon(totodile, agua).
pokemon(snorlax, normal).
pokemon(rayquaza, dragon).
pokemon(rayquaza, volador).
% pokemon(arceus, tipo).

pokemon(Pokemon) :-
    pokemon(Pokemon, _).

entrenador(ash, pikachu).
entrenador(ash, charizard).
entrenador(brock, snorlax).
entrenador(misty, blastoise).
entrenador(misty, venusaur).
entrenador(misty, arceus).

entrenador(Entrenador) :-
    entrenador(Entrenador, _).

% **************
% ** Punto 01 **
% **************

tipoMultiple(Pokemon) :-
    pokemon(Pokemon, UnTipo),
    pokemon(Pokemon, OtroTipo),
    UnTipo \= OtroTipo.

% **************
% ** Punto 02 **
% **************

legendario(Pokemon) :-
    pokemon(Pokemon),
    tipoMultiple(Pokemon),
    nadieLoTiene(Pokemon).

nadieLoTiene(Pokemon) :-
    not(entrenador(_, Pokemon)).

% **************
% ** Punto 03 **
% **************

misterioso(Pokemon) :-
    pokemon(Pokemon),
    nadieLoTiene(Pokemon).

misterioso(Pokemon) :-
    pokemon(Pokemon),
    unicoEnSuTipo(Pokemon).

unicoEnSuTipo(Pokemon) :-
    pokemon(Pokemon, Tipo),
    findall(Tipo, pokemon(_, Tipo), Tipos),
    length(Tipos, Cantidad),
    Cantidad == 1.

% *********************
% ****** PARTE 2 ******
% *********************

movimiento(mordedura, fisico(95)).
movimiento(impactrueno, especial(40, electrico)).
movimiento(garraDeDragon, especial(100, dragon)).
movimiento(proteccion, defensivo(0.1)).
movimiento(placaje, fisico(50)).
movimiento(alivio, defensivo(1)).

movimientoPokemon(pikachu, mordedura).
movimientoPokemon(pikachu, impactrueno).

movimientoPokemon(charizard, garraDeDragon).
movimientoPokemon(charizard, mordedura).

movimientoPokemon(blastoise, proteccion).
movimientoPokemon(blastoise, placaje).

movimientoPokemon(arceus, impactrueno).
movimientoPokemon(arceus, garraDeDragon).
movimientoPokemon(arceus, proteccion).
movimientoPokemon(arceus, placaje).
movimientoPokemon(arceus, alivio).

% **************
% ** Punto 01 **
% **************

danioAtaque(Movimiento, Potencia) :-
    movimiento(Movimiento, fisico(Potencia)).

danioAtaque(Movimiento, 0) :-
    movimiento(Movimiento, defensivo(_)).

danioAtaque(Movimiento, Ataque) :-
    movimiento(Movimiento, especial(Potencia, Tipo)),
    multiplicarSegunTipo(Tipo, Potencia, Ataque).

multiplicarSegunTipo(Tipo, Potencia, Ataque) :-
    tipoBasico(Tipo),
    Ataque is Potencia * 1.5.

multiplicarSegunTipo(dragon, Potencia, Ataque) :-
    Ataque is Potencia * 3.

multiplicarSegunTipo(Tipo, Potencia, Potencia) :-
    not(tipoBasico(Tipo)),
    Tipo \= dragon.

tipoBasico(fuego).
tipoBasico(agua).
tipoBasico(planta).
tipoBasico(normal).

% **************
% ** Punto 02 **
% **************

capacidadOfensiva(Pokemon, CapacidadOfensiva) :-
    pokemon(Pokemon),
    findall(Ataque, encontrarAtaque(Pokemon, Ataque), Ataques),
    sum_list(Ataques, CapacidadOfensiva).
    
encontrarAtaque(Pokemon, Ataque) :-
    movimientoPokemon(Pokemon, Movimiento),
    danioAtaque(Movimiento, Ataque).

% **************
% ** Punto 03 **
% **************

% Si un entrenador es picante, lo cual ocurre si todos sus pokemons tienen una capacidad ofensiva total superior a 200 o son misteriosos.

picante(Entrenador) :-
    entrenador(Entrenador),
    granCapacidadOfensiva(Entrenador).

picante(Entrenador) :-
    entrenador(Entrenador),
    pokemonesMisteriosos(Entrenador).

granCapacidadOfensiva(Entrenador) :-
    findall(Ataque, (entrenador(Entrenador, Pokemon), encontrarAtaque(Pokemon, Ataque)), Ataques),
    sumlist(Ataques, Suma),
    Suma > 200.

pokemonesMisteriosos(Entrenador) :-
    forall(entrenador(Entrenador, Pokemon), misterioso(Pokemon)).
