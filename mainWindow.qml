import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    
    // Define preferred size for this page
    property int preferredWidth: 1200
    property int preferredHeight: 800
    
    // Modern color scheme
    property color primaryColor: "#2563eb"      // Blue
    property color secondaryColor: "#1e40af"    // Darker blue
    property color backgroundColor: "#f8fafc"   // Light gray
    property color surfaceColor: "#ffffff"      // White
    property color textColor: "#1f2937"         // Dark gray
    property color mutedTextColor: "#6b7280"    // Medium gray
    property color borderColor: "#e5e7eb"       // Light border
    property color hoverColor: "#f3f4f6"        // Light hover
    
    // Navigation state
    property bool navigationExpanded: true
    property int currentPage: 0
    
    // Page definitions for HR app
    property var pages: [
        { name: "Dashboard", icon: "📊", component: "DashboardPage" },
        { name: "Employees", icon: "👥", component: "EmployeesPage" },
        { name: "Recruitment", icon: "🎯", component: "RecruitmentPage" },
        { name: "Payroll", icon: "💰", component: "PayrollPage" },
        { name: "Performance", icon: "📈", component: "PerformancePage" },
        { name: "Time Tracking", icon: "⏰", component: "TimeTrackingPage" },
        { name: "Reports", icon: "📋", component: "ReportsPage" },
        { name: "Settings", icon: "⚙️", component: "SettingsPage" }
    ]
    
    // Main layout container
    Rectangle {
        anchors.fill: parent
        color: backgroundColor
        
        RowLayout {
            anchors.fill: parent
            spacing: 0
            
            // Side Navigation Panel
            Rectangle {
                id: sideNavigation
                Layout.fillHeight: true
                Layout.preferredWidth: navigationExpanded ? 280 : 70
                color: surfaceColor
                border.color: borderColor
                border.width: 1
                
                // Smooth width animation
                Behavior on Layout.preferredWidth {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0
                    
                    // Header with toggle button
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 70
                        color: primaryColor
                        
                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 12
                            
                            // Menu toggle button
                            Button {
                                id: toggleButton
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                
                                background: Rectangle {
                                    color: toggleButton.hovered ? Qt.rgba(1, 1, 1, 0.1) : "transparent"
                                    radius: 6
                                }
                                
                                contentItem: Text {
                                    text: "☰"
                                    color: "white"
                                    font.pixelSize: 18
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: navigationExpanded = !navigationExpanded
                            }
                            
                            // App title (visible when expanded)
                            Text {
                                Layout.fillWidth: true
                                text: "HR System"
                                color: "white"
                                font.pixelSize: 18
                                font.weight: Font.Bold
                                visible: navigationExpanded
                                opacity: navigationExpanded ? 1.0 : 0.0
                                
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }
                    }
                    
                    // Navigation menu items
                    ScrollView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.margins: 8
                        
                        ColumnLayout {
                            width: parent.width
                            spacing: 4
                            
                            // Generate navigation items
                            Repeater {
                                model: pages
                                
                                delegate: Rectangle {
                                    Layout.fillWidth: true
                                    Layout.preferredHeight: 50
                                    color: index === currentPage ? Qt.rgba(37, 99, 235, 0.1) : 
                                           navMouseArea.containsMouse ? hoverColor : "transparent"
                                    radius: 8
                                    border.color: index === currentPage ? primaryColor : "transparent"
                                    border.width: 1
                                    
                                    // Smooth color transitions
                                    Behavior on color {
                                        ColorAnimation { duration: 150 }
                                    }
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 12
                                        
                                        // Icon
                                        Text {
                                            text: modelData.icon
                                            font.pixelSize: 20
                                            color: index === currentPage ? primaryColor : textColor
                                            Layout.alignment: Qt.AlignVCenter
                                        }
                                        
                                        // Label (visible when expanded)
                                        Text {
                                            Layout.fillWidth: true
                                            text: modelData.name
                                            color: index === currentPage ? primaryColor : textColor
                                            font.pixelSize: 14
                                            font.weight: index === currentPage ? Font.Medium : Font.Normal
                                            visible: navigationExpanded
                                            opacity: navigationExpanded ? 1.0 : 0.0
                                            
                                            Behavior on opacity {
                                                NumberAnimation { duration: 200 }
                                            }
                                        }
                                    }
                                    
                                    MouseArea {
                                        id: navMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        
                                        onClicked: {
                                            currentPage = index
                                            console.log("Navigating to:", modelData.name)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    // Footer with user info
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 70
                        color: Qt.rgba(0, 0, 0, 0.05)
                        
                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 16
                            spacing: 12
                            
                            // User avatar placeholder
                            Rectangle {
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                color: primaryColor
                                radius: 20
                                
                                Text {
                                    anchors.centerIn: parent
                                    text: "👤"
                                    color: "white"
                                    font.pixelSize: 16
                                }
                            }
                            
                            // User info (visible when expanded)
                            ColumnLayout {
                                Layout.fillWidth: true
                                spacing: 2
                                visible: navigationExpanded
                                opacity: navigationExpanded ? 1.0 : 0.0
                                
                                Text {
                                    text: "John Doe"
                                    color: textColor
                                    font.pixelSize: 14
                                    font.weight: Font.Medium
                                }
                                
                                Text {
                                    text: "HR Manager"
                                    color: mutedTextColor
                                    font.pixelSize: 12
                                }
                                
                                Behavior on opacity {
                                    NumberAnimation { duration: 200 }
                                }
                            }
                        }
                    }
                }
            }
            
            // Main content area
            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                color: backgroundColor
                
                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0
                    
                    // Top header bar
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 70
                        color: surfaceColor
                        border.color: borderColor
                        border.width: 1
                        
                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 20
                            
                            // Page title
                            Text {
                                text: pages[currentPage].name
                                color: textColor
                                font.pixelSize: 24
                                font.weight: Font.Bold
                            }
                            
                            Item { Layout.fillWidth: true } // Spacer
                            
                            // Search bar placeholder
                            Rectangle {
                                Layout.preferredWidth: 300
                                Layout.preferredHeight: 40
                                color: backgroundColor
                                border.color: borderColor
                                border.width: 1
                                radius: 8
                                
                                RowLayout {
                                    anchors.fill: parent
                                    anchors.margins: 12
                                    spacing: 8
                                    
                                    Text {
                                        text: "🔍"
                                        color: mutedTextColor
                                        font.pixelSize: 16
                                    }
                                    
                                    TextInput {
                                        Layout.fillWidth: true
                                        color: textColor
                                        font.pixelSize: 14
                                        
                                        property string placeholderText: "Search employees, records..."
                                        
                                        Text {
                                            anchors.fill: parent
                                            text: parent.placeholderText
                                            color: mutedTextColor
                                            font.pixelSize: 14
                                            visible: parent.text === ""
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }
                                }
                            }
                            
                            // Notification bell
                            Button {
                                Layout.preferredWidth: 40
                                Layout.preferredHeight: 40
                                
                                background: Rectangle {
                                    color: parent.hovered ? hoverColor : "transparent"
                                    radius: 6
                                }
                                
                                contentItem: Text {
                                    text: "🔔"
                                    color: textColor
                                    font.pixelSize: 16
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: stackView.push("Login.qml") //test
                            }
                        }
                    }
                    
                    // Main content area with page loader
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: backgroundColor
                        
                        // Content loader - this is where different HR pages will be loaded
                        Loader {
                            id: contentLoader
                            anchors.fill: parent
                            anchors.margins: 20
                            
                            // Load different components based on current page
                            source: getPageSource(currentPage)
                            
                            // Fallback content when no specific page is loaded
                            sourceComponent: Component {
                                Rectangle {
                                    color: surfaceColor
                                    radius: 12
                                    border.color: borderColor
                                    border.width: 1
                                    
                                    ColumnLayout {
                                        anchors.centerIn: parent
                                        spacing: 20
                                        
                                        Text {
                                            text: pages[currentPage].icon
                                            font.pixelSize: 48
                                            Layout.alignment: Qt.AlignHCenter
                                        }
                                        
                                        Text {
                                            text: pages[currentPage].name + " Page"
                                            font.pixelSize: 24
                                            font.weight: Font.Bold
                                            color: textColor
                                            Layout.alignment: Qt.AlignHCenter
                                        }
                                        
                                        Text {
                                            text: "This is a placeholder for the " + pages[currentPage].name.toLowerCase() + " module.\nImplement your HR functionality here."
                                            font.pixelSize: 14
                                            color: mutedTextColor
                                            horizontalAlignment: Text.AlignHCenter
                                            Layout.alignment: Qt.AlignHCenter
                                        }
                                        
                                        // Sample action button
                                        Button {
                                            text: "Get Started"
                                            Layout.alignment: Qt.AlignHCenter
                                            
                                            background: Rectangle {
                                                color: parent.pressed ? secondaryColor : 
                                                       parent.hovered ? Qt.lighter(primaryColor, 1.1) : primaryColor
                                                radius: 8
                                                implicitWidth: 120
                                                implicitHeight: 40
                                            }
                                            
                                            contentItem: Text {
                                                text: parent.text
                                                color: "white"
                                                font.pixelSize: 14
                                                font.weight: Font.Medium
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                            }
                                            
                                            onClicked: {
                                                console.log("Action clicked for", pages[currentPage].name)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // Helper function to get page source (for future implementation)
    function getPageSource(pageIndex) {
        // Return empty string to use fallback component
        // In a real app, you would return paths to specific QML files:
        // switch(pageIndex) {
        //     case 0: return "pages/DashboardPage.qml"
        //     case 1: return "pages/EmployeesPage.qml"
        //     // ... etc
        // }
        return ""
    }
    
    // Keyboard shortcuts
    Shortcut {
        sequence: "Ctrl+M"
        onActivated: navigationExpanded = !navigationExpanded
    }
    

}