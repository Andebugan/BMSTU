from tkinter.messagebox import YES
from algos import *
from typing import Callable
from numpy import e
from math import isnan
from cmath import exp, inf, nan
import seaborn as sns
import matplotlib.pyplot as plt
from prettytable import PrettyTable
import prettytable

user_input = -1
while user_input != 0:
    xi = 0.01
    xi_step = 0.001
    psi_last = None
    h = 0.01
    z_0 = 0
    f_0 = 0
    z_max = 1
    
    user_input = int(input('Выберите действие:\nВыйти (0)\nРассчитать значения (1)\n> '))
    if user_input == 0:
        break
    if user_input == 1:
        user_input = input('Изменить значения параметров? (y/n)\n> ')
        if user_input == 'y':
            print('Текущие значения:')
            print('xi: ' + str(xi))
            print('Шаг xi: ' + str(xi_step))
            print('h: ' + str(h))
            print('z_0: ' + str(z_0))
            print('z_max: ' + str(z_max))
            print('F_0: ' + str(f_0))
            new_params = input(\
                'Введите новые значения через пробел, если не меняется, то "-" \n[xi, xi_step, h, z_0, z_max, F_0]\n> ').split()
            if new_params[0] != '-':
                xi = float(new_params[0])
            if new_params[1] != '-':
                xi_step = float(new_params[1])
            if new_params[2] != '-':
                h = float(new_params[2])
            if new_params[3] != '-':
                z_0 = float(new_params[3])
            if new_params[4] != '-':
                z_max = float(new_params[4])
            if new_params[5] != '-':
                f_0 = float(new_params[5])
    

    #xi_arr = []
    #psi_arr = []

    while xi <= 1:
        z_res, u_res, f_res = runge_kutt_4(h, z_0, f_0, xi * u_p(z_0), 1, F_z, u_z)
        if psi_last == None:
            psi_last = f_res[-1] - m * c * u_res[-1] / 2
        else:
            if psi_last > 0 and f_res[-1] - m * c * u_res[-1] / 2 < 0 or psi_last < 0 and f_res[-1] - m * c * u_res[-1] / 2 > 0:
                break
            #xi_arr.append(xi)
            #psi_arr.append(f_res[-1] - m * c * u_res[-1] / 2)
            psi_last = f_res[-1] - m * c * u_res[-1] / 2
        xi += xi_step

    eps = 1e-4
    xi_1 = xi - xi_step
    xi_2 = xi
    xi_true = (xi_1 + xi_2)/2
    while abs(xi_1 - xi_2)/xi_true > eps:
        _, u_res_1, f_res_1 = runge_kutt_4(h, z_0, f_0, xi_1 * u_p(z_0), 1, F_z, u_z)
        _, u_res_t, f_res_t = runge_kutt_4(h, z_0, f_0, xi_true * u_p(z_0), 1, F_z, u_z)
        _, u_res_2, f_res_2 = runge_kutt_4(h, z_0, f_0, xi_2 * u_p(z_0), 1, F_z, u_z)

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

    z_res, u_res, f_res = runge_kutt_4(h, z_0, f_0, xi_true * u_p(z_0), 1, F_z, u_z)
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

    fig, axs = plt.subplots(nrows=2, ncols=2)
    sns.lineplot(x=z_res + z_res, y=u_p_res + u_res, hue=['u_p(z)'] * len(u_p_res) + ['u(z)'] * len(u_res), ax=axs[0][0])
    sns.lineplot(x=z_res, y=u_p_res, hue=['u_p(z)'] * len(u_p_res), ax=axs[0][1])
    sns.lineplot(x=z_res, y=u_res, hue=['u(z)'] * len(u_res), ax=axs[1][0])
    sns.lineplot(x=z_res, y=f_res, hue=['F(z)'] * len(f_res), ax=axs[1][1])
    plt.show()