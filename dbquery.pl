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

% What rivers are in the world? rivers_in(world, X).
% What is the largest country? biggest_country(all, X).
% Where is the largest country? tendo a anterior, esta é fácil
% Which countrys capital is London? capital(X, london).
% Is there some ocean that does not border any country?
% What are the continents which contain more than two cities whose population exceeds 1 million?
% Which country bordering the Mediterranean borders a country that is bordered by a country whose population exceeds the population of India?

