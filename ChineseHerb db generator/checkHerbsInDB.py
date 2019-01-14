import csv

herbs = []
targets = []
# herb_id	engName	chiName	effect	taste	quality	shape
with open('herbs.csv', newline='') as csvfile:
	rows = csv.DictReader(csvfile)
	for row in rows:
		herbs.append(row)

with open('herbs_unique.txt', newline='') as csvfile:
	rows = csv.reader(csvfile)
	for row in rows:
		targets.append(row)

with open('checked_herbs_unique.txt', 'w', newline='') as csvfile:
	writer = csv.writer(csvfile)
	writer.writerow(['herb_id','engName','chiName','effect','taste','quality','shape'])
	s = set(targets)
	i = 1
	for herb in herbs:
		if herb['chiName'] in s:
			if(i<10):
				herb_id = "000" + str(i)
			elif(i<100):
				herb_id = "00" + str(i)
			else:
				herb_id = "0" + str(i)
			writer.writerow([herb_id,herb['engName'],herb['chiName'],herb['effect'],herb['taste'],herb['quality'],herb['shape']])
			i+=1