# import requests
# import lxml.html as lh

# page = requests.get('http://libproject.hkbu.edu.hk/was40/detail?channelid=47953&lang=cht&searchword=pid=B00001')
# doc = lh.fromstring(page.text)
# tr_elements = doc.xpath('//tr')
# print(tr_elements)
# for t in tr_elements:
# 	tmp1=t.find('td')
# 	print(str(tmp1.text).strip())


from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from bs4 import BeautifulSoup
import csv

chrome_options = Options()
chrome_options.add_argument('--headless')
chrome_options.add_argument('--disable-gpu')
driver = webdriver.Chrome(chrome_options=chrome_options)

with open('herbs.csv', 'w', newline='') as csvfile:
	writer = csv.writer(csvfile)
	writer.writerow(['herb_id','engName','chiName','effect','taste','quality','shape'])

	base_url = 'http://libproject.hkbu.edu.hk/was40/detail?channelid=47953&lang=cht&searchword=pid=B00'
	for i in range(1,422):
		if(i<10):
			herb_id = "00" + str(i)
		elif(i<100):
			herb_id = "0" + str(i)
		else:
			herb_id = str(i)
		driver.get(base_url+herb_id)

		soup=BeautifulSoup(driver.page_source, 'lxml')
		for tr in soup.find_all('tr'):
			td0 = tr.find('td')
			if(len(td0.contents)>0):
				tmp_header = str(td0.contents[-1]).strip()
				header = tmp_header[1:-1]
				if(header=="名稱"):
					td1 = tr.find_all('td')[1]
					chiName = str(td1.contents[-1]).strip()
				elif(header=="英文"):
					td1 = tr.find_all('td')[1]
					engName = str(td1.contents[-1]).strip()
				elif(header=="性狀"):
					td1 = tr.find_all('td')[1]
					shape = str(td1.contents[-1]).strip()
				elif(header=="品質"):
					td1 = tr.find_all('td')[1]
					quality = str(td1.contents[-1]).strip()
				elif(header=="性味"):
					td1 = tr.find_all('td')[1]
					taste = str(td1.contents[-1]).strip()
				elif(header=="功效"):
					td1 = tr.find_all('td')[1]
					effect = str(td1.contents[-1]).strip()
		print_herb_id = '0'+ herb_id
		herb_record = print_herb_id +","+ engName +","+ chiName +","+ effect +","+ taste +","+ quality +","+ shape	
		print(herb_record)
		writer.writerow([print_herb_id,
			engName.encode("utf8").decode("cp950", "ignore"),
			chiName.encode("utf8").decode("cp950", "ignore"),
			effect.encode("utf8").decode("cp950", "ignore"),
			taste.encode("utf8").decode("cp950", "ignore"),
			quality.encode("utf8").decode("cp950", "ignore"),
			shape.encode("utf8").decode("cp950", "ignore")])

driver.quit()