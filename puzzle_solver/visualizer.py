"""
visualizer.py
=============

16-Puzzle visualizer for CLI
"""

from os import name, system

def visualize(grid):
    """
    visualize(grid) -- visualize puzzle grid

    Parameters
    ----------
    grid: list[list] -- the 4-by-4 grid to be visualized
    """
    system('cls' if name == 'nt' else 'clear')
    for i, cell in enumerate(grid):
        print(cell, end=' ')
        if i % 4 == 3:
            print()
