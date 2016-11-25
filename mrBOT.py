import os, time
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup

def sendQuery(query, browser):
	queryElement = browser.find_element_by_id("reset-button").click()
	queryElement = browser.find_element_by_id("query-text")
	queryElement.send_keys(query)
	queryElement.send_keys(Keys.RETURN);


def main():

	queries = ["What rivers are in Portugal?","What rivers are in France?", "What rivers are in the world?", "What cities are in Spain?", "What cities are in Brazil?",
			"What cities are in the world?","What countries are in Northern Europe?","What countries are in South America?","What countries are in the world?","Where is the largest city?",
			"Where is the largest country?", "What country's capital is Lisbon?","What country's capital is Brasilia?", "Is there some ocean that does not border any country?",
			"What are the continents which contain more than 2 cities whose population exceeds 1 million?","What are the continents which contain more than 4 cities whose population exceeds 1 million?",
			"Which country bordering the mediterranean borders a country that is bordered by a country whose population exceeds the population of Russia?" ]

	chromedriver = "./chromedriver"
	browser = webdriver.Chrome(chromedriver)

	# testing on real server - Working
	#browser.get("http://gflcampos.noip.me:3000/server/index.html")

	# testing on localhost
	browser.get("http://localhost:3000/server/index.html")


	os.system('clear')
	print "[+] Success, the Bot started to query the page for you!"

	for query in queries:
		sendQuery(query, browser)
		time.sleep(3) #escolher o tempo de espera entre queries		

	queryElement = browser.find_element_by_id("reset-button").click()
	queryElement = browser.find_element_by_id("query-text")
	queryElement.send_keys("Goodbye :D")
	time.sleep(2)
	
	browser.close()


if __name__ == '__main__':
	main()