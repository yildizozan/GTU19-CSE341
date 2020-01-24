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

sroute(VertexStart, Vertex, Dist) :-
  shortest(VertexStart, List),
  member(s(Vertex,Dist,_), List), !.

shortest(Vertex, Graph):-
  new_ds(Vertex, [Vertex], Temp),
  shortest_recurv(Temp, [s(Vertex,0,[])], Graph).

shortest_recurv([], X, X).
shortest_recurv([Head|Tail], Y, X) :-
  best_route(Tail, Head, S),
  delete_route([Head|Tail], [S], A),
  S=s(Vertex,Distance,Path),
  reverse([Vertex|Path], Path1),
  merge_routes(Y, [s(Vertex,Distance,Path1)], Z),
  new_ds(Vertex, [Vertex|Path], B),
  delete_route(B, Z, C),
  movement(C, Distance, D),
  merge_routes(A, D, E),
  shortest_recurv(E, Z, X).

new_ds(_, _, []).
new_ds(Start, Path, Edges):-
  setof(s(Vertex,Edge,Path), e(Start,Vertex,Edge), Edges), !.

best_route([], Best, Best).
best_route([Edge|Edges], Best0, Best) :-
  shorter(Edge, Best0), !,
  best_route(Edges, Edge, Best).
best_route([_|Edges], Best0, Best) :-
  best_route(Edges, Best0, Best).

shorter(s(_,X,_), s(_,Y,_)) :- X < Y.

delete_route([], _, []). 
delete_route([Head|Tail], [], [Head|Tail]) :- !.
delete_route([XHead|XTail], [YHead|YTail], Temp) :-
  equal_distance(XHead, YHead), !, 
  delete_route(XTail, YTail, Temp).
delete_route([XHead|XTail], [YHead|YTail], [XHead|Temp]) :-
  less_than(XHead, YHead), !, delete_route(XTail, [YHead|YTail], Temp).
delete_route([XHead|XTail], [_|YTail], Temp) :-
  delete_route([XHead|XTail], YTail, Temp).

merge_routes([], YTail, YTail). 
merge_routes([XHead|XTail], [], [XHead|XTail]) :- !.
merge_routes([XHead|XTail], [YHead|YTail], [XHead|ZTail]) :-
  equal_distance(XHead, YHead), shorter(XHead, YHead), !, 
  merge_routes(XTail, YTail, ZTail).
merge_routes([XHead|XTail], [YHead|YTail], [YHead|ZTail]) :-
  equal_distance(XHead, YHead), !, 
  merge_routes(XTail, YTail, ZTail).
merge_routes([XHead|XTail], [YHead|YTail], [XHead|ZTail]) :-
  less_than(XHead, YHead), !, 
  merge_routes(XTail, [YHead|YTail], ZTail).
merge_routes([XHead|XTail], [YHead|YTail], [YHead|ZTail]) :-
  merge_routes([XHead|XTail], YTail, ZTail).

equal_distance(s(X,_,_), s(X,_,_)).  

less_than(s(X,_,_), s(Y,_,_)) :- 
  X @< Y.

movement([], _, []).  
movement([s(Vertex, A, Node)|XTail], Increase, [s(Vertex, B, Node)|YTail]) :-
  B is A + Increase,
  movement(XTail, Increase, YTail).

e(X, Y, Z) :- distance(X, Y, Z).
e(X, Y, Z) :- distance(Y, X, Z).

path(Node, Node, _, [Node]).
path(Start, Finish, Visited, [Start | Path]) :-
     distance(Start, X, _),
     not(member(X, Visited)),
     path(X, Finish, [X | Visited], Path).

route(X,Y) :- distance(X,Y,_).
route(X,Y) :- distance(X,Z,_), route(Z,Y).
