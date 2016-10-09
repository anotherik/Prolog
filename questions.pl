% 1 - questions like:
% what rivers/cities/countries are in the world
% what rivers/cities are in Country
% what rivers/cities/countries are in Region

:- write('Question 1 ... '), nl.
:- start('what rivers are in the world', Query).
:- start('what rivers are in portugal', Query).
:- start('what cities are in portugal', Query).
:- start('what countries are in portugal', Query).

% 2
% where is the largest country/city
:- write('Question 2 ... '), nl.
:- start('where is the largest city', Query).
:- start('where is the largest country', Query).

% 3
:- write('Question 3 ... '), nl.
:- start('what country\'s capital is london', Query).
:- start('what country\'s capital is brasilia', Query).
:- start('what country\'s capital is lisbon', Query).

% 4
:- write('Question 4 ... '), nl.
:- start('is there some ocean that does not border any country', R).

% 5
:- write('Question 5 ... '), nl.
:- start('what are the continents which contain more than 2 cities whose population exceeds 1 million', R).

% 6
:- write('Question 6 ... '), nl.
:- start('which country bordering the mediterranean borders a country that is bordered by a country whose population exceeds the population of france', R).

