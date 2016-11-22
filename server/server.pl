:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_files)).
:- use_module(library(http/http_parameters)).

:- http_handler(root(.), http_reply_from_files('.', []), [prefix]).
:- http_handler(root(hello), say_hi, []).
:- http_handler(root(query), process_query, []).
:- http_handler(root(coords), get_coords, []).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).

say_hi(_Request) :-
    format('Content-type: text/plain~n~n'),
    format('Hello World!~n').

process_query(Request) :-
	http_parameters(Request, [question(Question, [])]),
	start(Question, Response),
    format('Content-type: text/plain~n~n'),
    format('~w~n', [Response]).

get_coords(Request) :-
	(
	(http_parameters(Request, [river(River, [optional(true)])]),
	River \= true,
	findall([Lat,Lng], river_coords(River,Lat,Lng), Response))
	;
	(http_parameters(Request, [capital(Capital, [optional(true)])]),
	Capital \= true,
    findall([Lat,Lng], country(Capital,_,Lat,Lng,_,_,_,_,_,_), Response))
	),
    format('Content-type: text/plain~n~n'),
    format('~w~n', [Response]).
