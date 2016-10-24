%  -------------------- Predicados Auxiliares --------------------  %

% verifica se um dado item pertence a uma lista
on(Item, [Item|_]).
on(Item, [_|Tail]) :- 
		on(Item, Tail).

empty([], yes).
empty([_|_], no).

% obtem o maior valor numa lista
max([X], X).
max([X1,X2|Tail], Max) :- 
		X1 > X2, 
		max([X1|Tail], Max).
max([X1,X2|Tail], Max) :- 
		X1 =< X2, 
		max([X2|Tail], Max).

%  ------------------------- Pergunta 5 -------------------------  %

% (nr de cidades, nr populacao (milhoes),resultado (lista de continentes))
select_continents(Nr_of_cities, Nr_of_population, R) :- 
		select_all_cities_by_population(Nr_of_population,Cities),
        select_all_continents(Continents),
        count_continent(Continents,Cities,L),
        select_continents_with_n_cities(L,Nr_of_cities,R), !.

% lista de continentes com Nr_C cidades
select_continents_with_n_cities([],_,[]).
select_continents_with_n_cities([[C,N]|L],Nr_C,[C|T]) :- 
			N >= Nr_C, 
			select_continents_with_n_cities(L,Nr_C,T).
select_continents_with_n_cities([[_,N]|L],Nr_C,T) :- 
			N =< Nr_C, 
			select_continents_with_n_cities(L,Nr_C,T).

% lista com pares ( Continente, numero de cidades com populacao maior que populacao dada)
count_continent([],_,[]).
count_continent([Cont|C],Cities,[[Cont,N]|R]) :- 
			count_cities_by_continent(Cont,Cities,N), 
			count_continent(C,Cities,R).

% numero de cidades com populacao maior que populacao do continente dado
count_cities_by_continent(_,[],0).
count_cities_by_continent(Cont,[[_,Cont]|T], N) :- 
			count_cities_by_continent(Cont,T,N1), 
			N is N1+1.
count_cities_by_continent(Cont,[[_,C]|T],N) :- 
			Cont \= C, 
			count_cities_by_continent(Cont,T,N).

% lista com todos os continentes
select_all_continents(Continents) :- 
			findall(Country,country(_,Country,_,_,_,_,_,_,_,_),C), 
			sort(C,Continents).

% par com (Cidade , Continente) das cidades com pelo menos P de populacao
get_city_by_population(Pop,City,Cont) :- 
			city(City,Country,P),
			P>Pop,country(Country,Cont,_,_,_,_,_,_,_,_).

% lista com todos os pares (cidade, continente)
select_all_cities_by_population(Pop,Cities) :- 
			findall([City,Continent],
			get_city_by_population(Pop,City,Continent),Cities).

%  ------------------------- Fim pergunta 5 -------------------------  %


% -----------------------------------  Start of  DCG ----------------------------------- %

start(Sentence, L) :- 
	atomic_list_concat(List, ' ' , Sentence), 
	sentence(Result, List, []), 
	call(Result),
	arg(3,Result,L).

sentence(OE) --> open_ended(OE).%, {call(OE)}.
sentence(CE) --> close_ended(CE).%, {call(CE)}.

%                    what     rivers      are         in         world
open_ended(X) --> pronoun(X), noun(X), verb(Verb), prep(Prep), location(X).
open_ended(X) --> pronoun(X), noun(X), verb(Verb), prep(Prep), det(Det), location(X).
%                   where         is        the    largest  country
open_ended(X) --> pronoun(X), verb(Verb), det(Det), adj(X), noun(X).
%                   which      countrys   capital      is        london
open_ended(X) --> pronoun(X), noun(Noun), noun(X), verb(Verb), location(X).
%                      is          there         some        ocean       that           does        not    border      any         country
close_ended(X) --> verb(Verb), other(Other), other(Other2), noun(X), other(Other3), other(Other4), not(X), verb(X), other(Other5), noun(X).
% 					what 		are 		the     continents     which       contain       more        than            two            cities             whose         population   exceeds        1         million
open_ended(X) --> pronoun(X), verb(Verb), det(Det), noun(Noun), other(Other), verb(Verb2), adj(Adj), other(Other2), num_cities(X), location(Location), pronoun(Pronoun), noun(Pop), verb(Verb3), num_pop(X), other(Other3), !.
% 					which 	  country  bordering  the  mediterranean borders 	a      country      that         is      bordered       by           a       country       whose      population exceeds     the   population     of      india
open_ended(X) --> pronoun(X), noun(X), verb(X), det(Det), noun(X), verb(X), det(Det2), noun(X), other(Other), verb(Verb), verb(X), other(Other2), det(Det3), noun(X), pronoun(Pronoun), noun(X), verb(X), det(Det4), noun(X), prep(Prep), noun(X),!.
%                          that           is       bordered         by           a        country
%repeatBorderedBy(X) --> other(Other), verb(Verb), verb(Verb2), other(Other2), det(Det), noun(Country).

% Pronouns
pronoun(findall(_,_,_)) --> [what].
pronoun(findall(_,_,_)) --> [where].
pronoun(findall(_,_,_)) --> [which].
pronoun(pronoun(whose)) --> [whose].
pronoun(pronoun('howmany')) --> ['howmany'].

% Nouns
noun(noun(river)) --> [river].
noun(noun(ocean)) --> [ocean].
noun(noun(mountain)) --> [mountain].

noun(findall(X, city(_,_,X), _)) --> [population].

noun(findall(X, river(X,_), _)) --> [rivers].
noun(findall(X, (river(X,_), on(_,_)), _)) --> [rivers].
noun(findall(X, (river(X,_), country(_,_,_,_,_,_,_,_,_,_), on(_,_)), _)) --> [rivers].

noun(findall(X, city(X,_,_), _)) --> [cities].
noun(findall(X, (city(X,_,_), country(_,_,_,_,_,_,_,_,_,_)), _)) --> [cities].

noun(findall(X, country(X,_,_,_,_,_,_,_,_,_), _)) --> [countries].

%noun(findall(X, (findall(Area, country(_,_,_,_,Area,_,_,_,_,_), Areas), max(Areas, MaxArea), country(X,_,_,_,MaxArea,_,_,_,_,_)), _)) --> [country].
noun(findall(X, (findall(Area, country(_,_,_,_,Area,_,_,_,_,_), Areas), max(Areas, MaxArea), country(_,X,_,_,MaxArea,_,_,_,_,_)), _)) --> [country].
noun(findall(X, (findall(Area, city(_,_, Area), Areas), max(Areas, MaxArea), city(_, X, MaxArea)), _)) --> [city].

noun(noun('country\'s')) --> ['country\'s'].
noun(findall(X, country(X,_,_,_,_,_,_,_,_,_), _)) --> [capital].

noun(findall(X, country(_,X,_,_,_,_,_,_,_,_), _)) --> [continents].

noun(findall(X, (ocean(X), P2),_)) --> [ocean].
noun(findall(X, (ocean(X), \+ borders(_, X)), _)) --> [country].

noun(noun(continents)) --> [continents].
noun(noun(population)) --> [population].

noun(findall(_, (findall(_, (_,_,_,_,country(_),_,_,_), _), sort(_,_)), _)) --> [country].
noun(findall(_, (findall(_, (_,_,_,_,country(C3),_,_,borders(C3,mediterranean_sea)), _), sort(_,_)), _)) --> [mediterranean].
noun(findall(_, (findall(_, (_,_,_,country(C2),country(C3),_,borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)), _)) --> [country].
noun(findall(_, (findall(_, (country(C1,_,_,_,_,_,_,_,_,_),_,_,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)), _)) --> [country].
noun(findall(_, (findall(_, (country(C1,_,_,_,_,_,Pop1,_,_,_),_,_,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)), _)) --> [population].
noun(findall(_, (findall(_, (country(C1,_,_,_,_,_,Pop1,_,_,_),country(_,_,_,_,_,_,Pop2,_,_,_),Pop>Pop2,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)), _)) --> [population].
noun(findall(X, (findall(C3, (country(C1,_,_,_,_,_,Pop1,_,_,_),country(Country,_,_,_,_,_,Pop2,_,_,_),Pop>Pop2,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), L), sort(L,X)), _)) --> [Country], {country(Country)}.

%Verbs
verb(verb(is)) --> [is].
verb(verb(are)) --> [are].
verb(verb(contain)) --> [contain].
verb(findall(X, city(_, _, X), _)) --> [exceeds].
verb(findall(X, (ocean(X), \+ borders(_, X)), _)) --> [border].
verb(findall(_, (findall(_, (_,_,_,_,country(C3),_,_,borders(C3,_)), _), sort(_,_)), _)) --> [bordering].
verb(findall(_, (findall(_, (_,_,_,_,country(C3),_,borders(_,C3),borders(C3,mediterranean_sea)), _), sort(_,_)), _)) --> [borders].
verb(findall(_, (findall(_, (_,_,_,country(C2),country(C3),borders(_,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)), _)) --> [bordered].
verb(findall(_, (findall(_, (country(C1,_,_,_,_,_,Pop1,_,_,_),_,Pop1>_,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)), _)) --> [exceeds].
verb(verb(exceeds)) --> [exceeds].

%Prepositions
prep(prep(in)) --> [in].
prep(prep(on)) --> [on].
prep(prep(of)) --> [of].

%Determiners
det(det(the)) --> [the].
det(det(a)) --> [a].

%Adjectives
adj(findall(X, (findall(_,_,_), max(_,_), Pred), _)) --> [largest]. % city or country
adj(adj(more)) --> [more].

%Numbers
num_cities(findall(X, select_continents(Num1_int, _, X), _)) --> [Num1], {atom_number(Num1, Num1_int), between(0, 100, Num1_int)}.
num_pop(findall(X, select_continents(Num1_int, Num2_int, X), _)) --> [Num2], {atom_number(Num2, Num2_int), between(0, 100, Num2_int)}.

%Locations
location(findall(X, river(X,_), _)) --> [world].
location(findall(X, (river(X, L), on(Country, L)), _)) --> [Country], {country(Country,_,_,_,_,_,_,_,_,_)}.
location(findall(X, (river(X, L), country(Country, Region,_,_,_,_,_,_,_,_), on(Country, L)), _)) --> [Region], {country(_,Region,_,_,_,_,_,_,_,_)}.

location(findall(X, city(X,_,_), _)) --> [world].
location(findall(X, city(X, Country, _), _)) --> [Country], {country(Country,_,_,_,_,_,_,_,_,_)}.
location(findall(X, (city(X, Country, _), country(Country, Region,_,_,_,_,_,_,_,_)), _)) --> [Region], {country(_,Region,_,_,_,_,_,_,_,_)}.

location(findall(X, country(X,_,_,_,_,_,_,_,_,_), _)) --> [world].
location(findall(X, country(X, Region,_,_,_,_,_,_,_,_), _)) -->  [Region], {country(_,Region,_,_,_,_,_,_,_,_)}.

location(findall(X, country(X,_,_,_,_,_,_,_,Capital,_), _)) --> [Capital], {country(_,_,_,_,_,_,_,_,Capital,_)}.

location(location(cities)) --> [cities].

%Other words
other(other(there)) --> [there].
other(other(some)) --> [some].
other(other(that)) --> [that].
other(other(does)) --> [does].
other(other(any)) --> [any].
other(other(by)) --> [by].
other(other(which)) --> [which].
other(other(than)) --> [than].
other(other(million)) --> [million].
not(findall(X, (ocean(X), \+ P2),_)) --> [not].