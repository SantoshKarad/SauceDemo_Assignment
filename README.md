# SauceDemo Assignment

This repository contains the automated test scripts for [SauceDemo](https://www.saucedemo.com/) using Robot Framework and Selenium Library in Python.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for testing purposes.

### Prerequisites

- Python 3.x
- Pip (Python package installer)
- Robot Framework
- SeleniumLibrary

### Installing

1. Clone this repository into your local machine.
git clone https://github.com/SantoshKarad/SauceDemo_Assignment.git
2. Navigate to the project folder.
cd SauceDemoAssignment
3. Install the required packages.
pip install -r requirements.txt

### Running the tests

- To run the tests, use the following command:
robot /path_to_your_directory/
- This command will execute all the test cases in the .robot files under the specified directory.

- If you want to run specific tests based on tags, you can do so with the following command:
robot -i tagname /path_to_your_directory/

- Parallel test execution
  pabot --processes 3 /path_to_your_tests directory/
