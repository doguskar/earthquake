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
outputFileName = "extended_earthquake_" + str(now) + ".csv"

parser = argparse.ArgumentParser()
parser.add_argument("-i","--input", help="Paths of input file", default="earthquake_6_2021_04_05.csv")
parser.add_argument("-o","--output", help="Paths of output file", default=outputFileName)
parser.add_argument("-b","--backward", help="backward size", default=30)
args = parser.parse_args()


df = pd.read_csv(args.input)
df['datetime'] = pd.to_datetime(df['datetime'], format='%Y-%m-%d %H:%M:%S.%f')
df = df.sort_values(by='datetime')#, ascending=False

# MAGNITUDE FEATURES
min_magnitude = []
max_magnitude = []
mean_magnitude = []
median_magnitude = []
variance_magnitude = []
skew_magnitude = []
kurtosis_magnitude = []

# DEPTH FEATURES
min_depth = []
max_depth = []
mean_depth = []
median_depth = []
variance_depth = []
skew_depth = []
kurtosis_depth = []

# LATITUDE FEATURES
min_lat = []
max_lat = []
mean_lat = []
median_lat = []
variance_lat = []
skew_lat = []
kurtosis_lat = []

# LONGITUDE FEATURES
min_lon = []
max_lon = []
mean_lon = []
median_lon = []
variance_lon = []
skew_lon = []
kurtosis_lon = []

# DATETIME FEATURES
min_datetime = []
max_datetime = []
mean_datetime = []
median_datetime = []
variance_datetime = []
skew_datetime = []
kurtosis_datetime = []

current_part_magnitude = []
current_part_depth = []
current_part_lat = []
current_part_lon = []
current_part_datetime = []
size = 0
for index, row in df.iterrows():
    if  size >= args.backward:
        # MAGNITUDE FEATURES
        min_magnitude.append(min(current_part_magnitude))
        max_magnitude.append(max(current_part_magnitude))
        mean_magnitude.append(np.mean(current_part_magnitude))
        median_magnitude.append(np.median(current_part_magnitude))
        variance_magnitude.append(statistics.pvariance(current_part_magnitude))
        skew_magnitude.append(skew(current_part_magnitude))
        kurtosis_magnitude.append(kurtosis(current_part_magnitude))
        
        # DEPTH FEATURES
        min_depth.append(min(current_part_depth))
        max_depth.append(max(current_part_depth))
        mean_depth.append(np.mean(current_part_depth))
        median_depth.append(np.median(current_part_depth))
        variance_depth.append(statistics.pvariance(current_part_depth))
        skew_depth.append(skew(current_part_depth))
        kurtosis_depth.append(kurtosis(current_part_depth))
        
        # LATITUDE FEATURES
        min_lat.append(min(current_part_lat))
        max_lat.append(max(current_part_lat))
        mean_lat.append(np.mean(current_part_lat))
        median_lat.append(np.median(current_part_lat))
        variance_lat.append(statistics.pvariance(current_part_lat))
        skew_lat.append(skew(current_part_lat))
        kurtosis_lat.append(kurtosis(current_part_lat))
        
        # LONGITUDE FEATURES
        min_lon.append(min(current_part_lon))
        max_lon.append(max(current_part_lon))
        mean_lon.append(np.mean(current_part_lon))
        median_lon.append(np.median(current_part_lon))
        variance_lon.append(statistics.pvariance(current_part_lon))
        skew_lon.append(skew(current_part_lon))
        kurtosis_lon.append(kurtosis(current_part_lon))
        
        # DATETIME FEATURES
        min_datetime.append(min(current_part_datetime))
        max_datetime.append(max(current_part_datetime))
        mean_datetime.append(np.mean(current_part_datetime))
        median_datetime.append(np.median(current_part_datetime))
        variance_datetime.append(statistics.pvariance(current_part_datetime))
        skew_datetime.append(skew(current_part_datetime))
        kurtosis_datetime.append(kurtosis(current_part_datetime))
        
        current_part_magnitude.pop(0)
        current_part_depth.pop(0)
        current_part_lat.pop(0)
        current_part_lon.pop(0)
        current_part_datetime.pop(0)
        
    else:
        # MAGNITUDE FEATURES
        min_magnitude.append(None)
        max_magnitude.append(None)
        mean_magnitude.append(None)
        median_magnitude.append(None)
        variance_magnitude.append(None)
        skew_magnitude.append(None)
        kurtosis_magnitude.append(None)

        # DEPTH FEATURES
        min_depth.append(None)
        max_depth.append(None)
        mean_depth.append(None)
        median_depth.append(None)
        variance_depth.append(None)
        skew_depth.append(None)
        kurtosis_depth.append(None)

        # LATITUDE FEATURES
        min_lat.append(None)
        max_lat.append(None)
        mean_lat.append(None)
        median_lat.append(None)
        variance_lat.append(None)
        skew_lat.append(None)
        kurtosis_lat.append(None)

        # LONGITUDE FEATURES
        min_lon.append(None)
        max_lon.append(None)
        mean_lon.append(None)
        median_lon.append(None)
        variance_lon.append(None)
        skew_lon.append(None)
        kurtosis_lon.append(None)

        # DATETIME FEATURES
        min_datetime.append(None)
        max_datetime.append(None)
        mean_datetime.append(None)
        median_datetime.append(None)
        variance_datetime.append(None)
        skew_datetime.append(None)
        kurtosis_datetime.append(None)
    
    current_part_magnitude.append(row['magnitude'])
    current_part_depth.append(row['depth'])
    current_part_lat.append(row['lat'])
    current_part_lon.append(row['lon'])
    current_part_datetime.append(row['datetime'].timestamp())
    size += 1



df['min_magnitude'] = min_magnitude
df['max_magnitude'] = max_magnitude
df['mean_magnitude'] = mean_magnitude
df['median_magnitude'] = median_magnitude
df['variance_magnitude'] = variance_magnitude
df['kurtosis_magnitude'] = kurtosis_magnitude

df['min_depth'] = min_depth
df['max_depth'] = max_depth
df['mean_depth'] = mean_depth
df['median_depth'] = median_depth
df['variance_depth'] = variance_depth
df['kurtosis_depth'] = kurtosis_depth

df['min_lat'] = min_lat
df['max_lat'] = max_lat
df['mean_lat'] = mean_lat
df['median_lat'] = median_lat
df['variance_lat'] = variance_lat
df['kurtosis_lat'] = kurtosis_lat

df['min_lon'] = min_lon
df['max_lon'] = max_lon
df['mean_lon'] = mean_lon
df['median_lon'] = median_lon
df['variance_lon'] = variance_lon
df['kurtosis_lon'] = kurtosis_lon

df['min_datetime'] = min_datetime
df['max_datetime'] = max_datetime
df['mean_datetime'] = mean_datetime
df['median_datetime'] = median_datetime
df['variance_datetime'] = variance_datetime
df['kurtosis_datetime'] = kurtosis_datetime

df.to_csv(outputFileName, index=False)