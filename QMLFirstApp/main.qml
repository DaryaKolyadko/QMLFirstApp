import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1


ApplicationWindow {
    id: appWindow
    title: qsTr("QML First App")
    width: 700
    height: 500
    visible: true

    TabView {
        anchors.fill: parent
        id: stopWatchTabView

        Tab {
            title: "Секундомер"

            Item
            {
                Rectangle{
                    color:"#F1E7F8"
                    width: parent.width
                    height: parent.height
                }

                property bool stopWatchIsRunning: false
                property int elapsed: 0
                property date previousTime: new Date()

                anchors.fill: parent

                GridLayout {
                    id: gridLayoutTimer
                    width: appWindow.width*3/5
                    columns: 2
                    anchors.centerIn: parent

                    Timer {
                        id: stopWatch
                        interval: 1
                        running: false
                        repeat: true
                        onTriggered:
                        {
                            var currentTime = new Date
                            var delta = (currentTime.getTime() - previousTime.getTime())
                            previousTime = currentTime
                            elapsed += delta
                            stopWatchLabel.update()
                        }
                      }

                        Text{
                            id: stopWatchLabel
                            font.bold: true
                            font.letterSpacing: 1
                            font.pointSize: (appWindow.height + appWindow.width)/40
                            color: "#79309C"
                            Layout.columnSpan: 2
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            text: "00:00:00.000"


                            function update(){
                                stopWatchLabel.font.pointSize = (appWindow.height + appWindow.width)/40
                                var date = new Date()
                                date = new Date(elapsed + date.getTimezoneOffset() * 60000)
                                stopWatchLabel.text = Qt.formatDateTime(date, "HH:mm:ss.zzz")
                            }
                        }


                    Button {
                        id: startOrStopstopwatch
                        text: stopWatchIsRunning ? qsTr("Стоп") : qsTr("Пуск")
                        Layout.fillWidth: true
                        onClicked: {
                            stopWatchIsRunning = !stopWatchIsRunning

                            if (!stopWatchIsRunning)
                            {
                                stopWatch.stop()
                            }
                            else
                            {
                                previousTime = new Date()
                                stopWatch.start()
                            }
                        }
                    }

                    Button {
                        id: resetStopwatch
                        text: qsTr("Сброс")
                        Layout.fillWidth: true
                        onClicked: {
                            stopWatchIsRunning = false;
                            stopWatch.stop()
                            elapsed = 0
                            stopWatchLabel.update()
                        }
                    }
                }
            }
       }


        Tab {
            title: "Таймер"
            Rectangle{color: "#EBEBB8"}
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
            title: qsTr("Файл")
            MenuItem {
                text: qsTr("Открыть")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("Выход")
                onTriggered: Qt.quit();
            }
        }
    }

    MainForm {
        anchors.fill: parent
        button1.visible: false
        button2.visible: false
        button3.visible: false
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
