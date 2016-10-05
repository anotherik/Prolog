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
max([X], X).
max([X1,X2|Tail], Max) :- X1 > X2, max([X1|Tail], Max).
max([X1,X2|Tail], Max) :- X1 =< X2, max([X2|Tail], Max).


% DCG
% -----------------------
start(Sentence, Result) :- atomic_list_concat(List, ' ' , Sentence), sentence(Result, List, []).

sentence(OE) --> open_ended(OE), {call(OE)}.
sentence(CE) --> close_ended(CE).
%sentence(sentence(FNP,FVP)) --> frase_nom_p(FNP), frase_verb_p(FVP).

open_ended(X) --> pronoun(X), noun(X), verb(Verb), prep(Prep), location(X).
open_ended(X) --> pronoun(X), noun(X), verb(Verb), prep(Prep), det(Det), location(X).
% where is the largest country
open_ended(X) --> pronoun(X), verb(Verb), det(Det), adj(X), noun(X).
% which country's capital is london
open_ended(X) --> pronoun(X), noun(Noun), noun(X), verb(Verb), location(X).
close_ended(X) --> verb(Verb), noun(X). %incompleto

%Pronouns
pronoun(findall(_, _, _)) --> [what].
pronoun(findall(_, _, _)) --> [where].
pronoun(findall(_, _, _)) --> [which].
pronoun(pronoun('how many')) --> ['how many'].

%Nouns
noun(noun(river)) --> [river].
noun(noun(ocean)) --> [ocean].
noun(noun(mountain)) --> [mountain].

noun(findall(X, river(X,_), _)) --> [rivers].
noun(findall(X, rivers_in_country(_,X), _)) --> [rivers].
noun(findall(X, rivers_in_region(_,X), _)) --> [rivers].

noun(findall(X, city(X,_,_), _)) --> [cities].
noun(findall(X, cities_in_country(_,X), _)) --> [cities].
noun(findall(X, cities_in_region(_,X), _)) --> [cities].

noun(findall(X, country(X,_,_,_,_,_,_,_,_,_), _)) --> [countries].
noun(findall(X, countries_in_region(_,X), _)) --> [countries].

%noun(findall(X, (findall(Area, country(_,_,_,_,Area,_,_,_,_,_), Areas), max(Areas, MaxArea), country(X,_,_,_,MaxArea,_,_,_,_,_)), _)) --> [country].
noun(findall(X, (findall(Area, country(_,_,_,_,Area,_,_,_,_,_), Areas), max(Areas, MaxArea), country(_,X,_,_,MaxArea,_,_,_,_,_)), _)) --> [country].
noun(findall(X, (findall(Area, city(_,_, Area), Areas), max(Areas, MaxArea), city(_, X, MaxArea)), _)) --> [city].

noun(noun('country\'s')) --> ['country\'s'].
noun(findall(X, country(X,_,_,_,_,_,_,_,_,_), _)) --> [capital].

%Verbs
verb(verb(is)) --> [is].
verb(verb(are)) --> [are].

%Prepositions
prep(prep(in)) --> [in].
prep(prep(on)) --> [on].

%Determinants
det(det(the)) --> [the].

%Adjectives
adj(findall(X, (findall(_,_,_), max(_,_), Pred), _)) --> [largest]. % city or country

%Locations
location(findall(X, river(X,_), _)) --> [world].
location(findall(X, rivers_in_country(Country,X), _)) --> [Country], {country(Country,_,_,_,_,_,_,_,_,_)}.
location(findall(X, rivers_in_region(Region,X), _))  --> [Region], {country(_,Region,_,_,_,_,_,_,_,_)}.

location(findall(X, city(X,_,_), _)) --> [world].
location(findall(X, cities_in_country(Country,X), _)) --> [Country], {country(Country,_,_,_,_,_,_,_,_,_)}.
location(findall(X, cities_in_region(Region,X), _))  --> [Region], {country(_,Region,_,_,_,_,_,_,_,_)}.

location(findall(X, country(X,_,_,_,_,_,_,_,_,_), _)) --> [world].
location(findall(X, countries_in_region(Region,X), _))  --> [Region], {country(_,Region,_,_,_,_,_,_,_,_)}.

location(findall(X, country(X,_,_,_,_,_,_,_,Capital,_), _)) --> [Capital], {country(_,_,_,_,_,_,_,_,Capital,_)}.