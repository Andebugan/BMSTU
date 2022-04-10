from typing import Callable
from numpy import e
from math import isnan
from cmath import exp, inf, nan
import seaborn as sns
import matplotlib.pyplot as plt
from prettytable import PrettyTable
import prettytable

c = 3e+10
k_0 = 0.0008
m = 0.786
R = 0.35 #m
T_w = 2000 #K
T_0 = 10000 #K
p = 4 # от 4 до 15

def T(Z: float) -> float:
    return (T_w - T_0) * ((Z)**p) + T_0

def k(Z: float) -> float:
    return k_0 * ((T(Z)/300)**2)

def u_p(Z: float):
    return (3.084e-4)/(e**(4.799e+4/T(Z)) - 1)

def F_z(Z: float, F: float, u: float) -> float: # F_z(u)
    if Z == 0:
        return ((c * R)/2) * k(Z) * (u_p(Z) - u)
    else:
        return c * R * k(Z) * (u_p(Z) - u) - (F / Z)

def u_z(Z: float, F: float): # u_z(F)
    return -(3 * R * F * k(Z)) / c

def runge_kutt_4(h_0: float, z_0: float, f_0: float, u_0: float, z_max: float, F: Callable, Phi: Callable):
    z_n = z_0
    h = h_0

    u_n = u_0
    f_n = f_0

    z_res = [z_0]
    u_res = [u_0]
    f_res = [f_0]

    while z_n < z_max:
        q_1 = h * Phi(z_n, f_n)
        k_1 = h * F(z_n, f_n, u_n)

        q_2 = h * Phi(z_n + h / 2, f_n + k_1 / 2)
        k_2 = h * F(z_n + h / 2, f_n + k_1 / 2, u_n + q_1 / 2)

        q_3 = h * Phi(z_n + h / 2, f_n + k_2 / 2)
        k_3 = h * F(z_n + h / 2, f_n + k_2 / 2, u_n + q_2 / 2)

        q_4 = h * Phi(z_n + h, f_n + k_3)
        k_4 = h * F(z_n + h, f_n + k_3, u_n + q_3)

        u_n = u_n + (q_1 + 2 * q_2 + 2 * q_3 + q_4) / 6
        f_n = f_n + (k_1 + 2 * k_2 + 2 * k_3 + k_4) / 6
        z_n += h

        z_res.append(z_n)
        u_res.append(u_n)
        f_res.append(f_n)
    return z_res, u_res, f_res

if __name__ == '__main__':
    xi = 0.001
    xi_step = 0.001
    psi_last = None
    h = 0.01
    z_0 = 0
    f_0 = 0
    
    #xi_arr = []
    #psi_arr = []

    while xi <= 1:
        z_res, u_res, f_res = runge_kutt_4(h, z_0, f_0, xi * u_p(0), 1, F_z, u_z)
        if psi_last == None:
            psi_last = f_res[-1] - m * c * u_res[-1] / 2
        else:
            if psi_last > 0 and f_res[-1] - m * c * u_res[-1] / 2 < 0 or psi_last < 0 and f_res[-1] - m * c * u_res[-1] / 2 > 0:
                break
            #xi_arr.append(xi)
            #psi_arr.append(f_res[-1] - m * c * u_res[-1] / 2)
            psi_last = f_res[-1] - m * c * u_res[-1] / 2
        xi += xi_step

    eps = 1e-5
    xi_1 = xi - xi_step
    xi_2 = xi
    xi_true = (xi_1 + xi_2)/2
    while abs(xi_1 - xi_2)/xi_true > eps:
        _, u_res_1, f_res_1 = runge_kutt_4(h, z_0, f_0, xi_1 * u_p(0), 1, F_z, u_z)
        _, u_res_t, f_res_t = runge_kutt_4(h, z_0, f_0, xi_true * u_p(0), 1, F_z, u_z)
        _, u_res_2, f_res_2 = runge_kutt_4(h, z_0, f_0, xi_2 * u_p(0), 1, F_z, u_z)

        psi_1 = f_res_1[-1] - m * c * u_res_1[-1] / 2
        psi_t = f_res_t[-1] - m * c * u_res_t[-1] / 2
        psi_2 = f_res_2[-1] - m * c * u_res_2[-1] / 2

        if psi_1 > 0 and psi_t < 0:
            xi_2 = xi_true
        elif psi_t > 0 and psi_2 < 0:
            xi_1 = xi_true
        elif psi_1 < 0 and psi_t > 0:
            xi_2 = xi_true
        elif psi_t < 0 and psi_2 > 0:
            xi_1 = xi_true

        xi_true = (xi_1 + xi_2)/2
    
    z_res, u_res, f_res = runge_kutt_4(h, z_0, f_0, xi_true * u_p(0), 1, F_z, u_z)
    u_p_res = []
    for z in z_res:
        u_p_res.append(u_p(z))
    
    algos = []

    cols = ['z', 'u_p', 'u', 'F']
    table = PrettyTable(cols)
    for z, u_p_r, u_r, f_r in zip(z_res, u_p_res, u_res, f_res):
        table.add_row([z, u_p_r, u_r, f_r])

    print('h: ' + str(h))
    print('xi step: ' + str(xi_step))
    print('xi: ' + str(xi_true))
    print(table)
    #sns.lineplot(x=xi_arr, y=psi_arr)
    #plt.show()

    with open('result.txt', 'w') as f:
        f.write('h: ' + str(h) + '\n')
        f.write('xi step: ' + str(xi_step) + '\n')
        f.write('xi: ' + str(xi_true) + '\n')
        f.write(str(table))

    fig, axs = plt.subplots(ncols=4)
    sns.lineplot(x=z_res + z_res, y=u_p_res + u_res, hue=['u_p(z)'] * len(u_p_res) + ['u(z)'] * len(u_res), ax=axs[0])
    sns.lineplot(x=z_res, y=u_p_res, hue=['u_p(z)'] * len(u_p_res), ax=axs[1])
    sns.lineplot(x=z_res, y=u_res, hue=['u(z)'] * len(u_res), ax=axs[2])
    sns.lineplot(x=z_res, y=f_res, hue=['F(z)'] * len(f_res), ax=axs[3])
    plt.show()