%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Create more facts about geography
%% 2. Examples of natural language questions follow below
%%    Your program needs to parse those questions 
%%    and give correct answers. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Facts about rivers.
% ------------------

river(amazon,[atlantic,brazil,peru]).
river(euphrates,[persian_gulf,iraq,syria,turkey]).
river(ganges,[indian_ocean,spain,india,china]).
river(nile,[mediterranean,egypt,sudan,uganda]).
river(yangtze,[pacific,china]).
river(douro,[portugal,spain]).
river(minho,[portugal,spain]).
river(tejo,[portugal,espanha]).

% Facts about countries.
% ---------------------

% country(Country,Region,Latitude,Longitude,
%         Area/1000,Area mod 1000,
%         Population/1000000,Population mod 1000000 / 1000,
%         Capital,Currency)

country(brazil,south_america,-14,-52,3286,470,200,400,brasilia,real).
country(portugal,southern_europe,39,-8,35,340,10,460,lisbon,euro).
country(spain,southern_europe,40,-4,504,782,46,64,madrid,euro).


% Facts about Europe.
% ------------------

borders(portugal,spain).
borders(portugal,atlantic).

% Facts about cities.
% ------------------

% city(City,Country,Population - million)

city(porto,portugal,0.230).
city(madrid,spain,3.165).
city(lisbon,portugal,0.516).

% Examples of natural language questions

% What | rivers | are | in | the | world?
% What is the largest country?
% Where is the largest country?
% Which countrys capital is London?
% Is there some ocean that does not border any country?
% What are the continents which contain more than two cities whose population exceeds 1 million?
% Which country bordering the Mediterranean borders a country that is bordered by a country whose population exceeds the population of India?

/* What do you need to do?

Assume the first question above: "What rivers are in the world?". Your
first step is to convert this sentence in a list of words. Then you
need to take that list of words and *automatically* generate a Prolog
query of the type: findall(X,river(X,_),L). The last step is to
execute this query (maybe using the built-in predicate "call"), and
return the result (which should be in L).

Hint1: Because some sentences may need nested findall predicates, it is
recommended to convert the list of words in a tree (for example, using
a DCG grammar) in order to know where in the code you need to add the
nested findall with the right predicates.

Hint2: Questions starting with "what", "which", "where" will have a
findall and probably return the whole list of results. Questions
starting with "How many" will need a combination of
"findall(...,...,L), length(L,N)", where N will be the answer.
*/
