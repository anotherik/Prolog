% 1 - questions like:
% what rivers/cities/countries are in the world
% what rivers/cities are in Country
% what rivers/cities/countries are in Region

:- write('Question: what rivers are in the world? '), nl.
:- start('what rivers are in the world', Query), write(Query), nl.
:- write('Question: what rivers are in portugal? '), nl.
:- start('what rivers are in portugal', Query), write(Query), nl.
:- write('Question: what cities are in portugal? '), nl.
:- start('what cities are in portugal', Query), write(Query), nl.
:- write('Question: what countries are in western_europe? '), nl.
:- start('what countries are in western_europe', Query), write(Query), nl.

% 2
% where is the largest country/city
:- write('Question: where is the largest city? '), nl.
:- start('where is the largest city', Query), write(Query), nl.
:- write('Question: where is the largest country? '), nl.
:- start('where is the largest country', Query), write(Query), nl.

% 3
<<<<<<< HEAD
:- write('Question: what countrys capital is london? '), nl.
:- start('what countrys capital is london', Query), write(Query), nl.
:- write('Question: what countrys capital is brasilia? '), nl.
:- start('what countrys capital is brasilia', Query), write(Query), nl.
:- write('Question: what countrys capital is lisbon? '), nl.
:- start('what countrys capital is lisbon', Query), write(Query), nl.

% 4
:- write('Question: is there some ocean that does not border any country? '), nl.
:- start('is there some ocean that does not border any country', R), write(R), nl.
=======
:- write('Question 3 ... '), nl.
:- start('what country\'s capital is london', Query).
:- start('what country\'s capital is brasilia', Query).
:- start('what country\'s capital is lisbon', Query).

% 4
:- write('Question 4 ... '), nl.
:- start('is there some ocean that does not border any country', R).
>>>>>>> b8c8ae848ae285dba491b6eb2618bb9d2b810953

% 5
:- write('Question: what are the continents which contain more than 2 cities whose population exceeds 1 million? '), nl.
:- start('what are the continents which contain more than 2 cities whose population exceeds 1 million', R), write(R), nl.

% 6
:- write('Question: which country bordering the mediterranean borders a country that is bordered by a country whose population exceeds the population of france? '), nl.
:- start('which country bordering the mediterranean borders a country that is bordered by a country whose population exceeds the population of france', R), write(R), nl.

