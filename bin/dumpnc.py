#!/usr/bin/python3

from netCDF4 import Dataset, date2index, num2date, date2num
import numpy as np
import argparse

parser = argparse.ArgumentParser(description='Dump netcdf file info.')
parser.add_argument('file', type=str, nargs='+', help='File name')
parser.add_argument('-v', '--variables', action='store_true')
parser.add_argument('-V', '--variable')

args = parser.parse_args()

for filename in args.file:
    ds = Dataset(filename)
    print(ds)

    if args.variables:
        print(ds.variables)

    if args.variable:
        print(ds.variables[args.variable][:])
