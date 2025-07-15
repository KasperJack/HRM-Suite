import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: window
    // Set initial size to match your login page
    width: 1200
    height: 800
    visible: true
    title: "HR app"

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "Login.qml"
        
        // Handle window resize when pages change
        onCurrentItemChanged: {
            if (currentItem && currentItem.preferredWidth && currentItem.preferredHeight) {
                window.width = currentItem.preferredWidth
                window.height = currentItem.preferredHeight
            }
        }
        
        // Handle initial item sizing
        Component.onCompleted: {
            if (currentItem && currentItem.preferredWidth && currentItem.preferredHeight) {
                window.width = currentItem.preferredWidth
                window.height = currentItem.preferredHeight
            }
        }
    }
}