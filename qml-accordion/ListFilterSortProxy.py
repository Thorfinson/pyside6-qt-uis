from PySide6 import QtCore

class TomsListFilterProxyModel(QtCore.QSortFilterProxyModel):
    def __init__(self, parent=None):
        super(TomsListFilterProxyModel, self).__init__(parent)

        self.setDynamicSortFilter(True)
        self.setFilterCaseSensitivity(QtCore.Qt.CaseInsensitive)