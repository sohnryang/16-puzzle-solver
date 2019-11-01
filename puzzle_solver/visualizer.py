"""
visualizer.py
=============

16-Puzzle visualizer for CLI
"""

from os import name, system
from time import sleep

def clear_console():
    """
    clear_console() -- clear the console
    """
    system('cls' if name == 'nt' else 'clear')

def visualize(history):
    """
    visualize(history) -- visualize puzzle solving history

    Parameters
    ----------
    history: list(int)
        history of grid, represented in a list of 64-bit ints.
    """
    for grid_data in history:
        grid_list = []
        for _ in range(16):
            grid_list.append(grid_data % (1 << 4))
            grid_data //= (1 << 4)
        grid_list.reverse()

        clear_console()
        for i, cell in enumerate(grid_list):
            print(cell, end='\n' if i % 4 == 3 else ' ')
        sleep(0.5)
