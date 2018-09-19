edge(1, 2).
edge(1, 3).
edge(2, 4).
edge(2, 5).
edge(3, 6).
edge(3, 7).
edge(4, 8).
edge(4, 9).
edge(5, 10).
edge(5, 11).
edge(6, 12).
edge(6, 13).
edge(7, 14).
edge(7, 15).
goal(11).

solve(Start, Solution) :-
  breadthfirst([[Start]], Solution).

breadthfirst([[Node|Path]|_], [Node|Path]) :-
  goal(Node).

breadthfirst([Path|Paths], Solution) :-
  extend(Path, NewPaths),
  append(Paths, NewPaths, Paths1),
  breadthfirst(Paths1, Solution).

extend([Node|Path], NewPaths) :-
  findall([NewNode, Node|Path],
          (edge(Node, NewNode),
           not(member(NewNode,[Node|Path]))),
          NewPaths),
  !.
extend(Path,[]).