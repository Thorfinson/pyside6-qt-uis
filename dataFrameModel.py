from PySide6.QtCore import QObject, Slot, Signal, Property, QAbstractTableModel, Qt, QModelIndex
from dataFrameGenerator import generate_rows
import pandas as pd

# Define DataFrameModel from QAbstractTableModel Interface
class DataFrameModel(QAbstractTableModel):
    DtypeRole = Qt.UserRole + 1000
    ValueRole = Qt.UserRole + 1001

    def __init__(self, df=pd.DataFrame(), parent=None):
        super(DataFrameModel, self).__init__(parent)
        self._dataframe = df

    ## Definitions of functions and Properties of the model

    # add n rows at the end
    def addRowsToDataFrame(self, dataframe):
        self.beginInsertRows(QModelIndex(), self._dataframe.shape[0], self._dataframe.shape[0] + dataframe.shape[0])
        self._dataframe = self._dataframe.append(dataframe, ignore_index=True)
        self.endInsertRows()

    # remove all the rows
    def removeAllRows(self):
        self.beginResetModel()
        self._dataframe.drop(self._dataframe.index, inplace=True)
        self.endResetModel()

    # reset to a new dataframe
    def setDataFrame(self, dataframe):
        self.beginResetModel()
        self._dataframe = dataframe.copy()
        self.endResetModel()

    # getter
    def dataFrame(self):
        return self._dataframe

    # defines model properties which are callable
    dataFrame = Property(pd.DataFrame, fget=dataFrame, fset=setDataFrame)

    # used for vizualization - inherited from QAbstractItemModel Interface
    def rowCount(self, parent=QModelIndex()):
        if parent.isValid():
            return 0
        return len(self._dataframe.index)

    # used for vizualization - inherited from QAbstractItemModel Interface
    def columnCount(self, parent=QModelIndex()):
        if parent.isValid():
            return 0
        return self._dataframe.columns.size

    # data function definition which is then called by a View - inherited from QAbstractItemModel 
    def data(self, index, role=Qt.DisplayRole):
        if not index.isValid() or not (0 <= index.row() < self.rowCount() and 0 <= index.column() < self.columnCount()):
            return ""
        row = self._dataframe.index[index.row()]
        col = self._dataframe.columns[index.column()]
        dt = self._dataframe[col].dtype

        val = self._dataframe.iloc[row][col]
        if role == Qt.DisplayRole:
            return str(val)
        elif role == DataFrameModel.ValueRole:
            return val
        if role == DataFrameModel.DtypeRole:
            return dt
        return ""

    # different roles can be set in the element showing the model - different "views" or formats of the data - inherited from QAbstractItemModel 
    def roleNames(self):
        roles = {
            Qt.DisplayRole: b'display',
            DataFrameModel.DtypeRole: b'dtype',
            DataFrameModel.ValueRole: b'value'
        }
        return roles
    
    # Define our slots - events reacting onto functions in the ui
    
    # add Rows depending on Number
    @Slot(int)
    def addRows(self, rowNumbers:int):
        self.addRowsToDataFrame(generate_rows(rowNumbers))

    # clean the dataframe
    @Slot()
    def emptyDataFrame(self):
        self.removeAllRows()