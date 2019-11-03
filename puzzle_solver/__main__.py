#!/usr/bin/env python3
"""__main__.py"""
from time import perf_counter
from puzzle_solver.puzzle import INITIAL_PUZZLE, randomize_puzzle
from puzzle_solver.solver import solve_puzzle_astar
from puzzle_solver.visualizer import animate
p = randomize_puzzle(INITIAL_PUZZLE, moves=100)
start = perf_counter()
hist, visited_count = solve_puzzle_astar(p)
end = perf_counter()
animate(hist)
print('Elapsed time: %f seconds' % (end - start))
print('Total moves: %d' % len(hist))
print('Visited states: %d' % visited_count)
