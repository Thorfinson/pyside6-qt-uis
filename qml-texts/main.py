import sys
import os

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6 import QtCore

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)

    # start Engine
    engine = QQmlApplicationEngine()

    # load our main qml
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())