from prettytable import PrettyTable
import prettytable

def print_table(cols: list, rows: list[list]) -> None:
    table = PrettyTable(cols)
    for row in rows:
        table.add_row(row)
    print(table)

if __name__ == '__main__':
    a = [1, 2]
    b = [[1, 2], [3, 4], [5, 6]]
    print_table(a, b)