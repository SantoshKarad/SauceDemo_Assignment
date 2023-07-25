from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from BasePage import BasePage
import variables.locators as loc


class CartPage(BasePage):
    def __init__(self, ):
        self.add_to_cart_button_locator = (By.CSS_SELECTOR, loc.add_to_cart_button_locator)
        self.remove_from_cart_button_locator = (By.CSS_SELECTOR, loc.remove_from_cart_button_locator)
        self.cart_count_locator = (By.XPATH, loc.cart_count_locator)
        self.checkout_button_locator = (By.XPATH, loc.checkout_button)
        self.continue_shopping_button_locator = (By.ID, loc.continue_shopping_button_locator)

    def select_product(self, product_locator):
        WebDriverWait(self.driver, 10).until(EC.element_to_be_clickable((By.XPATH, product_locator)))
        self.driver.find_element(By.XPATH, product_locator).click()

    def add_product_to_cart(self, add_to_cart_button_locator):
        WebDriverWait(self.driver, 10).until(EC.element_to_be_clickable((By.XPATH, add_to_cart_button_locator)))
        self.driver.find_element(By.XPATH, add_to_cart_button_locator).click()

    def remove_product_from_cart(self, remove_from_cart_button_locator):
        WebDriverWait(self.driver, 10).until(EC.element_to_be_clickable((By.XPATH, remove_from_cart_button_locator)))
        self.driver.find_element(By.XPATH, remove_from_cart_button_locator).click()

    def get_cart_count(self):
        return int(self.driver.find_element(*self.cart_count_locator).text)

    def start_checkout(self):
        self.driver.find_element(*self.checkout_button_locator).click()

    def is_checkout_available(self):
        try:
            WebDriverWait(self.driver, 10).until(EC.visibility_of_element_located(self.checkout_button_locator))
            return True
        except Exception:
            return False

    def continue_shopping(self):
        self.driver.find_element(*self.continue_shopping_button_locator).click()
