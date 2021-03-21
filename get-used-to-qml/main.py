import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pandas as pd

from dataFrameModel import DataFrameModel
from dataFrameGenerator import generate_rows

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    
    # call our dataframe generator with first x rows
    df_generated = generate_rows(5)

    # define model for a pandas DataFrame - implementation in DataFrameModel class
    model = DataFrameModel(df_generated)

    # start Engine and add model as table_model
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("table_model", model)

    # load our main qml
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())