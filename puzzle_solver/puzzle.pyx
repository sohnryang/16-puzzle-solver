"""
puzzle.py
=========

A module for manipulating the 16-puzzle

In this project, the 16-puzzle is represented as 64-bit int, to maximize the
efficiency. The 64 bits are splitted into 16 4-bit chunks, each representing a
square in the grid. This gives better performance than naive 2d-list approach,
since 64-bit int does not require much memory and copying.
"""

from random import choice

INITIAL_PUZZLE = 0
for i in range(1, 16):
    INITIAL_PUZZLE += i
    INITIAL_PUZZLE <<= 4

def int64_to_list(puzzle):
    """
    int64_to_list(puzzle) -- convert 64-bit puzzle representation to list

    Parameters
    ----------
    puzzle: int
        The puzzle represented in 64-bit int.
    """
    cdef unsigned long long puzzle_ctype = puzzle
    cdef int puzzle_list[16]
    cdef int i
    for i in range(16):
        puzzle_list[15 - i] = puzzle_ctype % (1 << 4)
        puzzle_ctype >>= 4
    return puzzle_list

def list_to_int64(puzzle_list):
    """
    list_to_int64(puzzle_list) -- convert list representation to 64-bit int

    Parameters
    ----------
    puzzle_list: list(int)
        The puzzle represented in list of ints.
    """
    puzzle = 0
    for square in puzzle_list:
        puzzle += square
        puzzle <<= 4
    puzzle >>= 4
    return puzzle

def randomize_puzzle(puzzle, moves=100):
    """
    randomize_puzzle(puzzle, moves=100) -- randomize the puzzle

    Parameters
    ----------
    puzzle: int
        The puzzle represented in 64-bit int.

    moves: int
        The number of shuffles to make. 100 by default.
    """
    current = puzzle
    for _ in range(moves):
        current = choice(next_moves(current))
    return current

def next_moves(puzzle):
    """
    next_moves(puzzle) -- get possible moves of the puzzle

    Parameters
    ----------
    puzzle: int
        The puzzle represented in 64-bit int.
    """
    puzzle_list = int64_to_list(puzzle)
    pos = puzzle_list.index(0)
    index_list = []
    available = []
    if pos > 3:
        index_list.append(pos - 4)
    if pos % 4 > 0:
        index_list.append(pos - 1)
    if pos % 4 < 3:
        index_list.append(pos + 1)
    if pos < 12:
        index_list.append(pos + 4)
    for index in index_list:
        newstate = puzzle_list.copy()
        newstate[pos], newstate[index] = newstate[index], newstate[pos]
        available.append(list_to_int64(newstate))
    return available
