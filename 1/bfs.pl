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

bfs(Goal, [Visited|Rest], Path) :-
    Visited = [Start|_],            
    Start \== Goal,
    findall(X,
        (edge(X,Start),not(member(X,Visited))),
        [T|Extend]),
    maplist(consed(Visited), [T|Extend], VisitedExtended),
    append(Rest, VisitedExtended, UpdatedQueue),
    bfs(Goal, UpdatedQueue, Path).

bfs(Goal, [[Goal|Visited]|_], Path):- reverse([Goal|Visited], Path).

breadth_first(Start, Goal, Path):- bfs( Goal, [[Start]], Path).