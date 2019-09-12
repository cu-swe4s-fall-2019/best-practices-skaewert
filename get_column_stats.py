import sys
import math
import os
import argparse


parser = argparse.ArgumentParser(prog='get_column_stats')
parser.add_argument('--file_name', type=str, help='Name of file', required=True)
parser.add_argument('--col_num', type=int, help='Column number', required=True)
args = parser.parse_args()


file_name = args.file_name
col_num = args.col_num


try:   # read file
    f = open(file_name, 'r')
except FileNotFoundError:
    print('File not found')
    sys.exit(1)

if os.stat('test_file.txt').st_size == 0:   # file is empty
    print('file is empty')
    sys.exit(1)


V = []

for l in f:
    A = [int(x) for x in l.split()]
    if col_num <= len(A) - 1:
        V.append(A[col_num])
    else:
        print('column number input is greater than number of columns')
        sys.exit(1)


mean = sum(V)/len(V)

stdev = math.sqrt(sum([(mean-x)**2 for x in V]) / len(V))

print('mean:', mean)
print('stdev:', stdev)
