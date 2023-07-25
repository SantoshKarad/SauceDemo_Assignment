from selenium import webdriver
from variables.settings import BASE_URL, BROWSER


class BasePage:
    driver = None

    def __init__(self):
        if BasePage.driver is None:
            if BROWSER.lower() == "chrome":
                BasePage.driver = webdriver.Chrome()
            elif BROWSER.lower() == "edge":
                BasePage.driver = webdriver.Edge()
            else:
                raise Exception(f'Browser "{BROWSER}" is not supported')

        self.driver = BasePage.driver

    def navigate(self):
        self.driver.get(BASE_URL)

    def close(self):
        self.driver.quit()
