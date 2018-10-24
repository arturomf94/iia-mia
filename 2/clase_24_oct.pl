:- dynamic wm/1

:- op(900, xfx, if).
:- op(800, xfx, then).
:- op(700, xfy, and).

% EXAMPLE RULES

% rule1
% if a and b and c then d
%
% rule2
% if a and b then e


wm(a).
wm(b).
wm(c).
wm(d).
wm(e).

init :-
    assert(already_fired(null,false)),
    retract(already_fired(_, _)),
    assert(already_fired(null,false)), !.

run :-
    init,
    exec.

exec :-
    repeat,
    select_rule(R),
    fire(R), !.

select_rule(SelectedRule) :-
    findall(Rule, can_fire(Rule), Candidates),
    resolve(Candidates, SelectedRule).

can_fire(Rulename if Condition then Conclusion) :-
    Rulename if Condition then Conclusion,
    not(already_fired(Rulename, Condition)),
    satisfied(Condition).

satisfied(A and B) :-
    wm(A),
    satisfied(B).

satisfied(A) :- wm(A).

resolve([], []).
resolve([X|_], X).

fire(Rulename if Condition then Conclusion) :-
    !,
    assert(already_fired(Rulename, Condition)),
    add_town(Conclusion),
    fail.

fire(_).

add_to_wm(A and B) :-
    !,
    assert_if_not_present(A),
    add_to_wm(B).

add_to_wm(A) :-
    assert_if_not_present(A).

assert_if_not_present(A) :- wm(A), !.

assert_if_not_present(A) :-
    assert(wm(A)).
