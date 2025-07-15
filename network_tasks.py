import json
from PySide6.QtCore import QUrl, QByteArray
from PySide6.QtNetwork import QNetworkRequest, QNetworkReply

USER_TOKEN = None
SERVER_ADDRESS = None



class LoginTask:
    def __init__(self, manager, on_result):
        self.manager = manager
        self.on_result = on_result

    def run(self, email, password):
        url = QUrl("http://localhost:5000/api/login")
        request = QNetworkRequest(url)
        request.setHeader(QNetworkRequest.ContentTypeHeader, "application/json")
        #request.setAttribute(QNetworkRequest.User, "login")  # used in response routing

        payload = {"email": email, "password": password}
        data = QByteArray(json.dumps(payload).encode())

        reply = self.manager.post(request, data)
        reply.finished.connect(lambda: self.handle_reply(reply))

    def handle_reply(self, reply):
        if reply.error() == QNetworkReply.NoError:
            response_data = reply.readAll().data().decode()
            try:
                data = json.loads(response_data)
                if reply.attribute(QNetworkRequest.HttpStatusCodeAttribute) == 200:
                    admin = data.get("admin")
                    global USER_TOKEN
                    USER_TOKEN = data.get("token")
                    print(f" user token is :{USER_TOKEN} --")

                    self.on_result(True, json.dumps(admin))
                else:
                    message = data.get("message", "Login failed")
                    self.on_result(False, message)
            except json.JSONDecodeError:
                self.on_result(False, "Invalid response format")
        else:
            self.on_result(False, f"Network error: {reply.errorString()}")
        reply.deleteLater()
