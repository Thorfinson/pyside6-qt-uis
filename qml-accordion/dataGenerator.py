import pandas as pd
import numpy as np
import random
import string
import csv
import lorem

def generate_data(size=100):
    dictList = []
    domain_list = []

    # load the email provider domains from the text file
    with open('resources/provider.csv', 'r') as fd:
        reader = csv.reader(fd)
        for row in reader:
            domain_list.append(row[0])

    # generate user objects with id, email address, lorem ipsum text, rank and image
    for i in range(size):
        dictList.append({"user_id": i, "user_name": ''.join((random.choice(string.ascii_lowercase) for i in range(7)))+ "@" +random.choice(domain_list), "user_text":lorem.paragraph(), "user_rank":i, "user_image": "../resources/images/person.png" })
    return dictList