import csv
import argparse
import pandas as pd
import numpy as np
import statistics
import scipy.stats as stats
from scipy.stats import skew
from scipy.stats import kurtosis
from datetime import datetime as dt


now = dt.now().strftime("%d-%m-%Y_%H.%M.%S")
outputFileName = "earthquakes_" + str(now) + "_with_timestamp_and_location_label.csv"

parser = argparse.ArgumentParser()
parser.add_argument("-i","--input", help="Paths of input file", default="../data/earthquakes_2021_05_05.csv")
parser.add_argument("-o","--output", help="Paths of output file", default=outputFileName)
args = parser.parse_args()

df = pd.read_csv(args.input)
df['datetime'] = pd.to_datetime(df['datetime'], format='%Y-%m-%d %H:%M:%S.%f')
df = df.sort_values(by='datetime')#, ascending=False

timestamp_row = []
timestamp2_row = []
location_labels = []

for index, row in df.iterrows():
    timestamp_row.append(row['datetime'].timestamp())
    timestamp2_row.append(round(row['datetime'].timestamp()/60))

    lat = row['lat']
    lon = row['lon']

    # LOCATION LABELS
    if lon < 30 and lon >= 26 and lat >= 40 and lat <= 42:
        location_labels.append(1)
    elif lon < 34 and lon >= 30 and lat >= 40 and lat <= 42:
        location_labels.append(2)
    elif lon < 38 and lon >= 34 and lat >= 40 and lat <= 42:
        location_labels.append(3)
    elif lon < 42 and lon >= 38 and lat >= 40 and lat <= 42:
        location_labels.append(4)
    elif lon <= 45 and lon >= 42 and lat >= 40 and lat <= 42:
        location_labels.append(5)
    elif lon < 30 and lon >= 26 and lat >= 38 and lat < 40:
        location_labels.append(6)
    elif lon < 34 and lon >= 30 and lat >= 38 and lat < 40:
        location_labels.append(7)
    elif lon < 38 and lon >= 34 and lat >= 38 and lat < 40:
        location_labels.append(8)
    elif lon < 42 and lon >= 38 and lat >= 38 and lat < 40:
        location_labels.append(9)
    elif lon <= 45 and lon >= 42 and lat >= 38 and lat < 40:
        location_labels.append(10)
    elif lon < 30 and lon >= 26 and lat >= 36 and lat < 38:
        location_labels.append(11)
    elif lon < 34 and lon >= 30 and lat >= 36 and lat < 38:
        location_labels.append(12)
    elif lon < 38 and lon >= 34 and lat >= 36 and lat < 38:
        location_labels.append(13)
    elif lon < 42 and lon >= 38 and lat >= 36 and lat < 38:
        location_labels.append(14)
    elif lon <= 45 and lon >= 42 and lat >= 36 and lat < 38:
        location_labels.append(15)
    else:
        location_labels.append(-1)

df['timestamp'] = timestamp_row
df['location_label'] = location_labels
df['timestamp2'] = timestamp2_row

df.to_csv(outputFileName, index=False)