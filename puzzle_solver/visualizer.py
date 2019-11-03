"""
visualizer.py
=============

16-Puzzle visualizer for CLI
"""

from colorama import init, Fore, Style
from os import name, system
from time import sleep
from puzzle_solver.puzzle import int64_to_list

init()

def print_puzzle(puzzle):
    """
    print_puzzle(puzzle) -- print the puzzle

    Parameters
    ----------
    puzzle: int
        The puzzle represented in 64-bit int.
    """
    puzzle_list = int64_to_list(puzzle)
    for i, square in enumerate(puzzle_list):
        print('%-2d' % square, end='\n' if i % 4 == 3 else ' ')

def clear_console():
    """
    clear_console() -- clear the console
    """
    system('cls' if name == 'nt' else 'clear')

def animate(history, refresh_interval=0.5):
    """
    animate(history) -- visualize puzzle solving history by giving an animation

    Parameters
    ----------
    history: list(int)
        The history of grid, represented in a list of 64-bit ints.

    refresh_interval: float
        Time to delay between prints. 0.5 by default.
    """
    for puzzle_state in history:
        clear_console()
        print(Fore.GREEN, end='')
        print_puzzle(puzzle_state)
        sleep(refresh_interval)
    print(Style.RESET_ALL)
