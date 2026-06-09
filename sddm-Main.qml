import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root
    width: Screen.width
    height: Screen.height
    color: "#0a0a08"

    FontLoader { id: monoFont; source: "assets/ShareTechMono-Regular.ttf" }

    property string accentColor:  "#d4a017"
    property string dimColor:     "#7a5c0a"
    property string bgPanel:      "#0f0f0b"

    Item {
        anchors.fill: parent

        Repeater {
            model: 30
            Rectangle {
                x: index * (root.width / 30)
                width: 1; height: root.height
                color: "#0d0d0a"
            }
        }
        Repeater {
            model: 20
            Rectangle {
                y: index * (root.height / 20)
                width: root.width; height: 1
                color: "#0d0d0a"
            }
        }

        Rectangle {
            id: scanLine
            width: root.width; height: 2
            color: "#1a1500"; opacity: 0.6; y: 0
            SequentialAnimation on y {
                loops: Animation.Infinite
                NumberAnimation { from: 0; to: root.height; duration: 4000; easing.type: Easing.Linear }
            }
        }

        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.strokeStyle = "#d4a017"; ctx.lineWidth = 1.5; ctx.globalAlpha = 0.4
                var s = 40
                ctx.beginPath(); ctx.moveTo(0,s); ctx.lineTo(0,0); ctx.lineTo(s,0); ctx.stroke()
                ctx.beginPath(); ctx.moveTo(width-s,0); ctx.lineTo(width,0); ctx.lineTo(width,s); ctx.stroke()
                ctx.beginPath(); ctx.moveTo(0,height-s); ctx.lineTo(0,height); ctx.lineTo(s,height); ctx.stroke()
                ctx.beginPath(); ctx.moveTo(width-s,height); ctx.lineTo(width,height); ctx.lineTo(width,height-s); ctx.stroke()
            }
        }
    }

    Rectangle {
        id: topBar
        anchors.top: parent.top; anchors.left: parent.left; anchors.right: parent.right
        height: 44; color: "#0c0c09"
        border.color: accentColor; border.width: 1

        RowLayout {
            anchors.fill: parent; anchors.leftMargin: 20; anchors.rightMargin: 20; spacing: 24

            Text {
                text: "MILITECH"; font.family: monoFont.name
                font.pixelSize: 14; font.letterSpacing: 4; color: accentColor
            }
            Text {
                text: "// SECURE ACCESS TERMINAL // AUTH REQUIRED"
                font.family: monoFont.name; font.pixelSize: 10
                font.letterSpacing: 2; color: dimColor; Layout.fillWidth: true
            }

            Text { text: "SESSION"; font.family: monoFont.name; font.pixelSize: 9; font.letterSpacing: 2; color: dimColor }
            ComboBox {
                id: sessionCombo
                model: sessionModel; index: sessionModel.lastIndex
                font.family: monoFont.name; font.pixelSize: 11
                implicitWidth: 140; implicitHeight: 28
                color: "#0a0a08"; textColor: "#d4a017"; borderColor: "#d4a017"
                hoverColor: "#1a1500"; focusColor: "#d4a017"; menuColor: "#0a0a08"
            }

            Text { text: "LAYOUT"; font.family: monoFont.name; font.pixelSize: 9; font.letterSpacing: 2; color: dimColor }
            ComboBox {
                id: layoutCombo
                model: keyboardModel; index: keyboardModel.currentLayout
                font.family: monoFont.name; font.pixelSize: 11
                implicitWidth: 110; implicitHeight: 28
                color: "#0a0a08"; textColor: "#d4a017"; borderColor: "#d4a017"
                hoverColor: "#1a1500"; focusColor: "#d4a017"; menuColor: "#0a0a08"
            }

            Item { Layout.fillWidth: true }

            Text {
                id: clockLabel; font.family: monoFont.name
                font.pixelSize: 13; color: accentColor; font.letterSpacing: 2
            }
            Timer {
                interval: 1000; running: true; repeat: true
                onTriggered: clockLabel.text = Qt.formatTime(new Date(), "hh:mm:ss")
                Component.onCompleted: clockLabel.text = Qt.formatTime(new Date(), "hh:mm:ss")
            }
        }
    }

    Column {
        anchors.left: parent.left; anchors.leftMargin: 60
        anchors.verticalCenter: parent.verticalCenter; spacing: 4

        Text {
            id: bigClock; font.family: monoFont.name
            font.pixelSize: 72; color: accentColor; font.letterSpacing: 4
        }
        Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: bigClock.text = Qt.formatTime(new Date(), "hh:mm")
            Component.onCompleted: bigClock.text = Qt.formatTime(new Date(), "hh:mm")
        }

        Text {
            id: dateLabel; font.family: monoFont.name
            font.pixelSize: 13; color: dimColor; font.letterSpacing: 3
        }
        Timer {
            interval: 60000; running: true; repeat: true
            onTriggered: dateLabel.text = Qt.formatDate(new Date(), "ddd dd MMM yyyy").toUpperCase()
            Component.onCompleted: dateLabel.text = Qt.formatDate(new Date(), "ddd dd MMM yyyy").toUpperCase()
        }

        Text {
            text: "NIGHT CITY // NC-UTC+1"; font.family: monoFont.name
            font.pixelSize: 10; color: "#4a3a08"; font.letterSpacing: 2
        }
    }

    Rectangle {
        id: loginPanel
        width: 620
        anchors.right: parent.right; anchors.rightMargin: 80
        anchors.verticalCenter: parent.verticalCenter
        height: contentCol.implicitHeight + 60
        color: bgPanel; border.color: accentColor; border.width: 1

        SequentialAnimation on border.width {
            loops: Animation.Infinite
            NumberAnimation { from: 1; to: 2; duration: 1500 }
            NumberAnimation { from: 2; to: 1; duration: 1500 }
        }

        Canvas {
            anchors.fill: parent
            onPaint: {
                var ctx = getContext("2d")
                ctx.strokeStyle = "#d4a017"; ctx.lineWidth = 2
                var s = 16
                ctx.beginPath(); ctx.moveTo(0,s); ctx.lineTo(0,0); ctx.lineTo(s,0); ctx.stroke()
                ctx.beginPath(); ctx.moveTo(width-s,0); ctx.lineTo(width,0); ctx.lineTo(width,s); ctx.stroke()
                ctx.beginPath(); ctx.moveTo(0,height-s); ctx.lineTo(0,height); ctx.lineTo(s,height); ctx.stroke()
                ctx.beginPath(); ctx.moveTo(width-s,height); ctx.lineTo(width,height); ctx.lineTo(width,height-s); ctx.stroke()
            }
        }

        Column {
            id: contentCol
            anchors.centerIn: parent
            width: parent.width - 60; spacing: 24

            property int selectedUser: 0
            property string selectedUserName: userModel.lastUser || ""

            Text {
                text: "[ IDENTITY VERIFICATION ]"; font.family: monoFont.name
                font.pixelSize: 12; font.letterSpacing: 4; color: accentColor
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "SELECT OPERATIVE"; font.family: monoFont.name
                font.pixelSize: 9; font.letterSpacing: 3; color: dimColor
            }

            ListView {
                id: userList
                width: parent.width; height: 170
                orientation: ListView.Horizontal; spacing: 16; clip: true
                model: userModel

                delegate: Rectangle {
                    width: 140; height: 170
                    color: contentCol.selectedUser === index ? "#1a1500" : "#0c0c09"
                    border.color: contentCol.selectedUser === index ? accentColor : dimColor
                    border.width: contentCol.selectedUser === index ? 2 : 1

                    Behavior on border.width { NumberAnimation { duration: 150 } }
                    Behavior on color { ColorAnimation { duration: 150 } }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            contentCol.selectedUser = index
                            contentCol.selectedUserName = model.name || ""
                            passwordField.forceActiveFocus()
                        }
                    }

                    Column {
                        anchors.fill: parent; anchors.margins: 10; spacing: 8

                        Rectangle {
                            width: parent.width; height: 100; color: "#0a0a08"
                            border.color: contentCol.selectedUser === index ? accentColor : "#2a1f00"
                            border.width: 1

                            Canvas {
                                anchors.centerIn: parent; width: 56; height: 66
                                onPaint: {
                                    var ctx = getContext("2d")
                                    ctx.fillStyle = contentCol.selectedUser === index ? "#d4a017" : "#4a3a08"
                                    ctx.beginPath(); ctx.arc(28, 20, 14, 0, Math.PI * 2); ctx.fill()
                                    ctx.beginPath()
                                    ctx.moveTo(4, 62); ctx.quadraticCurveTo(4, 40, 28, 38)
                                    ctx.quadraticCurveTo(52, 40, 52, 62); ctx.fill()
                                }
                            }
                        }

                        Text {
                            text: (model.name || "USER").toUpperCase()
                            font.family: monoFont.name; font.pixelSize: 11; font.letterSpacing: 2
                            color: contentCol.selectedUser === index ? accentColor : dimColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            elide: Text.ElideRight; width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                        }

                        Text {
                            text: "[ SELECTED ]"
                            font.family: monoFont.name; font.pixelSize: 9; font.letterSpacing: 2
                            color: accentColor
                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                            visible: contentCol.selectedUser === index
                        }
                    }
                }
            }

            Text {
                text: "ACCESS CODE"; font.family: monoFont.name
                font.pixelSize: 9; font.letterSpacing: 3; color: dimColor
                topPadding: 20
            }

            Rectangle {
                width: parent.width; height: 40; color: "#0a0a08"
                border.color: passwordField.activeFocus ? accentColor : dimColor
                border.width: passwordField.activeFocus ? 2 : 1
                Behavior on border.color { ColorAnimation { duration: 200 } }

                Row {
                    anchors.fill: parent; anchors.margins: 8; spacing: 8

                    Text {
                        text: ">"; font.family: monoFont.name; font.pixelSize: 14
                        color: accentColor; anchors.verticalCenter: parent.verticalCenter
                    }

                    Item {
                        width: parent.width - 24; height: parent.height

                        TextInput {
                            id: passwordField
                            anchors.fill: parent
                            echoMode: TextInput.Password; passwordCharacter: "•"
                            font.family: monoFont.name; font.pixelSize: 13; color: accentColor
                            verticalAlignment: TextInput.AlignVCenter; focus: true

                            Keys.onReturnPressed: {
                                sddm.login(contentCol.selectedUserName, text, sessionCombo.index)
                            }
                        }

                        Text {
                            anchors.fill: parent
                            text: "ENTER ACCESS CODE"; font.family: monoFont.name
                            font.pixelSize: 13; color: "#3a2e06"
                            verticalAlignment: Text.AlignVCenter
                            visible: passwordField.text.length === 0
                        }
                    }
                }
            }

            Row {
                width: parent.width; spacing: 12

                Rectangle {
                    width: (parent.width - 24) / 3; height: 36
                    color: loginBtn.containsMouse ? "#1a1500" : "#0a0a08"
                    border.color: accentColor; border.width: 1
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent; text: "[ LOGIN ]"
                        font.family: monoFont.name; font.pixelSize: 11
                        font.letterSpacing: 2; color: accentColor
                    }
                    MouseArea {
                        id: loginBtn; anchors.fill: parent; hoverEnabled: true
                        onClicked: { sddm.login(contentCol.selectedUserName, passwordField.text, sessionCombo.index) }
                    }
                }

                Rectangle {
                    width: (parent.width - 24) / 3; height: 36
                    color: rebootBtn.containsMouse ? "#1a0000" : "#0a0a08"
                    border.color: "#cc0000"; border.width: 1
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent; text: "[ REBOOT ]"
                        font.family: monoFont.name; font.pixelSize: 11
                        font.letterSpacing: 2; color: "#cc0000"
                    }
                    MouseArea { id: rebootBtn; anchors.fill: parent; hoverEnabled: true; onClicked: sddm.reboot() }
                }

                Rectangle {
                    width: (parent.width - 24) / 3; height: 36
                    color: pwrBtn.containsMouse ? "#1a0000" : "#0a0a08"
                    border.color: "#cc0000"; border.width: 1
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Text {
                        anchors.centerIn: parent; text: "[ POWER ]"
                        font.family: monoFont.name; font.pixelSize: 11
                        font.letterSpacing: 2; color: "#cc0000"
                    }
                    MouseArea { id: pwrBtn; anchors.fill: parent; hoverEnabled: true; onClicked: sddm.powerOff() }
                }
            }

            Text {
                id: errorMsg; width: parent.width; text: ""
                font.family: monoFont.name; font.pixelSize: 10
                font.letterSpacing: 2; color: "#cc0000"
                horizontalAlignment: Text.AlignHCenter; visible: text !== ""
            }
        }
    }

    Connections {
        target: sddm
        function onLoginFailed() {
            errorMsg.text = "// ACCESS DENIED — INVALID CREDENTIALS //"
            passwordField.text = ""
            passwordField.forceActiveFocus()
        }
    }
}
