from BasePage import BasePage
from selenium.webdriver.common.by import By
import variables.locators as loc


class LoginPage(BasePage):

    def __init__(self):
        self.username_locator = (By.XPATH, loc.username_locator)
        self.password_locator = (By.XPATH, loc.password_locator)
        self.login_button_locator = (By.XPATH, loc.login_button_locator)
        self.logout_link_locator = (By.XPATH, loc.logout_link_locator)
        self.open_menu_button_locator = (By.XPATH, loc.open_menu_button_locator)

    def enter_username(self, username):
        username_field = self.driver.find_element(*self.username_locator)
        username_field.clear()
        username_field.send_keys(username)

    def enter_password(self, password):
        password_field = self.driver.find_element(*self.password_locator)
        password_field.clear()
        password_field.send_keys(password)

    def click_login_button(self):
        login_button = self.driver.find_element(*self.login_button_locator)
        login_button.click()

    def logout(self):
        open_menu_button = self.driver.find_element(*self.logout_link_locator)
        open_menu_button.click()
        logout_link = self.driver.find_element(*self.logout_link_locator)
        logout_link.click()
