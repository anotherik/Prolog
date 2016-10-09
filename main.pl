% PREDICADOS AUXILIARES
% ---------------------

% verifica se um dado item pertence a uma lista
on(Item, [Item|_]).
on(Item, [_|Tail]) :- on(Item, Tail).

empty([], yes).
empty([_|_], no).

% obtem o maior valor numa lista
max([X], X).
max([X1,X2|Tail], Max) :- X1 > X2, max([X1|Tail], Max).
max([X1,X2|Tail], Max) :- X1 =< X2, max([X2|Tail], Max).

%  ------------------------- Pergunta 5 -------------------------  %

% (nr de cidades, nr populacao (milhoes),resultado (lista de continentes))
select_continents(Nr_of_cities, Nr_of_population, R) :- select_all_cities_by_population(Nr_of_population,Cities),
                                                         select_all_continents(Continents),
                                                         count_continent(Continents,Cities,L),
                                                         write(L),
                                                         select_continents_with_n_cities(L,Nr_of_cities,R).

% lista de continentes com Nr_C cidades
select_continents_with_n_cities([],_,[]).
select_continents_with_n_cities([[C,N]|L],Nr_C,[C|T]) :- N >= Nr_C, select_continents_with_n_cities(L,Nr_C,T).
select_continents_with_n_cities([[_,N]|L],Nr_C,T) :- N =< Nr_C, select_continents_with_n_cities(L,Nr_C,T).

% lista com pares ( Continente, numero de cidades com populacao maior que populacao dada)
count_continent([],_,[]).
count_continent([Cont|C],Cities,[[Cont,N]|R]) :- count_cities_by_continent(Cont,Cities,N), count_continent(C,Cities,R).

% numero de cidades com populacao maior que populacao do continente dado
count_cities_by_continent(_,[],0).
count_cities_by_continent(Cont,[[_,Cont]|T], N) :- count_cities_by_continent(Cont,T,N1), N is N1+1.
count_cities_by_continent(Cont,[[_,C]|T],N) :- Cont \= C, count_cities_by_continent(Cont,T,N).

% lista com todos os continentes
select_all_continents(Continents) :- findall(Country,country(_,Country,_,_,_,_,_,_,_,_),C), sort(C,Continents).

% par com (Cidade , Continente) das cidades com pelo menos P de populacao
get_city_by_population(Pop,City,Cont) :- city(City,Country,P),P>Pop,country(Country,Cont,_,_,_,_,_,_,_,_).

% lista com todos os pares (cidade, continente)
select_all_cities_by_population(Pop,Cities) :- findall([City,Continent],get_city_by_population(Pop,City,Continent),Cities).

%  ------------------------- Fim pergunta 5 -------------------------  %


% -----------------------------------  Start of  DCG ----------------------------------- %

start(Sentence, Result) :- atomic_list_concat(List, ' ' , Sentence), sentence(Result, List, []).

sentence(OE) --> open_ended(OE), {call(OE)}.
sentence(CE) --> close_ended(CE), {call(CE)}.
%sentence(sentence(FNP,FVP)) --> frase_nom_p(FNP), frase_verb_p(FVP).

open_ended(X) --> pronoun(X), noun(X), verb(Verb), prep(Prep), location(X).
open_ended(X) --> pronoun(X), noun(X), verb(Verb), prep(Prep), det(Det), location(X).
% where is the largest country
open_ended(X) --> pronoun(X), verb(Verb), det(Det), adj(X), noun(X).
% which countrys capital is london
open_ended(X) --> pronoun(X), noun(Noun), noun(X), verb(Verb), location(X).
%Is there some ocean that does not border any country
close_ended(X) --> verb(Verb), other(Other), other(Other2), noun(X), other(Other3), other(Other4), not(X), verb(X), other(Other5), noun(X).
% 					what 		are 		the   continents   which       contain    more     than        two       cities       whose  population exceeds    1         million
open_ended(X) --> pronoun(X), verb(Verb), det(Det), noun(X), pronoun(X), verb(Verb), adj(X), conj(X), num(Num), location(X), pronoun(X), noun(X), verb(X), num(Num), num(Num).
% 					which 	  country  bordering  the  mediterranean borders 	a      country   (that            is     bordered        by           a     country)+        whose   population exceeds     the   population     of      india
open_ended(X) --> pronoun(X,Y), noun(X,Y), verb(X,Y), det(Det), noun(X,Y), verb(X,Y), det(Det2), noun(X,Y), other(Other), verb(Verb), verb(X,Y), other(Other2), det(Det3), noun(X,Y), pronoun(Pronoun), noun(X,Y), verb(X,Y), det(Det4), noun(X,Y), prep(Prep), noun(X,Y),!.
%                          that           is       bordered         by           a        country
%repeatBorderedBy(X) --> other(Other), verb(Verb), verb(Verb2), other(Other2), det(Det), noun(Country).

%Pronouns
pronoun(findall(_,_,_)) --> [what].
pronoun(findall(_,_,_)) --> [where].
pronoun(findall(_,_,_), sort(_,_)) --> [which], {write('WHICH_')}.
pronoun(findall(_,_,_)) --> [than].
pronoun(pronoun(whose)) --> [whose], {write('WHOSE_')}.
pronoun(pronoun('howmany')) --> ['howmany'].


%Nouns
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

noun(findall(X, (ocean(X), P2),_)) --> [ocean], {write('OCEAN_')}.
noun(findall(X, (ocean(X), \+ borders(_, X)), _)) --> [country], {write('COUNTRY_')}.
%noun(country(Country,_,_,_,_,_,_,_,_,_), \+ borders(Country, _)) --> [country].

noun(findall(_, (_,_,_,_,country(_),_,_,_), _), sort(_,_)) --> [country], {write('COUNTRY1_')}.
noun(findall(_, (_,_,_,_,country(C3),_,_,borders(C3,mediterranean_sea)), _), sort(_,_)) --> [mediterranean], {write('MEDITERRANEAN_')}.
noun(findall(_, (_,_,_,country(C2),country(C3),_,borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)) --> [country], {write('COUNTRY2_')}.
noun(findall(_, (country(C1,_,_,_,_,_,_,_,_,_),_,_,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)) --> [country], {write('COUNTRY3_')}.
noun(findall(_, (country(C1,_,_,_,_,_,Pop1,_,_,_),_,_,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)) --> [population], {write('POP1_')}.
noun(findall(_, (country(C1,_,_,_,_,_,Pop1,_,_,_),country(_,_,_,_,_,_,Pop2,_,_,_),Pop>Pop2,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)) --> [population], {write('POP2_')}.
noun(findall(C3, (country(C1,_,_,_,_,_,Pop1,_,_,_),country(Country,_,_,_,_,_,Pop2,_,_,_),Pop>Pop2,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), L), sort(L,_)) --> [Country], {country(Country)}, {write(Country)}.

%Verbs
verb(verb(is)) --> [is], {write('IS_')}.
verb(verb(are)) --> [are].
verb(verb(contain)) --> [contain].
verb(findall(X, city(_, _, X), _)) --> [exceeds].
verb(findall(X, (ocean(X), \+ borders(_, X)), _)) --> [border], {write('BORDER_')}.
verb(findall(_, (_,_,_,_,country(C3),_,_,borders(C3,_)), _), sort(_,_)) --> [bordering], {write('BORDERING_')}.
verb(findall(_, (_,_,_,_,country(C3),_,borders(_,C3),borders(C3,mediterranean_sea)), _), sort(_,_)) --> [borders], {write('BORDERS_')}.
verb(findall(_, (_,_,_,country(C2),country(C3),borders(_,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)) --> [bordered], {write('BORDERED_')}.
verb(findall(_, (country(C1,_,_,_,_,_,Pop1,_,_,_),_,Pop1>_,country(C2),country(C3),borders(C1,C2),borders(C2,C3),borders(C3,mediterranean_sea)), _), sort(_,_)) --> [exceeds], {write('EXCEEDS_')}.


%Prepositions
prep(prep(in)) --> [in].
prep(prep(on)) --> [on].
prep(prep(of)) --> [of], {write('OF_')}.

%Other words
other(other(there)) --> [there], {write('THERE_')}.
other(other(some)) --> [some], {write('SOME_')}.
other(other(that)) --> [that], {write('THAT_')}.
other(other(does)) --> [does], {write('DOES_')}.
other(other(any)) --> [any], {write('ANY_')}.
other(other(that)) --> [that].
other(other(by)) --> [by], {write('BY_')}.
not(findall(X, (ocean(X), \+ P2),_)) --> [not], {write('NOT_')}.

%Determiners
det(det(the)) --> [the], {write('THE_')}.
det(det(a)) --> [a], {write('A_')}.

%Adjectives
adj(findall(X, (findall(_,_,_), max(_,_), Pred), _)) --> [largest]. % city or country
adj(adj(more)) --> [more].

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