
% **************************
% ******** PUNTO 01 ********
% **************************

% comida(Tipo,  Precio).
comida(hamburguesa, 2000).
comida(panchitoConPapas, 1500).
comida(lomito, 2500).
comida(caramelos, 0).

% atraccion(Nombre, tranquila(ParaQuienEs)).
atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(casaEmbrujada, tranquila(chicosYAdultos)).
atraccion(laberinto, tranquila(chicosYAdultos)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

% atraccion(Nombre, intensa(CoeficienteDeLanzamiento)).
atraccion(barcoPirata, intensa(14)).
atraccion(tasasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

% atraccion(Nombre, montaniaRusa(GirosInvertidos, Duracion)).
atraccion(abismoMortalRecargada, montaniaRusa(3, 314)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

% atraccion(Nombre, acuatica).
atraccion(torpedoSalpicon, acuatica).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica).

% visitante(Nombre, Edad, Dinero).
visitante(eusebio, 80, 3000).
visitante(carmela, 80, 0).
visitante(martin, 21, 65).
visitante(martina, 10, 0).

% sentimientos(Nombre, Hambre, Aburrimiento).
sentimientos(eusebio, 50, 0).
sentimientos(carmela, 0, 25).
sentimientos(martin, 99, 50).
sentimientos(martina, 25, 0).

% grupoFamiliar(Nombre, Grupo)
grupoFamiliar(eusebio, viejitos).
grupoFamiliar(carmela, viejitos).
grupoFamiliar(martina, viejitos).

% mes(Mes).
mes(enero).
mes(febrero).
mes(marzo).
mes(abril).
mes(mayo).
mes(junio).
mes(julio).
mes(agosto).
mes(septiembre).
mes(octubre).
mes(noviembre).
mes(diciembre).

% **************************
% ******** PUNTO 02 ********
% **************************

% Hago el generador para poder ligar al visitante siempre:
visitante(Visitante) :-
    visitante(Visitante, _, _).

sumaHambreYAburrimiento(Visitante, Suma) :-
    visitante(Visitante),
    sentimientos(Visitante, Hambre, Aburrimiento),
    Suma is Hambre + Aburrimiento.

vieneSolo(Visitante) :-
    not(grupoFamiliar(Visitante, _)).

estadoDeBienestar(Visitante, felicidadPlena) :-
    sumaHambreYAburrimiento(Visitante, Suma),
    Suma == 0,
    not(vieneSolo(Visitante)).

estadoDeBienestar(Visitante, podriaEstarMejor) :-
    sumaHambreYAburrimiento(Visitante, Suma),
    between(1, 50, Suma).

estadoDeBienestar(Visitante, podriaEstarMejor) :-
    sumaHambreYAburrimiento(Visitante, Suma),
    Suma == 0,
    vieneSolo(Visitante).

estadoDeBienestar(Visitante, necesitaEntretenerse) :-
    sumaHambreYAburrimiento(Visitante, Suma),
    between(51, 99, Suma).

estadoDeBienestar(Visitante, seQuiereIrACasa) :-
    sumaHambreYAburrimiento(Visitante, Suma),
    Suma >= 100.

% **************************
% ******** PUNTO 03 ********
% **************************

% generador
grupoFamiliar(GrupoFamiliar) :-
    grupoFamiliar(_, GrupoFamiliar).

grupoSeLlenaConComida(GrupoFamiliar, Comida) :-
    grupoFamiliar(GrupoFamiliar),
    comida(Comida, Precio),
    todosPuedenComprar(GrupoFamiliar, Precio),
    comidaLlenaATodos(GrupoFamiliar, Comida).

todosPuedenComprar(GrupoFamiliar, Precio) :-
    forall(member(Integrante, GrupoFamiliar), puedeComprar(Integrante, Precio)).

puedeComprar(Visitante, Precio) :-
    visitante(Visitante, _, Dinero),
    Dinero >= Precio.

hambreMenorA(Visitante, Hambre) :-
    sentimientos(Visitante, HambreVisitante, _),
    HambreVisitante =< Hambre.

esChico(Visitante) :-
    visitante(Visitante, Edad, _),
    Edad < 13.

noPuedePagarOtrasComidas(Visitante) :-
    forall(comida(Comida, Precio), (not(puedeComprar(Visitante, Precio)), Comida \= caramelos)).

comidaLlenaATodos(_, lomito).

comidaLlenaATodos(GrupoFamiliar, hamburguesa) :-
    forall(member(Integrante, GrupoFamiliar), hambreMenorA(Integrante, 50)).

comidaLlenaATodos(GrupoFamiliar, panchitoConPapas) :-
    member(Integrante, GrupoFamiliar),
    not(esChico(Integrante)).

comidaLlenaATodos(GrupoFamiliar, caramelos) :-
    forall(member(Integrante, GrupoFamiliar), noPuedePagarOtrasComidas(Integrante)).

% **************************
% ******** PUNTO 04 ********
% **************************

lluviaDeHamburguesas(Visitante, Atraccion) :-
    comida(hamburguesa, Precio),
    puedeComprar(Visitante, Precio),
    atraccion(Atraccion, intensa(CoeficienteDeLanzamiento)),
    CoeficienteDeLanzamiento > 10.

lluviaDeHamburguesas(Visitante, Atraccion) :-
    comida(hamburguesa, Precio),
    puedeComprar(Visitante, Precio),
    atraccion(Atraccion, montaniaRusa(GirosInvertidos, Duracion)),
    montaniaRusaPeligrosa(Visitante, GirosInvertidos, Duracion).

lluviaDeHamburguesas(Visitante, tobogan) :-
    visitante(Visitante).

montaniaRusaPeligrosa(Visitante, GirosInvertidos, _) :-
    not(esChico(Visitante)),
    not(estadoDeBienestar(Visitante, necesitaEntretenerse)),
    mayorCantidadDeGirosDelParque(GirosMax),
    GirosInvertidos == GirosMax.

montaniaRusaPeligrosa(Visitante, _, Duracion) :-
    esChico(Visitante),
    Duracion > 60.

mayorCantidadDeGirosDelParque(GirosMax) :-
    atraccion(_, montaniaRusa(GirosInvertidos, _)),
    GirosInvertidos == GirosMax.

% **************************
% ******** PUNTO 05 ********
% **************************

% TODOS LOS PUESTOS DE COMIDA
opcionDeEntretenimiento(Mes, Visitante, Comida) :-
    mes(Mes),
    comida(Comida, Precio), 
    puedeComprar(Visitante, Precio).

% TODAS LAS ATRACCIONES TRANQUILAS A LAS QUE PUEDE ACCEDER
opcionDeEntretenimiento(Mes, Visitante, Atraccion) :-
    mes(Mes),
    visitante(Visitante),
    atraccion(Atraccion, tranquila(chicosYAdultos)).

opcionDeEntretenimiento(Mes, Visitante, Atraccion) :-
    mes(Mes),
    atraccion(Atraccion, tranquila(chicos)),
    esChico(Visitante).

% TODAS LAS ATRACCIONES INTENSAS
opcionDeEntretenimiento(Mes, Visitante, Atraccion) :-
    mes(Mes),
    visitante(Visitante),
    atraccion(Atraccion, intensa(_)).

% TODAS LAS MONTAÑAS RUSAS QUE NO SEAN PELIGROSAS
opcionDeEntretenimiento(Mes, Visitante, Atraccion) :-
    mes(Mes),
    visitante(Visitante),
    atraccion(Atraccion, montaniaRusa(GirosInvertidos, Duracion)),
    not(montaniaRusaPeligrosa(Visitante, GirosInvertidos, Duracion)).

% TODAS LAS ATRACCIONES ACUATICAS (SI EL MES [SEPTIEMBRE - MARZO])
opcionDeEntretenimiento(Mes, Visitante, Atraccion) :-
    mes(Mes),
    member(Mes, [septiembre, octubre, noviembre, diciembre, enero, febrero, marzo]),
    visitante(Visitante),
    atraccion(Atraccion, acuatica).
    
% ATRACCION TRANQUILA SOLO PARA CHICOS SI HAY UN CHICO EN EL GRUPO DEL ADULTO
opcionDeEntretenimiento(Mes, Visitante, Atraccion) :-
    visitante(Visitante),
    mes(Mes),
    not(esChico(Visitante)),
    grupoFamiliar(Visitante, GrupoFamiliar),
    grupoFamiliar(Integrante, GrupoFamiliar),
    esChico(Integrante),
    atraccion(Atraccion, tranquila(chicos)).



