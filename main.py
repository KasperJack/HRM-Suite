import sys
import os
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QmlElement, QQmlApplicationEngine
from PySide6.QtCore import QObject, Signal, Slot, QUrl, QByteArray
from PySide6.QtGui import QGuiApplication
import requests
from PySide6.QtNetwork import QNetworkAccessManager, QNetworkRequest, QNetworkReply
import json

from network_tasks import LoginTask


# Register the Python class with QML
QML_IMPORT_NAME = "Backend"
QML_IMPORT_MAJOR_VERSION = 1

@QmlElement
class Backend(QObject):
    
    # Signal to communicate result back to QML
    loginResult = Signal(bool,str)

    def __init__(self):
        super().__init__()
        self.network_manager = QNetworkAccessManager()
  



    @Slot()
    def loadInitialData(self):
        pass


    @Slot(str, str)
    def login(self, email, password):
        task = LoginTask(self.network_manager, self.emit_login_result)
        task.run(email, password)
    
    def emit_login_result(self, success, message):
        self.loginResult.emit(success, message)
    








class App:
    def __init__(self):
        self.app = QGuiApplication(sys.argv)
        self.engine = QQmlApplicationEngine()
        self.backend = Backend()
        self.setup_qml()
    
    def setup_qml(self):
        """Setup QML engine and load the QML file"""
        # Register the calculator instance with QML
        self.engine.rootContext().setContextProperty("backend", self.backend)
        
        # Load QML file
        qml_file = QUrl.fromLocalFile(os.path.join(os.path.dirname(__file__), "22/App.qml"))
        self.engine.load(qml_file)
        
        # Check if QML loaded successfully
        if not self.engine.rootObjects():
            print("Error loading QML file")
            sys.exit(1)
    
    def run(self):
        """Run the application"""
        return self.app.exec()






def main():
    app = App()
    sys.exit(app.run())

if __name__ == "__main__":
    main()