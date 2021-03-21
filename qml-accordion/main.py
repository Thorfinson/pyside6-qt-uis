import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6 import QtCore

import pandas as pd

from dataGenerator import generate_data
from ListModel import AccordionList

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    # instantiate the model with the filter proxy
    model = AccordionList(10000)
    proxyModel = QtCore.QSortFilterProxyModel()
    proxyModel.setSourceModel(model)
    proxyModel.setFilterRole(model.user_name)
    proxyModel.setFilterCaseSensitivity(QtCore.Qt.CaseInsensitive)

    # start Engine and add model as accordion_list
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("accordion_list", proxyModel)

    # load our main qml
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())