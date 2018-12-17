from Tkinter import *
import tkMessageBox
from pyswip import Prolog
prolog = Prolog()
prolog.consult("sudoku.pl")
entries = []

def initialize(top,arr):
    E = entries[0]
    m=1
    for i in range(9):
        for j in range(9):
            if(not E.get()):
                arr[i][j] = 0
            else:
                arr[i][j] = int(E.get())
            if(m<=80):
                E = entries[m]
                m+=1


def print_maze(arr):
    clean_Mess()
    E = entries[0]
    m=1
    for i in range(9):
        for j in range(9):
            E.insert(1,arr[i][j])
            if(m<=80):
                E = entries[m]
                m+=1

def solve_sudoku(arr):
    prolog.query("reset")
    solver = "problem(1, " + str(arr).replace('0','_') + ")"
    prolog.assertz(solver)
    sudoku_query = prolog.query("problem(1, Rows), sudoku(Rows), maplist(labeling([ff]), Rows).", maxresult=1)
    for soln in sudoku_query:
        sol = soln['Rows']
    prolog.retract(solver)
    return sol

def createGUI(maze):
    top = Tk()
    top.title("Sudoku Solver")
    canvas = Canvas(top, height=320, width =350)
    createRow(canvas)
    createCol(canvas)
    createEntry(top)
    createButtons(top,maze)
    canvas.pack(side = 'top')
    top.mainloop()

def createButtons(top,maze):
    button_solve = Button(top, text="Solve", justify='left', default='active', command = lambda: play_Game(top,maze))
    button_reset = Button(top, text="reset", justify='right', command = lambda: clean_Mess())
    button_solve.place(x=70, y=275, height=30, width=60)
    button_reset.place(x=230, y=275, height=30, width=60)

def clean_Mess():
    for e in entries:
        e.delete(0, END)

def play_Game(top,maze):
    initialize(top,maze)
    sudoku_solution = solve_sudoku(maze)
    print_maze(sudoku_solution)

def createEntry(top):
    p,q=41.4,41.4
    for i in range(9):
        for j in range(9):
            E = Entry(top, width=3, font = 'BOLD')
            E.grid(row=i, column=j)
            E.place(x=p, y=q, height=20, width=25)
            entries.append(E)
            p+=30.0
        q+=24.5
        p=41.2

def createRow(canvas):
    i,j=40,40
    p=40
    q=260
    for m in range(10):
        if(m%3==0):
            canvas.create_line(i,j,p,q,width=2.5)
        else:
            canvas.create_line(i,j,p,q,width=2)
        i+=30
        p+=30

def createCol(canvas):
    i,j=40,40
    p,q=310,40
    for m in range(10):
        canvas.create_line(i,j,p,q,width=2.3)
        j+=24.5
        q+=24.5


if __name__=="__main__":

    maze=[[0 for x in range(9)]for y in range(9)]
    createGUI(maze)
