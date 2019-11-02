"""
solver.py
=========

A module for solving 16-puzzle using graph search algorithms.
"""

from collections import deque
from puzzle_solver.puzzle import INITIAL_PUZZLE, next_moves

def solve_puzzle_bfs(puzzle):
    """
    solve_puzzle_bfs(puzzle) -- solve the puzzle with BFS

    Parameters
    ----------
    puzzle: int
        The initial state of the puzzle, represented in 64-bit int.
    """
    if puzzle == INITIAL_PUZZLE:
        return [puzzle]

    cost = dict()
    parent = dict()
    visit_queue = deque()
    visit_queue.append(puzzle)
    cost[puzzle] = 0
    parent[puzzle] = puzzle
    while visit_queue:
        here = visit_queue.popleft()
        current_cost = cost[here]
        next_states = next_moves(here)
        solved = False
        for next_state in next_states:
            if next_state not in cost:
                parent[next_state] = here
                cost[next_state] = current_cost + 1
                if next_state == INITIAL_PUZZLE:
                    solved = True
                    break
                visit_queue.append(next_state)
        if solved:
            break

    if INITIAL_PUZZLE not in cost:
        return None
    history = []
    here = INITIAL_PUZZLE
    while parent[here] != here:
        history.append(here)
        here = parent[here]
    history.append(here)
    history.reverse()
    return history
