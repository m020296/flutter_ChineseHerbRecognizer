import csv

herbs = []
targets = []
# herb_id	engName	chiName	effect	taste	quality	shape
with open('herbs.csv', newline='') as csvfile:
	herbs = csv.DictReader(csvfile)

with open('herbs_unique.txt', newline='') as csvfile:
	targets = csv.reader(csvfile)

with open('checked_herbs_unique.txt', 'w', newline='') as csvfile:
	writer = csv.writer(csvfile)
	s = set(targets)
	for herb in herbs:
		if herb['chiName'] in s:
			writer.writerow(herb)