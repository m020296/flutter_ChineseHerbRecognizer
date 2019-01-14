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
	writer.writerow(['engName','chiName','effect','taste','quality','shape'])

	base_url = 'http://libproject.hkbu.edu.hk/was40/detail?channelid=47953&lang=cht&searchword=pid=B00'
	for i in range(1,422):
		if(i<10):
			url = base_url + "00" + str(i)
		elif(i<100):
			url = base_url + "0" + str(i)
		else:
			url = base_url + str(i)
		driver.get(url)

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

		herb_record = engName +","+ chiName +","+ effect +","+ taste +","+ quality +","+ shape	
		print(str(i)+ " - "+herb_record)
		writer.writerow([engName,chiName,effect,taste,quality,shape])

driver.quit()