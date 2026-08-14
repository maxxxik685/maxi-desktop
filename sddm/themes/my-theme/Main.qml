import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: container
    width: 1920
    height: 1080
    color: "#1e1e2e"

    // Фоновое изображение
    Image {
        anchors.fill: parent
        source: "tokyo-night-2.jpg"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
    }

    // Индексы текущего выбора
    property int currentUserIndex: userModel.lastIndex >= 0 ? userModel.lastIndex : 0
    property int currentSessionIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0

    // Вспомогательные функции для получения точных имен
    function getUserName(index) {
        if (userModel.rowCount() === 0) return "User";
        var name = userModel.data(userModel.index(index, 0), Qt.UserRole + 1); // RealName / Name
        if (!name) name = userModel.data(userModel.index(index, 0), Qt.DisplayRole);
        return name ? name : "User";
    }

    function getSessionName(index) {
        if (sessionModel.rowCount() === 0) return "Session";
        var name = sessionModel.data(sessionModel.index(index, 0), Qt.DisplayRole);
        if (!name) name = sessionModel.data(sessionModel.index(index, 0), Qt.UserRole + 4); // File / Name
        return name ? name : "Session";
    }

    // Верхняя панель: Переключатели пользователя и сессии
    Row {
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15

        // --- Переключатель Пользователя ---
        Rectangle {
            width: 220
            height: 44
            radius: 22
            color: Qt.rgba(1, 1, 1, 0.2)

            Row {
                anchors.fill: parent

                // Стрелка влево < (без эффекта клика)
                Rectangle {
                    width: 36
                    height: 44
                    color: "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "‹"
                        color: "#c0caf5"
                        font.pixelSize: 22
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (userModel.rowCount() > 0) {
                                currentUserIndex = (currentUserIndex - 1 + userModel.rowCount()) % userModel.rowCount()
                            }
                        }
                    }
                }

                // Название пользователя
                Text {
                    width: 148
                    height: 44
                    text: getUserName(currentUserIndex)
                    color: "#404966"
                    font.pixelSize: 15
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                // Стрелка вправо > (без эффекта клика)
                Rectangle {
                    width: 36
                    height: 44
                    color: "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "›"
                        color: "#c0caf5"
                        font.pixelSize: 22
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (userModel.rowCount() > 0) {
                                currentUserIndex = (currentUserIndex + 1) % userModel.rowCount()
                            }
                        }
                    }
                }
            }
        }

        // --- Переключатель Сессии ---
        Rectangle {
            width: 220
            height: 44
            radius: 22
            color: Qt.rgba(1, 1, 1, 0.2)

            Row {
                anchors.fill: parent

                // Стрелка влево < (без эффекта клика)
                Rectangle {
                    width: 36
                    height: 44
                    color: "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "‹"
                        color: "#c0caf5"
                        font.pixelSize: 22
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (sessionModel.rowCount() > 0) {
                                currentSessionIndex = (currentSessionIndex - 1 + sessionModel.rowCount()) % sessionModel.rowCount()
                            }
                        }
                    }
                }

                // Название сессии
                Text {
                    width: 148
                    height: 44
                    text: getSessionName(currentSessionIndex)
                    color: "#404966"
                    font.pixelSize: 15
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                // Стрелка вправо > (без эффекта клика)
                Rectangle {
                    width: 36
                    height: 44
                    color: "transparent"

                    Text {
                        anchors.centerIn: parent
                        text: "›"
                        color: "#c0caf5"
                        font.pixelSize: 22
                        font.bold: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (sessionModel.rowCount() > 0) {
                                currentSessionIndex = (currentSessionIndex + 1) % sessionModel.rowCount()
                            }
                        }
                    }
                }
            }
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        // Часы
        Text {
            id: clock
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#c0caf5"
            font.pixelSize: 110
            font.bold: true

            function updateTime() {
                text = Qt.formatDateTime(new Date(), "hh:mm")
            }

            Component.onCompleted: updateTime()

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: clock.updateTime()
            }
        }

        // Имя выбранного пользователя над полем ввода
        Text {
            id: userName
            anchors.horizontalCenter: parent.horizontalCenter
            text: getUserName(currentUserIndex)
            color: "#c0caf5"
            font.pixelSize: 26
            font.bold: true
        }

        // Овальные островки
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 12

            // Поле ввода
            TextField {
                id: passwordInput
                width: 240
                height: 44
                echoMode: TextInput.Password
                focus: true

                font.pixelSize: 26
                color: "#c0caf5"
                leftPadding: 17
                rightPadding: 17
                topPadding: 0
                bottomPadding: 5
                verticalAlignment: TextInput.AlignVCenter
                selectByMouse: false
                cursorDelegate: Item {}

                background: Rectangle {
                    color: passwordInput.activeFocus ? Qt.rgba(1, 1, 1, 0.3) : Qt.rgba(1, 1, 1, 0.2)
                    radius: 22
                }

                onAccepted: {
                    sddm.login(getUserName(currentUserIndex), passwordInput.text, currentSessionIndex)
                }
            }

            // Кнопка входа
            Rectangle {
                id: loginButton
                width: 44
                height: 44
                radius: 22
                color: mouseArea.pressed ? Qt.rgba(1, 1, 1, 0.4) : (mouseArea.containsMouse ? Qt.rgba(1, 1, 1, 0.3) : Qt.rgba(1, 1, 1, 0.2))

                Text {
                    anchors.centerIn: parent
                    anchors.verticalCenterOffset: 1
                    text: "→"
                    color: "#c0caf5"
                    leftPadding: 0
                    rightPadding: 0
                    topPadding: 4
                    bottomPadding: 7
                    font.pixelSize: 26
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    renderType: Text.NativeRendering
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        sddm.login(getUserName(currentUserIndex), passwordInput.text, currentSessionIndex)
                    }
                }
            }
        }

        // Сообщение об ошибке
        Text {
            id: errorMessage
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#ff6b6b"
            font.pixelSize: 15
            text: ""
        }
    }

    Connections {
        target: sddm
        onLoginFailed: {
            errorMessage.text = "Неверный пароль"
            passwordInput.text = ""
            passwordInput.focus = true
        }
    }
}
