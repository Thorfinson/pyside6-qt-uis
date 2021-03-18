import sys
import os
import random
import string

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import numpy as np
import pandas as pd

from dataFrameModel import DataFrameModel

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    
    # generate random data with pandas and np
    lengthOfDataFrame = 100000
    df = pd.DataFrame(np.random.randint(0, 1000, size=(lengthOfDataFrame, 3)), columns=list('ABC'))
    df['D'] = [''.join((random.choice(string.ascii_letters) for i in range(8))) for i in range(lengthOfDataFrame)]
    
    # define model for a pandas DataFrame - definition in dataFrameModel class
    model = DataFrameModel(df)

    # start Engine and add model as table_model
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("table_model", model)

    # load our main qml
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())