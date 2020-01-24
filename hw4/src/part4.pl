element(Element, [Element|_]).
element(Element, [_|Tail]) :-
    element(Element, Tail).

union([], Set2, Set2).
union([Set1Head|Set1Tail], Set2, Result):-
    element(Set1Head, Set2), !, union(Set1Tail, Set2, Result).
union([Set1Head|Set1Tail], Set2, [Set1Head|Result]):-
    union(Set1Tail, Set2, Result).

intersect([], _, []).
intersect([Set1Head|Set1Tail], Set2, [Set1Head|Result]) :-
    element(Set1Head, Set2), !, intersect(Set1Tail, Set2, Result).
intersect([_|Set1Tail], Set2, Result) :-
    intersect(Set1Tail, Set2, Result).

setMember(Head,[Head|_]).
setMember(Head,[_|Tail]) :-
    setMember(Head,Tail).

isSubset([],_).
isSubset([Set1Head|Set1Tail], Set2) :-
    element(Set1Head, Set2),
    isSubset(Set1Tail, Set2).

equivalent(Set1,Set2) :-
    isSubset(Set1,Set2),
    isSubset(Set2,Set1).
