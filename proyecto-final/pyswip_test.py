from pyswip import Prolog
prolog = Prolog()
prolog.consult("sudoku.pl")
sudoky_query = prolog.query("problem(1, Rows), sudoku(Rows), maplist(portray_clause, Rows).")
for soln in sudoky_query:
    print(soln)
