from pyswip import Prolog
prolog = Prolog()
prolog.consult("sudoku.pl")
prolog.assertz("problem(1, [[_,_,_, _,_,_, _,_,_], [_,_,_, _,_,3, _,8,5], [_,_,1, _,2,_, _,_,_],[_,_,_, 5,_,7, _,_,_],[_,_,4, _,_,_, 1,_,_],[_,9,_, _,_,_, _,_,_],[5,_,_, _,_,_, _,7,3],[_,_,2, _,1,_, _,_,_],[_,_,_, _,_,_, _,_,1]])")
sudoku_query = prolog.query("problem(1, Rows), sudoku(Rows), maplist(labeling([ff]), Rows).", maxresult=1)
for soln in sudoku_query:
    print(soln)
