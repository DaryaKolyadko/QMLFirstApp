import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.1


ApplicationWindow {
    id: appWindow
    objectName: "appWindow"
    title: qsTr("QML First App")
    width: 700
    height: 500
    visible: true

    Connections {
        target: receiver
    }

    TabView {
        anchors.fill: parent
        id: tabView
        objectName: "tabView"

        Tab {
            id: stopWatchTab
            title: qsTr("Секундомер")

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
                property string defaultTimeStr: qsTr("00:00:00.000")

                anchors.fill: parent

                GridLayout {
                    id: gridLayoutStopWatch
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
                            text: defaultTimeStr


                            function update(){
                                var date = new Date()
                                date = new Date(elapsed + date.getTimezoneOffset() * 60000)
                                stopWatchLabel.text = Qt.formatDateTime(date, "HH:mm:ss.zzz")
                            }
                        }


                    Button {
                        id: startOrStopStopWatch
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
                        id: resetStopWatch
                        text: qsTr("Сброс")
                        Layout.fillWidth: true
                        onClicked: {
                            if(stopWatchIsRunning)
                            {
                                stopWatchIsRunning = false;
                                stopWatch.stop()
                            }
                            elapsed = 0
                            stopWatchLabel.update()
                        }
                    }
                }
            }
       }


        Tab {
            id: timerTab
            title: qsTr("Таймер")
            Item
            {
                Rectangle{
                    color:"#F9F8D0"
                    width: parent.width
                    height: parent.height
                }

                property bool timerIsRunning: false
                property int timeLeft: 0
                property date previousTime: new Date()
                property string defaultTimeStr: qsTr("00:00:00.000")

                anchors.fill: parent

                GridLayout {
                    id: gridLayoutTimer
                    width: appWindow.width*3/5
                    columns: 2
                    anchors.centerIn: parent

                    Timer {
                        id: timer
                        interval: 1
                        running: false
                        repeat: true
                        onTriggered:
                        {
                            var currentTime = new Date
                            var delta = (currentTime.getTime() - previousTime.getTime())
                            previousTime = currentTime
                            timeLeft -= delta
                            timerLabel.update()
                        }
                      }

                    Text {
                        Layout.columnSpan: 2
                        font.bold: true
                        font.letterSpacing: 1
                        font.pointSize: (appWindow.height + appWindow.width)/110
                        color: "#886B1E"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: qsTr("Введите время в секундах:")
                    }

                    TextField {
                        id: timeInSecondsTextInput
                        Layout.columnSpan: 2
                        font.bold: true
                        font.letterSpacing: 1
                        font.pointSize: (appWindow.height + appWindow.width)/110
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        validator: IntValidator{bottom: 1}
                        style: textFieldStyle
                    }

                    Text {
                        id: timerLabel
                        font.bold: true
                        font.letterSpacing: 1
                        font.pointSize: (appWindow.height + appWindow.width)/40
                        color: "#CF9B2E"
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: defaultTimeStr

                        function update(){
                            var date = new Date()
                            if (timeLeft < 0)
                            {
                                messageDialog.show(qsTr("Время вышло"))
                                timerIsRunning = false
                                timer.stop()
                                timeLeft = 0
                            }
                                date = new Date(timeLeft + date.getTimezoneOffset() * 60000)
                                timerLabel.text = Qt.formatDateTime(date, "HH:mm:ss.zzz")
                            }
                       }


                    Button {
                        id: startOrStopTimer
                        text: timerIsRunning ? qsTr("Стоп") : qsTr("Пуск")
                        Layout.fillWidth: true
                        onClicked: {
                            timerIsRunning = !timerIsRunning
                            if (!timerIsRunning)
                            {
                                timer.stop()
                            }
                            else
                            {
                                previousTime = new Date()
                                if(timeInSecondsTextInput.text == "")
                                {
                                    timerIsRunning = false;
                                    messageDialog.show(qsTr("Введите время, прежде чем запускать таймер"))
                                }
                                else
                                {
                                    timeLeft = parseInt(timeInSecondsTextInput.text) * 1000
                                    timer.start()
                                }
                            }
                        }
                    }

                    Button {
                        id: resetTimer
                        text: qsTr("Сброс")
                        Layout.fillWidth: true
                        onClicked: {
                            if(timerIsRunning)
                            {
                                timerIsRunning = false;
                                timer.stop()
                            }
                            timeLeft = 0
                            timerLabel.update()
                        }
                    }
                }
            }
        }

        Tab {
            id: alarmTab
            title: "Будильник"

            Item
            {
                Rectangle{
                    color:"#FFDFDD"
                    width: parent.width
                    height: parent.height
                }

                anchors.fill: parent

                property date now


                Timer {
                    id: currentTimeTimer
                    interval: 1
                    running: true
                    repeat: true
                    onTriggered:
                    {
                        alarmCurrentTimeLabel.update()
                    }
                  }

                Timer {
                    id: alarmTimer
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered:
                    {
                        var currentTime = new Date()
                        for(var i = 0; i < alarmListModel.count; i++)
                        {
                            var alarm = alarmListModel.get(i).time
                            var delta = Math.abs(currentTime.getTime() - alarm.getTime())
                            if(delta < 1000)
                            {
                                messageDialog.show(qsTr(Qt.formatDateTime(alarm, "Время: HH:mm")))
                                alarmListModel.remove(i)
                            }
                        }
                    }
                  }

                GridLayout{
                    id: gridLayoutAlarm
                    width: appWindow.width*9/11
                    columns: 12
                    anchors.margins: 20
                    anchors.fill: parent

                    TextField {
                        id: hoursTextField
                        font.bold: true
                        font.letterSpacing: 1
                        font.pointSize: (appWindow.height + appWindow.width)/150
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        validator: IntValidator{bottom: 0; top: 23 }
                        maximumLength: 2
                        style: textFieldStyle
                    }

                    Text{
                        text: ":"
                        font.letterSpacing: 1
                        font.pointSize: (appWindow.height + appWindow.width)/150
                        Layout.alignment: Qt.AlignCenter
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                    }

                    TextField {
                        id: minutesTextField
                        font.bold: true
                        font.letterSpacing: 1
                        Layout.columnSpan: 2
                        font.pointSize: (appWindow.height + appWindow.width)/150
                        Layout.fillWidth: true
                        validator: IntValidator{bottom: 0; top: 59 }
                        maximumLength: 2
                        style: textFieldStyle
                    }

                    Button{
                        id: addAlarmButton
                        text: qsTr("Добавить будильник")
                        Layout.columnSpan: 3
                        onClicked:{
                            if(hoursTextField.text == "" || minutesTextField.text == "")
                            {
                                messageDialog.show(qsTr("Введите время, прежде чем добавлять будильник"))
                            }
                            else
                            {
                                var hours = parseInt(hoursTextField.text)
                                var minutes = parseInt(minutesTextField.text)
                                var date = new Date()
                                date.setHours(hours)
                                date.setMinutes(minutes)
                                date.setSeconds(0)
                                date.setMilliseconds(0)
                                alarmListModel.append({time: date})
                            }
                        }
                    }

                    Text
                    {
                        id: alarmCurrentTimeLabel
                        font.bold: true
                        font.letterSpacing: 4
                        font.pointSize: (appWindow.height + appWindow.width)/55
                        color: "#B00202"

                        function update(){
                            now = new Date
                            alarmCurrentTimeLabel.text = Qt.formatDateTime(now, "HH:mm:ss")
                            font.pointSize = (appWindow.height + appWindow.width)/55
                        }
                    }

                    ScrollView{
                        id: alarmScrollView
                        Layout.columnSpan: 6
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        ListView {
                              id: alarmListView
                              model: alarmListModel
                              delegate: alarmListDelegate
                              highlight: highlightBar
                              highlightFollowsCurrentItem: false
                              spacing: 5
                              focus: true
                        }
                    }

                    Component {
                        id: highlightBar

                        Rectangle {
                            id: highlightBarRect
                            width: alarmListView.width
                            Layout.fillWidth: true
                            height: 50 //appWindow.height + appWindow.width)/50
                            radius: 5
                            color: "white"
                            border.color: "red"
                            border.width: 1
                            y: alarmListView.currentItem.y;
                            x: alarmListView.currentItem.x;
                            Behavior on y { PropertyAnimation {} }
                        }
                    }

                    Component {
                        id: alarmListDelegate

                        Item {
                            id: alarmListDelegateItem
                            width: alarmListView.width
                            Layout.fillWidth: true
                            height: 50

                            Row {
                                ColumnLayout {
                                    width: alarmListView.width
                                    Layout.fillWidth: true

                                    Text {
                                        text: Qt.formatDateTime(time, " HH:mm")
                                        font.pointSize: (appWindow.height + appWindow.width)/150
                                    }

                                    MouseArea {
                                        anchors.fill: parent

                                        onClicked:{
                                            alarmListView.currentIndex = index;
                                        }
                                    }
                                }
                            }
                        }
                    }

                    MessageDialog{
                        id: deleteAlarmMessageDialog
                        title: qsTr("Важно")
                        text: "Вы уверены, что хотите удалить выбранный будильник?"
                        standardButtons: StandardButton.Yes | StandardButton.No

                        onYes: {
                            alarmListModel.remove(alarmListView.currentIndex)
                            close()
                        }

                        onNo:{
                            close()
                        }
                    }

                    Button{
                        id: deleteAlarmButton
                        Layout.alignment: Qt.AlignTop
                        text: qsTr(" Удалить будильник ")

                        onClicked: {
                            if(alarmListView.currentIndex == -1)
                            {
                                 messageDialog.show("Выберите будильник, который хотите удалить")
                            }
                            else
                            {
                                deleteAlarmMessageDialog.open()
                            }
                        }
                    }
                }
            }
        }

        Tab {
            id: helloTab
            objectName: "helloTab"
            title: "Hello"

            Item{
                Rectangle{
                    color:"#E8FDDF"
                    width: parent.width
                    height: parent.height
                }

                anchors.fill: parent

                GridLayout {
                    id: gridLayoutHello
                    width: appWindow.width*3/5
                    columns: 2
                    anchors.centerIn: parent

                    Text{
                        id: greetingLabel
                        objectName: "greetingLabel"
                        font.bold: true
                        font.letterSpacing: 1
                        font.pointSize: (appWindow.height + appWindow.width)/50
                        color: "#60D511"
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }

                    Text{
                        id: enterNameLabel
                        font.bold: true
                        font.letterSpacing: 1
                        font.pointSize: (appWindow.height + appWindow.width)/110
                        color: "#0C8F33"
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: qsTr("Введите ваше имя:")
                    }

                    TextField{
                        id: enterNameTextField
                        objectName: "enterNameTextField"
                        font.bold: true
                        font.letterSpacing: 1
                        font.pointSize: (appWindow.height + appWindow.width)/110
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        style: textFieldStyle
                    }

                    Button{
                        id: sayHelloButton
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        text: qsTr("Пусть программа со мной поздоровается")
                        onClicked:{
                            receiver.recieveHelloButtonClick()
                        }
                    }
                }
            }

        }
       }

    // service elements

    MessageDialog {
        id: messageDialog
        title: qsTr("Важно")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }

    Component {
        id: textFieldStyle
        TextFieldStyle
        {
            textColor: "black"
            background: Rectangle {
                radius: height/4
                border.color: "lightgrey"
                border.width: 2
            }
        }
    }

    ListModel {
        id: alarmListModel
    }
}
