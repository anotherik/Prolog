% PREDICADOS AUXILIARES
% ---------------------

% verifica se um dado item pertence a uma lista
on(Item, [Item|_]).
on(Item, [_|Tail]) :- on(Item, Tail).

rivers_in_country(Country, Result) :- river(Result, List), on(Country, List).
rivers_in_region(Region, Result) :- country(Country,Region,_,_,_,_,_,_,_,_), rivers_in_country(Country, Result).
cities_in_country(Country, Result) :- city(Result, Country, _).
cities_in_region(Region, Result) :- country(Country,Region,_,_,_,_,_,_,_,_), cities_in_country(Country, Result).
countries_in_region(Region, Result) :- country(Result,Region,_,_,_,_,_,_,_,_).

% obtem o maior valor numa lista
max([X],X).
max([X|L],X) :- max(L,M), X > M.
max([X|L],M) :- max(L,M), X =< M.


% DCG
% -----------------------
start(Sentence, Result) :- atomic_list_concat(List, ' ' , Sentence), sentence(Result, List, []).

sentence(OE) --> open_ended(OE), {call(OE)}.
sentence(CE) --> close_ended(CE).
%sentence(sentence(FNP,FVP)) --> frase_nom_p(FNP), frase_verb_p(FVP).

open_ended(X) --> pronoun(X), noun(X), verb(Verb), prep(Prep), location(X).
open_ended(X) --> pronoun(X), noun(X), verb(Verb), prep(Prep), det(Det), location(X).
% where is the largest country
open_ended(X) --> pronoun(X), verb(Verb), det(Det), adj(X), noun(C).
close_ended(X) --> verb(Verb), noun(X). %incompleto

%Pronouns
pronoun(findall(X, Q, L)) --> [what].
pronoun(findall(X, Q, L)) --> [where].
pronoun(pronoun(which)) --> [which].
pronoun(pronoun('how many')) --> ['how many'].

%Nouns
noun(noun(river)) --> [river].
noun(noun(ocean)) --> [ocean].
noun(noun(mountain)) --> [mountain].
noun(noun(country)) --> [country].

noun(findall(X, river(X,_), _)) --> [rivers].
noun(findall(X, rivers_in_country(_,X), _)) --> [rivers].
noun(findall(X, rivers_in_region(_,X), _)) --> [rivers].

noun(findall(X, city(X,_,_), _)) --> [cities].
noun(findall(X, cities_in_country(_,X), _)) --> [cities].
noun(findall(X, cities_in_region(_,X), _)) --> [cities].

noun(findall(X, country(X,_,_,_,_,_,_,_,_,_), _)) --> [countries].
noun(findall(X, countries_in_region(_,X), _)) --> [countries].

%Verbs
verb(verb(is)) --> [is].
verb(verb(are)) --> [are].

%Prepositions
prep(prep(in)) --> [in].
prep(prep(on)) --> [on].

%Determinants
det(det(the)) --> [the].

%Adjectives
%findall(X, dig(X), Digits), max_list(Digits, Max).
adj(findall(X, country(X,_,_,_,_,_,_,_,_,_), _)) --> [largest].

%Locations
location(location(south_america)) --> [south_america].
location(location(southern_europe)) --> [southern_europe].

location(findall(X, river(X,_), _)) --> [world].
location(findall(X, rivers_in_country(Country,X), _)) --> [Country], {country(Country,_,_,_,_,_,_,_,_,_)}.
location(findall(X, rivers_in_region(Region,X), _))  --> [Region], {country(_,Region,_,_,_,_,_,_,_,_)}.

location(findall(X, city(X,_,_), _)) --> [world].
location(findall(X, cities_in_country(Country,X), _)) --> [Country], {country(Country,_,_,_,_,_,_,_,_,_)}.
location(findall(X, cities_in_region(Region,X), _))  --> [Region], {country(_,Region,_,_,_,_,_,_,_,_)}.

location(findall(X, country(X,_,_,_,_,_,_,_,_,_), _)) --> [world].
location(findall(X, countries_in_region(Region,X), _))  --> [Region], {country(_,Region,_,_,_,_,_,_,_,_)}.