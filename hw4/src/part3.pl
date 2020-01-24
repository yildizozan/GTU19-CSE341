class(102, 10, z23).
class(108, 12, z11).
class(341, 14, z06).
class(455, 16, 207).
class(452, 17, 207).

enrollment(a, 102).
enrollment(a, 108).
enrollment(b, 102).
enrollment(c, 108).
enrollment(d, 341).
enrollment(e, 455).

when(102, 10).
when(108, 12).
when(341, 14).
when(455, 16).
when(452, 17).

where(102, z23).
where(108, z11).
where(341, z06).
where(455, 207).
where(452, 207).

schedule(a, Class, Time) :-
    enrollment(a, Class),
    when(Class, Time).

usage(Room, Time) :-
    class(_, Time, Room).

% Same class
conflict(Class1, Class2) :-
    (when(Class1, Time), when(Class2, Time));
    (where(Class1, Room), where(Class2, Room)).

meet(Student1, Student2) :-
    enrollment(Student1, Class),
	enrollment(Student2, Class).