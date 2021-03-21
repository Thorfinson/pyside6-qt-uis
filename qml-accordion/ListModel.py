from PySide6 import QtCore
from dataGenerator import generate_data

# The ListModel - inheriting from QAbstractListModel
class AccordionList(QtCore.QAbstractListModel):
    user_id = QtCore.Qt.UserRole + 1
    user_name = QtCore.Qt.UserRole + 2
    user_text = QtCore.Qt.UserRole + 3
    user_rank = QtCore.Qt.UserRole + 4
    user_image = QtCore.Qt.UserRole + 5

    # init Object and add sample Data
    def __init__(self, size=100, parent=None):
        super().__init__(parent)
        self.list_data = generate_data(size)

    # get the data depending on role
    def data(self, index, role=QtCore.Qt.DisplayRole):
        row = index.row()
        if index.isValid() and 0 <= row < self.rowCount():
            if role == AccordionList.user_id:
                return self.list_data[row]["user_id"]
            if role == AccordionList.user_name:
                return self.list_data[row]["user_name"]
            if role == AccordionList.user_text:
                return self.list_data[row]["user_text"]
            if role == AccordionList.user_rank:
                return self.list_data[row]["user_rank"]
            if role == AccordionList.user_image:
                return self.list_data[row]["user_image"]

    # get the row count
    def rowCount(self, parent=QtCore.QModelIndex()):
        return len(self.list_data)

    # get the role names
    def roleNames(self):
        return { 
            AccordionList.user_id: b"user_id", 
            AccordionList.user_name: b"user_name", 
            AccordionList.user_text: b"user_text", 
            AccordionList.user_rank: b"user_rank",
            AccordionList.user_image: b"user_image"
        }