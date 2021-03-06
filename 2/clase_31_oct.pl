:- dynamic wm/1.

:- op(900, xfx, si).
:- op(800, xfx, entonces).
:- op(700, xfy, yy).

rule1
si orden_nariztubular yy vive_enel_mar yy pico_gancho entonces familia_albatros.

rule2
si familia_albatross yy es_blanco entonces albatros_de_laysan.

rule3
si familia_albatros yy es_negro entonces albatros_patas_negras.

rule4
si orden_acuatico yy cuello_largo yy es_blanco yy vuelo_poderoso entonces familia_cisne.

rule5
si familia_cisne yy granizado_fuerte entonces cisne_trumpetero.

wm(orden_nariztubular).
wm(vive_enel_mar).
wm(pico_gancho).
wm(es_negro).

init :-
    assert(already_fired(null, false)),
    retract(already_fired(_,_)),
    assert(already_fired(null, false)).

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

can_fire(RuleName si Condition entonces Conclusion) :-
    RuleName si Condition entonces Conclusion, % Loop up rule in data base.
    not(already_fired(RuleName, Condition)),
    satisfied(Condition).

satisfied(A yy B) :- !, wm(A), satisfied(B).
satisfied(A) :- wm(A).

resolve([], []).
resolve([X|_], X).

fire(RuleName si Condition entonces Conclusion) :- !,
    assert(already_fired(RuleName, Condition)),
    add_to_wm(Conclusion),
    fail.
fire(_).

add_to_wm(A yy B) :- !,
    assert_if_not_present(A),
    add_to_wm(B).

add_to_wm(A) :- assert_if_not_present(A).

assert_if_not_present(A) :- wm(A), !.
assert_if_not_present(A) :- assert(wm(A)).
