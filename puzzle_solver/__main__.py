#!/usr/bin/env python3
"""__main__.py"""
from puzzle_solver.puzzle import list_to_int64, INITIAL_PUZZLE, randomize_puzzle
from puzzle_solver.solver import solve_puzzle_astar
from puzzle_solver.visualizer import animate
p = randomize_puzzle(INITIAL_PUZZLE, moves=100)
hist = solve_puzzle_astar(p)
animate(hist)
print('Total moves: %d' % len(hist))
