% PREDICADOS AUXILIARES
% ---------------------

% verifica se um dado item pertence a uma lista
on(Item, [Item|_]).
on(Item, [_|Tail]) :- on(Item, Tail).

% calcula o valor maximo de uma lista de numeros
max([X], X).
max([X1,X2|Tail], Max) :- X1 > X2, max([X1|Tail], Max).
max([X1,X2|Tail], Max) :- X1 =< X2, max([X2|Tail], Max).

% concatena duas listas
append([], L, L). 
append([H|T], L1, [H|L2]) :- append(T, L1, L2).

% PREDICADOS PRINCIPAIS
% ---------------------

% todos os rios
rivers_in(world, Result) :- river(Result, _).
% rios de um dado pais
rivers_in(Country, Result) :- river(Result, List), on(Country, List).

% capital/regiao/area de um dado pais
capital(Country, Result) :- country(Country,_,_,_,_,_,_,_,Result,_).
region(Country, Result) :- country(Country,Result,_,_,_,_,_,_,_,_).
area(Country, Result) :- country(Country,_,_,_,Result,_,_,_,_,_).

% devolve uma lista com todos os paises/areas
all_countries(Result) :- findall(Country, country(Country,_,_,_,_,_,_,_,_,_), Result).
all_areas(Result) :- findall(Area, country(_,_,_,_,Area,_,_,_,_,_), Result).

% devolve uma lista com as areas dos paises da lista dada (esta deu-me um nó no cérebro. Mas consegui!)
areas([X], [Result]) :- area(X, Result).
areas([H|T], Result) :- 
	area(H, Area1), 
	areas(T, List),
	append(List, [Area1], Result).

% verifica se um pais tem mais area que outro
bigger(Country1, Country2) :- area(Country1, A1), area(Country2, A2), A1 > A2.
% calcula qual o pais com mais area de todos
biggest_country(all, Result) :- all_countries(List), biggest_country(List, Result).
% calcula qual o pais com mais area de entre os paises da lista dada
biggest_country(List, Result) :- 
	areas(List, Areas),
	max(Areas, Max_area), 
	country(Result,_,_,_,Max_area,_,_,_,_,_).