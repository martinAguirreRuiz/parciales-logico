% ************** 
% ** PUNTO 01 **
% **************

% jockey(nombre, altura(cm), peso(kg)).
jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

jockey(Jockey) :-
    jockey(Jockey, _, _).

caballo(Caballo) :-
    preferencia(Caballo, _).

preferencia(botafogo, baratucci).
preferencia(botafogo, Jockey) :-
    jockey(Jockey, _, Peso),
    Peso < 52.

preferencia(oldMan, Jockey) :-
    jockey(Jockey, _, _),
    atom_length(Jockey, Length),
    Length > 7.

preferencia(energica, Jockey) :-
    not(preferencia(botafogo, Jockey)).

preferencia(matBoy, Jockey) :-
    jockey(Jockey, Altura, _),
    Altura > 170.

preferencia(yatasto, nadie).
    
caballeriza(Caballeriza) :-
    stud(Caballeriza, _).

stud(elTute, valdivieso).
stud(elTute, falero).
stud(lasHormigas, lezcano).
stud(elCharabon, baratucci).
stud(elCharabon, leguisamo).

gano(botafogo, granPremioNacional).
gano(botafogo, granPremioRepublica).
gano(oldMan, granPremioRepublica).
gano(oldMan, campeonatoPalermoOro).
gano(matBoy, granPremioCriadores).

% ************** 
% ** PUNTO 02 **
% **************

prefiereMasDeUnJockey(Caballo) :-
    caballo(Caballo),
    preferencia(Caballo, Jockey),
    preferencia(Caballo, OtroJockey),
    Jockey \= OtroJockey.

% ************** 
% ** PUNTO 03 **
% **************

aborrece(Caballo, Caballeriza) :-
    caballo(Caballo),
    caballeriza(Caballeriza),
    forall(stud(Caballeriza, Jockey), not(preferencia(Caballo, Jockey))).

% Es lo mismo que hacer el forall -> el forall busca todos los jockeys de un stud y ve que el caballo no los prefiera.
% Este busca encontrar uno solo que sí lo prefiera y lo niega, o sea busca que no haya ninguno que lo prefiera.
% not(preferencia(Caballo, Jockey), stud(Caballeria, Jockey)).

% ************** 
% ** PUNTO 04 **
% **************

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

piolin(Jockey) :-
    jockey(Jockey),
    forall(caballoConPremioImportante(Caballo), preferencia(Caballo, Jockey)).

caballoConPremioImportante(Caballo) :-
    caballo(Caballo),
    gano(Caballo, Premio),
    premioImportante(Premio).

% ************** 
% ** PUNTO 05 **
% **************

apuesta(aGanador, Caballo, Caballos) :-
    salePrimero(Caballo, Caballos).

apuesta(aSegundo, Caballo, Caballos) :-
    salePrimero(Caballo, Caballos).
apuesta(aSegundo, Caballo, Caballos) :-
    saleSegundo(Caballo, Caballos).

apuesta(exacta, CaballoUno, CaballoDos, Caballos) :-
    salenPrimeroYSegundo(CaballoUno, CaballoDos, Caballos).

apuesta(imperfecta, CaballoUno, CaballoDos, Caballos) :-
    salenPrimeroYSegundo(CaballoUno, CaballoDos, Caballos).
apuesta(imperfecta, CaballoUno, CaballoDos, Caballos) :-
    salenPrimeroYSegundo(CaballoDos, CaballoUno, Caballos).

salePrimero(Caballo, Caballos) :-
    nth1(1, Caballos, Caballo).

saleSegundo(Caballo, Caballos) :-
    nth1(2, Caballos, Caballo).
    
salenPrimeroYSegundo(CaballoUno, CaballoDos, Caballos) :-
    CaballoUno \= CaballoDos,
    salePrimero(CaballoUno, Caballos),
    saleSegundo(CaballoDos, Caballos).

% ************** 
% ** PUNTO 06 **
% **************

color(botafogo, negro).
color(oldMan, marron).
color(energica, gris).
% color(energica, negro).
color(matBoy, blanco).
% color(matBoy, marron).
% color(yatasto, blanco).
color(yatasto, marron).

color(Color) :-
    color(_, Color).

puedeComprar(Jockey, Caballo, Color) :-
    jockey(Jockey),
    caballo(Caballo),
    color(Color),
    color(Caballo, Color),
    preferenciaColor(Jockey, Color).

preferenciaColor(valdivieso, negro).
preferenciaColor(leguisamo, blanco).


