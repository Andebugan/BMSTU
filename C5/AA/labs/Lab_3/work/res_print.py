def print_latex(scale, res):
    for i in range(0, len(res)):
        print(str(scale[i]) + ' & ' + str(res[i]) + '\\\\')
    print()

scale = [100, 250, 500, 750, 1000, 1250, 1500, 1750, 2000, 2250, 2500]
res_1 = [0.0, 0.0, 0.015625, 0.03125, 0.03125, 0.046875, 0.078125, 0.09375, 0.140625, 0.171875, 0.234375]
res_2 = [0.0, 0.0, 0.046875, 0.09375, 0.15625, 0.28125, 0.390625, 0.515625, 0.703125, 0.796875, 1.03125]
res_3 = [0.0, 0.015625, 0.015625, 0.03125, 0.078125, 0.109375, 0.1875, 0.25, 0.28125, 0.359375, 0.4375]

res_arr = [res_1, res_2, res_3]

for res in res_arr: 
    print_latex(scale, res)