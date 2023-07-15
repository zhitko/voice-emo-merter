import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Material 2.14
import QtQuick.Layouts 1.14

import "../../App"
import "../../Components/"
import "../../Components/Buttons"
import "../../Components/FontAwesome"
import "../../Components/Material"

Page {
    id: root
    title: qsTr("Home")

    property alias maleButton: maleButton
    property alias femaleButton: femaleButton

    ColumnLayout {
        id: head
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right

        Rectangle {
            id: welcomeText
            Layout.alignment: "AlignHCenter"
            Layout.fillWidth: true
            Layout.minimumHeight: 130
            Layout.maximumHeight: 130
            color: Colors.transparent

            Rectangle {
                anchors.fill: parent
                anchors.topMargin: 40
                anchors.bottomMargin: 40
                color: Theme.primaryLight.color
            }

            Image {
                id: wave
                anchors.fill: parent
                horizontalAlignment: Image.AlignLeft
                fillMode: Image.TileHorizontally
                source: "qrc:///Assets/Images/wave_long.png"
            }

            Label {
                anchors.centerIn: parent
                text: qsTr("Welcome to Voice Emotionality Meter")
                font.pointSize: 20
                wrapMode: Text.WordWrap
                horizontalAlignment: "AlignHCenter"
                color: Theme.primaryDark.titleColor
            }
        }
    }

    ColumnLayout {
        spacing: 25
        anchors.top: head.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20

        LabelToolButton {
            id: maleButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Male voices")
            font.pointSize: 15
        }

        LabelToolButton {
            id: femaleButton
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: qsTr("Female voices")
            font.pointSize: 15
        }
    }
}
