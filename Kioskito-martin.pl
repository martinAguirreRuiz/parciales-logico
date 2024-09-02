% **************
% ** PUNTO 01 **
% **************

atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).

atiende(lucas, martes, 10, 20).

atiende(juanC, sabado, 18, 22).
atiende(juanC, domingo, 18, 22).

atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).

atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).

atiende(nadie, lunes, 14, 18).
atiende(nadie, miercoles, 14, 18).

atiende(martu, miercoles, 23, 24).

atiende(vale, lunes, 9, 15).
atiende(vale, miercoles, 9, 15).
atiende(vale, viernes, 9, 15).
atiende(vale, sabado, 18, 22).
atiende(vale, domingo, 18, 22).

% **************
% ** PUNTO 02 **
% **************

persona(Persona) :-
    atiende(Persona, _, _, _).

horario(Dia, Hora, Persona) :-
    persona(Persona),
    atiende(Persona, Dia, Inicio, Fin),
    between(Inicio, Fin, Hora).

% **************
% ** PUNTO 03 **
% **************

foreverAlone(Dia, Hora, Persona) :-
    horario(Dia, Hora, Persona),
    not(estaAcompaniado(Persona, Dia, Hora)).

estaAcompaniado(Persona, Dia, Hora) :-
    horario(OtraPersona, Dia, Hora),
    Persona \= OtraPersona.

% **************
% ** PUNTO 04 **
% **************

% posibilidadAtencion(Dia, [Persona | Resto]) :-
    

% **************
% ** PUNTO 05 **
% **************

venta(dodain, lunes, 10, [golosina(1200), cigarrillo(jockey), golosina(50)]).

venta(dodain, miercoles, 12, [bebida(alcoholica, 8), bebida(sinAlcohol, 1), golosina(10)]).

venta(martu, miercoles, 12, [golosina(1000), cigarrillo([chesterfield, colorado, parisiennes])]).

venta(lucas, martes, 11,[golosina(600)]).

venta(lucas, martes, 18, [bebida(sinAlcohol, 2), cigarrillo(derby)]).

suertudo(Persona) :-
    persona(Persona),
    forall(primerVenta(Persona, Venta), ventaImportante(Venta)).

primerVenta(Persona, Venta) :-
    venta(Persona, _, _, Ventas),
    nth1(1, Ventas, Venta).

ventaImportante(golosina(Cuanto)) :-
    Cuanto > 100.
ventaImportante(cigarrillo(Marcas)) :-
    length(Marcas, Cantidad),
    Cantidad > 2.
    
ventaImportante(bebida(alcoholica, _)).
ventaImportante(bebida(_, Cantidad)) :-
    Cantidad > 5.





