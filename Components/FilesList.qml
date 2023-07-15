import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

import "FontAwesome"
import "Material"
import "../App"

Item {
    property bool enabled: true
    property bool showAddButton: true

    Component.onCompleted: {
        loadFiles()
    }

    function loadFiles() {
        let files = Bus.getTemplates()
        console.log("FilesList loadFiles files=", root.files)
        listModel.clear()
        for(let i in files) {
            console.log("FilesList loadFiles", files[i].name)
            console.log("FilesList loadFiles", files[i].path)
            listModel.append(
                {
                    "name": files[i].name.split(".")[0],
                    "value": files[i].path
                }
            )
        }
    }

    ListModel {
        id: listModel
    }

    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 15
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        anchors.bottomMargin: 5
        color: Theme.primary.color

        Label {
            id: title
            text: qsTr("Choose a personal voice to test emotionality")

            anchors.top: parent.top
            anchors.topMargin: 15
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 15
            color: Theme.primary.textColor
        }

        Rectangle {
            anchors.top: title.bottom
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.topMargin: 15
            anchors.leftMargin: 1
            anchors.rightMargin: 1
            anchors.bottomMargin: 1
            color: Theme.backgound.color

            ListView {
                id: list

                anchors.top: parent.top
                anchors.topMargin: 5
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom

                model: listModel
                spacing: 5
                enabled: enabled
                delegate: ItemDelegate {
                    width: list.width
                    onClicked: {
                        console.log("FilesList onClicked: ", value, name)
                        Bus.openCalmTemplate(value)
                        Bus.setActiveTemplateName(name)
                        Bus.cleanAngryTemplate()
                        Bus.stackView.pop()
                        Bus.goApplicationModePage(true)
                    }

                    FontAwesomeIconText {
                        icon: FontAwesome.icons.faFileAlt
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.backgound.textColor
                        iconColor: Theme.backgound.textColor
                        iconPointSize: hovered ? 26 : 22
                    }
                }
            }

            FontAwesomeToolButton {
                id: addExample

                hintText: qsTr("Create a New Voice")
                hintColor: Theme.backgound.textColor
                hintVisibleAlways: true

                anchors.right: parent.right
                anchors.rightMargin: 45
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30

                visible: showAddButton
                baseSize: 32

                type: FontAwesome.solid
                icon: FontAwesome.icons.faPlusCircle
                color: Theme.primary.color
                button.onClicked: Bus.goAddExample()
            }
        }
    }
}
