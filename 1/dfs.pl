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

path(Start, X) :- dfs([], Start, X).

dfs(Path, Start, [Start|Path]) :- goal(Start).

dfs(Path, Start, Solution) :-
    edge(Start, Node),
    not(member(Node, Path)),
    dfs([Start|Path], Node, Solution).
