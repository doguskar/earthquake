import csv
import argparse

from datetime import datetime as dt


now = dt.now().strftime("%d-%m-%Y_%H.%M.%S")
outputFileName = "Result_" + str(now) + ".csv"

parser = argparse.ArgumentParser()
parser.add_argument("-i","--input", help="Paths of input file", default="20200831_20210404_3.0_9.0_56_7672.csv")
parser.add_argument("-o","--output", help="Paths of output file", default=outputFileName)
args = parser.parse_args()

with open(args.input, mode='r', encoding='utf8') as file:
    reader = csv.DictReader(file)
    
    with open(args.output, 'w', newline='') as newFile:
        fieldnames = ['datetime', "lat", "lon", "depth", "magnitude"]
        writer = csv.DictWriter(newFile, fieldnames=fieldnames)

        writer.writeheader()
        for row in reader:
            #no,deprem_kodu,olus_tarihi,olus_zamani,enlem,boylam,Der,xM,MD,ML,Mw,Ms,Mb,Tip,Yer
            datetime = row["olus_tarihi"] + " " + row["olus_zamani"]
            magnitude = row["Mw"]
            if magnitude == '0.0':
                print(magnitude)
            if not magnitude or magnitude == '0.0':
                magnitude = row["xM"]
            elif not magnitude or magnitude == '0.0':
                magnitude = row["MD"]
            elif not magnitude or magnitude == '0.0':
                magnitude = row["ML"]
            elif not magnitude or magnitude == '0.0':
                magnitude = row["Ms"]
            elif not magnitude or magnitude == '0.0':
                magnitude = row["Mb"]

            
            writer.writerow({
                'datetime': datetime,
                'lat': row["enlem"],
                'lon': row["boylam"],
                'depth': row["Der"],
                'magnitude': magnitude,
                })
            
