import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1

ApplicationWindow {
    title: qsTr("QML First App")
    width: 700
    height: 500
    visible: true

    TabView {
        anchors.fill: parent
        Tab {
            title: "Секундомер"
            Rectangle{color: "#EBEBB8"}
        }
        Tab {
            title: "Таймер"
            Rectangle{color:"#B8BAEB"}
//            Item
//            {

////                property alias button3: button3
////                property alias button2: button2
////                property alias button1: button1
//                anchors.fill: parent

//                GridLayout {
//                    columns: 2
//                    anchors.centerIn: parent

//                    Button {
//                        id: button1
//                        text: qsTr("Press Me 1")
//                    }

//                    Button {
//                        id: button2
//                        text: qsTr("Press Me 2")
//                    }

//                    Button {
//                        id: button3
//                        text: qsTr("Press Me 3")
//                    }
//                }
          //  }

        }
        Tab {
            title: "Будильник"
            Rectangle{color:"#F2B6B0"}
        }
        Tab {
            title: "Hello"
            Rectangle{color:"#B5EEB5"}
        }
       }
    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    MainForm {
        anchors.fill: parent
        button1.onClicked: messageDialog.show(qsTr("Button 1 pressed"))
        button2.onClicked: messageDialog.show(qsTr("Button 2 pressed"))
        button3.onClicked: messageDialog.show(qsTr("Button 3 pressed"))
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
