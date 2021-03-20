import pandas as pd
import numpy as np
import random
import string

def generate_rows(size=100):
    # generate random numbers with pandas and np
    df = pd.DataFrame(np.random.randint(0, 1000, size=(size, 3)), columns=list('ABC'))
    # generate random strings with np, random and string
    df['D'] = [''.join((random.choice(string.ascii_letters) for i in range(8))) for i in range(size)]
    return df