# imports

import numpy as np

# One Step Method

pointsTable = list[list[float], list[float]]

def oneStepMethod(
    y0: float, 
    t_start: float, 
    t_end: float, 
    n_steps: int,
    phi
    ) -> pointsTable:
    '''
    One Step Method numerical approximation for a discretization function Phi(t_k, y_k, dt)
    t_start and t_end are the extremes of the integration interval, (t_start, t_end)
    n_steps is the ammount of time steps
    Phi(t_k, y_k, dt) is the discretization function, whose inputs are the succesive approximations of the function
    we are approximating, for the k-th time interval, with time step dt.
    '''
    
    # Consistencies

    if type(y0) is not float: raise TypeError("The initial value y0 must be a float.")
    if type(t_start) is not float or type(t_end) is not float: raise TypeError("The extremes of the integration interval, t_start and t_end, must be floats.")
    if type(n_steps) is not int or n_steps <= 0: raise TypeError("The number of steps must be an positive integer.")
    if t_start >= t_end: raise ValueError("The start time must be smaller than the end time.")
    # TODO: Descobrir o type do phi -> é uma lista, um np.array?

    # Defining the time step
    dt = abs(t_end - t_start) / n_steps
    
    approximatedPoints = [[t_start], [y0]]

    t = t_start
    y = y0
    while t <= t_end:
        t += dt; approximatedPoints[0].append(t)
        y = y + dt * Phi(t, y, dt); approximatedPoints[1].append(y)

    return approximatedPoints