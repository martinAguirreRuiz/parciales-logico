% rata(Nombre, Domicilio).
rata(remy, gusteaus).
rata(emile, bar).
rata(django, pizzeria).

rata(Rata) :-
    rata(Rata, _).

% cocina(Nombre, Plato, Experiencia)
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).
cocina(colette, ensaladaRusa, 7).

plato(Plato) :-
    cocina(_, Plato, _).

% trabajaEn(Lugar, Nombre).
trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

empleado(Persona) :-
    cocina(Persona, _, _).

restaurante(Restaurante) :-
    trabajaEn(Restaurante, _).
restaurante(bar).
restaurante(pizzeria).

% **************
% ** PUNTO 01 **
% **************

inspeccionSatisfactoria(Restaurante) :-
    restaurante(Restaurante),
    not(rata(_, Restaurante)).


% **************
% ** PUNTO 02 **
% **************

chef(Empleado, Restaurante) :-
    empleado(Empleado),
    restaurante(Restaurante),
    trabajaEn(Restaurante, Empleado).

% **************
% ** PUNTO 03 **
% **************

chefcito(Rata) :-
    rata(Rata, Restaurante),
    trabajaEn(Restaurante, linguini).

% **************
% ** PUNTO 04 **
% **************

cocinaBien(remy, _).
cocinaBien(Empleado, Plato) :-
    empleado(Empleado),
    cocina(Empleado, Plato, Experiencia),
    Experiencia > 7.

% **************
% ** PUNTO 05 **
% **************

encargadoDe(Empleado, Plato, Restaurante) :-
    trabajaEn(Restaurante, Empleado),
    cocina(Empleado, Plato, Experiencia),
    forall(obtenerExperiencia(Restaurante, Plato, OtraExperiencia), Experiencia >= OtraExperiencia).

obtenerExperiencia(Restaurante, Plato, OtraExperiencia) :-
    trabajaEn(Restaurante, Empleado), 
    cocina(Empleado, Plato, OtraExperiencia).

% **************
% ** PUNTO 06 **
% **************

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).
plato(noMeQuemes, postre(800)).

grupo(noMeQuemes).

saludable(Plato) :-
    plato(Plato, TipoDePlato),
    calorias(TipoDePlato, Calorias),
    Calorias < 75.
saludable(Plato) :-
    plato(Plato, postre(_)),
    grupo(Plato).


calorias(postre(CaloriasTotales), CaloriasTotales).
calorias(entrada(Ingredientes), CaloriasTotales) :-
    length(Ingredientes, Cantidad),
    CaloriasTotales is Cantidad * 15.

calorias(principal(Guarnicion, Coccion), CaloriasTotales) :-
    sumarSegunCoccion(Coccion, Calorias),
    sumarSegunGuarnicion(Guarnicion, Calorias, CaloriasTotales).

sumarSegunCoccion(Coccion, Calorias) :-
    Calorias is Coccion * 5.
    
sumarSegunGuarnicion(papasFritas, Calorias, CaloriasTotales) :-
    CaloriasTotales is Calorias + 50.
sumarSegunGuarnicion(pure, Calorias, CaloriasTotales) :-
    CaloriasTotales is Calorias + 20.
sumarSegunGuarnicion(Guarnicion, Calorias, Calorias) :-
    Guarnicion \= papasFritas,
    Guarnicion \= pure.

% **************
% ** PUNTO 07 **
% **************

critico(antonEgo).
critico(cristophe).
critico(cormillot).
critico(gordonRamsay).

criticaPositiva(Restaurante, Critico) :-
    critico(Critico),
    Critico \= gordonRamsay,
    restaurante(Restaurante),
    inspeccionSatisfactoria(Restaurante),
    condicionesCritico(Restaurante, Critico).

condicionesCritico(Restaurante, antonEgo) :-
    esEspecialista(Restaurante, ratatouille).

condicionesCritico(Restaurante, cristophe) :-
    tieneMasDe3Chefs(Restaurante).

condicionesCritico(Restaurante, cormillot) :-
    todosLosPlatosSaludables(Restaurante),
    ningunaEntradaSinZanahoria(Restaurante).


esEspecialista(Restaurante, Plato) :-
    forall(trabajaEn(Restaurante, Empleado), cocinaBien(Empleado, Plato)).

tieneMasDe3Chefs(Restaurante) :-
    findall(Empleado, trabajaEn(Restaurante, Empleado), Empleados),
    length(Empleados, Cantidad),
    Cantidad > 3.
    
todosLosPlatosSaludables(Restaurante) :-
    forall(trabajaEn(Restaurante, Empleado), platoSaludable(Empleado)).

platoSaludable(Empleado) :-
    cocina(Empleado, Plato, _), 
    saludable(Plato).

ningunaEntradaSinZanahoria(Restaurante) :-
    forall(trabajaEn(Restaurante, Empleado), entradaConZanahoria(Empleado)).

entradaConZanahoria(Empleado) :-
    cocina(Empleado, Plato, _),
    plato(Plato, entrada(Ingredientes)),
    member(zanahoria, Ingredientes).
    
entradaConZanahoria(Empleado) :-
    cocina(Empleado, Plato, _),
    not(plato(Plato, entrada(_))).