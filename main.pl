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


% DCG
% -----------------------
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


%Pronouns
pronoun(findall(_, _, _)) --> [what].
pronoun(findall(_, _, _)) --> [where].
pronoun(findall(_, _, _)) --> [which].
pronoun(findall(_, _, _)) --> [than].
pronoun(findall(_, _, _)) --> [whose].
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

%Verbs
verb(verb(is)) --> [is], {write('IS_')}.
verb(verb(are)) --> [are].
verb(verb(contain)) --> [contain].
verb(findall(X, city(_, _, X), _)) --> [exceeds].
verb(findall(X, (ocean(X), \+ borders(_, X)), _)) --> [border], {write('BORDER_')}.

%Prepositions
prep(prep(in)) --> [in].
prep(prep(on)) --> [on].

%Other words
other(other(there)) --> [there], {write('THERE_')}.
other(other(some)) --> [some], {write('SOME_')}.
other(other(that)) --> [that], {write('THAT_')}.
other(other(does)) --> [does], {write('DOES_')}.
other(other(any)) --> [any], {write('ANY_')}.
not(findall(X, (ocean(X), \+ P2),_)) --> [not], {write('NOT_')}.

%Determiners
det(det(the)) --> [the], {write('THE_')}.

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