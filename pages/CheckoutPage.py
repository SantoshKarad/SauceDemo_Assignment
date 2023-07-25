from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from BasePage import BasePage
from selenium.webdriver.common.by import By
import variables.locators as loc


class CheckoutPage(BasePage):
    def __init__(self):
        self.first_name_locator = (By.ID, loc.first_name_locator)
        self.last_name_locator = (By.ID, loc.last_name_locator)
        self.postal_code_locator = (By.ID, loc.postal_code_locator)
        self.continue_button_locator = (By.XPATH, loc.continue_button)
        self.cancel_button_locator = (By.XPATH, loc.cancel_button)
        self.finish_button_locator = (By.XPATH, loc.finish_button)
        self.error_message_locator = (By.XPATH, loc.error_message_locator)
        self.checkout_overview_locator = (By.XPATH, loc.checkout_overview)
        self.confirmation_message_locator = (By.ID, loc.confirmation_message)

    def enter_shipping_info(self, first_name, last_name, postal_code):
        first_name_field = self.driver.find_element(*self.first_name_locator)
        first_name_field.clear()
        first_name_field.send_keys(first_name)

        last_name_field = self.driver.find_element(*self.last_name_locator)
        last_name_field.clear()
        last_name_field.send_keys(last_name)

        postal_code_field = self.driver.find_element(*self.postal_code_locator)
        postal_code_field.clear()
        postal_code_field.send_keys(postal_code)

    def continue_checkout(self):
        continue_button = self.driver.find_element(*self.continue_button_locator)
        continue_button.click()

    def cancel_checkout(self):
        cancel_button = self.driver.find_element(*self.cancel_button_locator)
        cancel_button.click()

    def finish_checkout(self):
        finish_button = self.driver.find_element(*self.finish_button_locator)
        finish_button.click()

    def is_error_message_displayed(self):
        try:
            WebDriverWait(self.driver, 10).until(EC.visibility_of_element_located(self.error_message_locator))
            error_message = self.driver.find_element(*self.error_message_locator)
            return error_message.is_displayed()
        except Exception:
            return False

    def get_error_message_text(self):
        error_message = self.driver.find_element(*self.error_message_locator)
        return error_message.text

    def is_checkout_overview_page_displayed(self):
        try:
            checkout_overview = self.driver.find_element(*self.checkout_overview_locator)
            return checkout_overview.is_displayed()
        except Exception:
            return False

    def is_order_confirmation_message_displayed(self):
        try:
            confirmation_message_element = self.driver.find_element(*self.confirmation_message_locator)
            return "Thank you for your order!" in confirmation_message_element.text
        except Exception:
            return False
