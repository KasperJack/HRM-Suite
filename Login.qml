import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15





Rectangle {
    
    // Define preferred size for this page
    property int preferredWidth: 1200
    property int preferredHeight: 800
    
    // Background gradient
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#667eea" }
            GradientStop { position: 1.0; color: "#764ba2" }
        }
    }
    
    // Animated background particles
    Repeater {
        model: 30
        Rectangle {
            id: particle
            width: Math.random() * 4 + 1
            height: width
            radius: width / 2
            color: Qt.rgba(1, 1, 1, Math.random() * 0.3 + 0.1)
            x: Math.random() * window.width
            y: Math.random() * window.height
            
            SequentialAnimation on y {
                loops: Animation.Infinite
                NumberAnimation {
                    to: particle.y + 50
                    duration: Math.random() * 3000 + 2000
                    easing.type: Easing.InOutSine
                }
                NumberAnimation {
                    to: particle.y - 50
                    duration: Math.random() * 3000 + 2000
                    easing.type: Easing.InOutSine
                }
            }
            
            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation {
                    to: 0.8
                    duration: Math.random() * 2000 + 1000
                }
                NumberAnimation {
                    to: 0.2
                    duration: Math.random() * 2000 + 1000
                }
            }
        }
    }
    
    // Shadow effect using multiple rectangles
    Rectangle {
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 5
        anchors.verticalCenterOffset: 5
        width: 400
        height: 500
        radius: 20
        color: Qt.rgba(0, 0, 0, 0.2)
        opacity: 0.6
    }
    
    Rectangle {
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 3
        anchors.verticalCenterOffset: 3
        width: 400
        height: 500
        radius: 20
        color: Qt.rgba(0, 0, 0, 0.1)
        opacity: 0.4
    }
    
    // Main login container
    Rectangle {
        id: loginContainer
        anchors.centerIn: parent
        width: 400
        height: 500
        radius: 20
        color: Qt.rgba(1, 1, 1, 0.95)
        border.color: Qt.rgba(1, 1, 1, 0.3)
        border.width: 1
        
        // Scale animation on load
        Component.onCompleted: {
            scaleAnimation.start()
        }
        
        NumberAnimation {
            id: scaleAnimation
            target: loginContainer
            property: "scale"
            from: 0.8
            to: 1.0
            duration: 500
            easing.type: Easing.OutBack
        }
        
        ColumnLayout {
            anchors.centerIn: parent
            width: parent.width * 0.8
            spacing: 25
            
            // Logo/Title section
            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                width: 80
                height: 80
                radius: 40
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#667eea" }
                    GradientStop { position: 1.0; color: "#764ba2" }
                }
                
                Text {
                    anchors.centerIn: parent
                    text: "🔐"
                    font.pixelSize: 40
                }
            }
            
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Welcome Back"
                font.pixelSize: 28
                font.bold: true
                color: "#2d3748"
            }
            
            Text {
                Layout.alignment: Qt.AlignHCenter
                text: "Sign in to your account"
                font.pixelSize: 14
                color: "#718096"
            }
            
            // Input fields
            Rectangle {
                Layout.fillWidth: true
                height: 50
                radius: 10
                color: "#f7fafc"
                border.color: emailField.activeFocus ? "#667eea" : "#e2e8f0"
                border.width: 2
                
                Behavior on border.color {
                    ColorAnimation { duration: 200 }
                }
                
                // Input icon
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    text: "📧"
                    font.pixelSize: 16
                    color: "#a0aec0"
                }
                
                TextField {
                    id: emailField
                    anchors.fill: parent
                    anchors.leftMargin: 45
                    anchors.rightMargin: 15
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                    placeholderText: "Email address"
                    font.pixelSize: 14
                    background: Rectangle { color: "transparent" }
                    selectByMouse: true
                }
            }
            
            Rectangle {
                Layout.fillWidth: true
                height: 50
                radius: 10
                color: "#f7fafc"
                border.color: passwordField.activeFocus ? "#667eea" : "#e2e8f0"
                border.width: 2
                
                Behavior on border.color {
                    ColorAnimation { duration: 200 }
                }
                
                // Password icon
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                    text: "🔒"
                    font.pixelSize: 16
                    color: "#a0aec0"
                }
                
                TextField {
                    id: passwordField
                    anchors.fill: parent
                    anchors.leftMargin: 45
                    anchors.rightMargin: 15
                    anchors.topMargin: 10
                    anchors.bottomMargin: 10
                    placeholderText: "Password"
                    font.pixelSize: 14
                    echoMode: TextInput.Password
                    background: Rectangle { color: "transparent" }
                    selectByMouse: true
                }
            }
            
            // Remember me and forgot password
            RowLayout {
                Layout.fillWidth: true
                
                CheckBox {
                    id: rememberCheck
                    text: "Remember me"
                    font.pixelSize: 12
                    checked: false
                    
                    indicator: Rectangle {
                        implicitWidth: 18
                        implicitHeight: 18
                        x: rememberCheck.leftPadding
                        y: parent.height / 2 - height / 2
                        radius: 3
                        border.color: rememberCheck.checked ? "#667eea" : "#cbd5e0"
                        border.width: 2
                        color: rememberCheck.checked ? "#667eea" : "transparent"
                        
                        Text {
                            anchors.centerIn: parent
                            text: "✓"
                            color: "white"
                            font.pixelSize: 12
                            visible: rememberCheck.checked
                        }
                    }
                }
                
                Item { Layout.fillWidth: true }
                
                Text {
                    text: "Forgot password?"
                    font.pixelSize: 12
                    color: "#667eea"
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            console.log("Forgot password clicked")
                        }
                    }
                }
            }
            
            // Login button
            Rectangle {
                Layout.fillWidth: true
                height: 50
                radius: 10
                gradient: Gradient {
                    GradientStop { 
                        position: 0.0
                        color: loginButton.pressed ? "#5a6fd8" : "#667eea"
                    }
                    GradientStop { 
                        position: 1.0
                        color: loginButton.pressed ? "#4c51bf" : "#764ba2"
                    }
                }
                opacity: loginButton.enabled ? 1.0 : 0.6
                
                Behavior on opacity {
                    NumberAnimation { duration: 150 }
                }
                
                Button {
                    id: loginButton
                    anchors.fill: parent
                    text: "Sign In"
                    font.pixelSize: 16
                    font.bold: true
                    enabled: emailField.text.trim() !== "" && passwordField.text.trim() !== ""
                    
                    background: Rectangle {
                        color: "transparent"
                    }
                    
                    contentItem: Text {
                        text: loginButton.text
                        font: loginButton.font
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        visible: !loadingIndicator.visible
                    }
                    
                    onClicked: {
                        if (emailField.text.trim() === "" || passwordField.text.trim() === "") {
                            errorText.text = "Please fill in all fields"
                            errorText.visible = true
                            return
                        }
                        
                        errorText.visible = false
                        loginButton.enabled = false
                        loadingAnimation.start()
                        
                        // Call backend
                        backend.login(emailField.text, passwordField.text)
                    }
                    
                    // Loading animation
                    Rectangle {
                        id: loadingIndicator
                        anchors.centerIn: parent
                        width: 20
                        height: 20
                        radius: 10
                        color: "white"
                        visible: false
                        
                        RotationAnimation {
                            id: loadingAnimation
                            target: loadingIndicator
                            property: "rotation"
                            from: 0
                            to: 360
                            duration: 1000
                            loops: Animation.Infinite
                            onStarted: {
                                loadingIndicator.visible = true
                            }
                            onStopped: {
                                loadingIndicator.visible = false
                            }
                        }
                    }
                }
            }
            
            // Error message
            Rectangle {
                Layout.fillWidth: true
                height: errorText.visible ? 40 : 0
                radius: 8
                color: "#fed7d7"
                border.color: "#feb2b2"
                border.width: 1
                visible: errorText.visible
                
                Behavior on height {
                    NumberAnimation { duration: 200 }
                }
                
                Text {
                    id: errorText
                    anchors.centerIn: parent
                    text: ""
                    color: "#c53030"
                    font.pixelSize: 12
                    wrapMode: Text.WordWrap
                    visible: false
                }
            }
            

        }
    }
    
    // Auto-fill demo data (remove in production)
    Component.onCompleted: {
        backend.loadInitialData()
    }
    
    Connections {
        target: backend

        
        function onLoginResult(success, message) {
            loadingAnimation.stop()
            loginButton.enabled = true
            
            if (success) {
                errorText.text = ""
                errorText.visible = false
                console.log(message)
                // You can add navigation to main app here
*                stackView.push("mainWindow.qml")

            } else {
                errorText.text = message
                errorText.visible = true
                console.log(message)
            }
        }
    }
}