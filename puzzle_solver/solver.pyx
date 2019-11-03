"""
solver.py
=========

A module for solving 16-puzzle using graph search algorithms.
"""

from collections import deque
from colorama import Fore, Style
from heapq import heapify, heappush, heappop
from math import inf
from puzzle_solver.puzzle import (
    INITIAL_PUZZLE,
    next_moves,
    int64_to_list,
)
from puzzle_solver.visualizer import print_puzzle, clear_console

def reconstruct_path(tree, finish):
    """
    reconstruct_path(tree) -- reconstruct path from BFS spanning tree

    Parameters
    ----------
    parent: dict(int, int)
        The dict containing parent-child relationship of the points.

    finish: int
        The finishing point of the path.
    """
    path = []
    here = finish
    while tree[here] != here:
        path.append(here)
        here = tree[here]
    path.append(here)
    path.reverse()
    return path

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
    return reconstruct_path(parent, INITIAL_PUZZLE)

def solve_puzzle_astar(puzzle):
    """
    solve_puzzle_astar(puzzle) -- solve the puzzle with A* algorithm

    Parameters
    ----------
    puzzle: int
        The initial state of the puzzle, represented in 64-bit int.
    """
    def heuristic(puzzle):
        cdef unsigned long long puzzle_ctype = puzzle
        cdef int result = 0
        cdef int i
        cdef int squares[16]
        squares = int64_to_list(puzzle_ctype)
        for i in range(16):
            square = squares[i]
            if square != 0:
                current_pos = (i % 4, i // 4)
                correct_pos = ((square - 1) % 4, (square - 1) // 4)
                result += abs(current_pos[0] - correct_pos[0])
                result += abs(current_pos[1] - correct_pos[1])
        return result

    if puzzle == INITIAL_PUZZLE:
        return [puzzle]

    cost = dict()
    h_value = dict()
    parent = dict()
    cost[puzzle] = 0
    h_value[puzzle] = heuristic(puzzle)
    visit_queue = [(cost[puzzle] + h_value[puzzle], puzzle)]
    parent[puzzle] = puzzle
    visit_count = 0
    while visit_queue:
        visit_count += 1
        _, here = heappop(visit_queue)
        clear_console()
        print(Fore.CYAN)
        print_puzzle(here)
        print(Style.RESET_ALL)
        current_cost = cost[here]
        next_states = next_moves(here)
        for next_state in next_states:
            if next_state not in cost:
                print_puzzle(next_state)
                parent[next_state] = here
                cost[next_state] = current_cost + 1
                h_value[next_state] = heuristic(next_state)
                if next_state == INITIAL_PUZZLE:
                    return reconstruct_path(parent, INITIAL_PUZZLE)
                heappush(visit_queue, (cost[next_state] + h_value[next_state],
                                       next_state))

    return None
