flight(antalya, konya).
flight(konya, ankara).
flight(van, ankara).
flight(rize, van).
flight(istanbul, rize).
flight(istanbul, van).
flight(istanbul, ankara).
flight(antalya, gaziantep).
flight(istanbul, gaziantep).
flight(istanbul, antalya).
flight(istanbul, izmir).
flight(izmir, isparta).
flight(isparta, burdur).
flight(edremit, erzincan).
flight(edirne, edremit).

distance(antalya, konya, 192).
distance(konya, ankara, 227).
distance(van, ankara, 920).
distance(rize, van, 373).
distance(istanbul, rize, 967).
distance(istanbul, van, 1262).
distance(istanbul, ankara, 351).
distance(antalya, gaziantep, 592).
distance(istanbul, gaziantep, 847).
distance(istanbul, antalya, 482).
distance(istanbul, izmir, 328).
distance(izmir, isparta, 308).
distance(burdur, isparta, 24).
distance(edremit, erzincan, 736).
distance(edirne, edremit, 914).

% Experimental
path_alt(Node, Node, _, [Node]).
path_alt(Start, Finish, Visited, [Start | Path]) :-
     flight(Start, X),
     not(member(X, Visited)),
     path_alt(X, Finish, [X | Visited], Path).

route_experimental(From, To, Path) :-
     path_alt(From, To, [From], Path).

route(From, To) :- flight(From,To).
route(From, To) :- flight(From, Temp), route(Temp, To).
route(From, To) :-
    flight(From, Temp),
    not(Temp = To),
    route(Temp, To).

