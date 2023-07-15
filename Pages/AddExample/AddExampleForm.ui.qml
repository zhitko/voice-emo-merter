import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

import "../../App"
import "../../Components/"
import "../../Components/Material"
import "../../Components/Buttons"
import "../../Components/FontAwesome"

Page {
    id: root
    title: qsTr("")

    property alias recordButton: recordButton
    property alias saveButton: saveButton
    property alias textField: textField

    property bool secondStepEnabled: false

    Label {
        id: title

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20

        text: qsTr("Create a sample voice for a new persona")
        font.pointSize: 18
        wrapMode: "WordWrap"
        horizontalAlignment: "AlignHCenter"
    }

    Label {
        id: firstStepLabel

        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: title.bottom
        anchors.topMargin: 40

        text: qsTr("Speak in a calm voice")
        font.pointSize: 15

        enabled: !secondStepEnabled
    }

    Rectangle {
        anchors.right: firstStepLabel.left
        anchors.rightMargin: 10
        anchors.verticalCenter: firstStepLabel.verticalCenter
        color: Theme.primaryLight.color
        height: 36
        width: height
        radius: height / 2

        Rectangle {
            anchors.fill: parent
            anchors.margins: 2
            color: Theme.primaryLight.textColor

            height: parent.height - 8
            width: height
            radius: height / 2

            Label {
                anchors.centerIn: parent
                text: qsTr("1")
                font.pointSize: 15
                enabled: !secondStepEnabled
            }
        }
    }

    AnimatedRecordButton {
        id: recordButton
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: firstStepLabel.bottom
        anchors.topMargin: 20

        height: 180
        width: height
        reloadPath: false
        enabled: !fileRecorded
        opacity: !fileRecorded ? 1 : 0.3
    }

    Label {
        id: recordButtonHint
        anchors.top: recordButton.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        text: recordButton.checked ?
                  qsTr("Click to stop recording") :
                  qsTr("Click to start recording")
        font.pointSize: 15
        wrapMode: Text.WordWrap
        horizontalAlignment: "AlignHCenter"
        opacity: !fileRecorded ? 1 : 0.3
    }

    Rectangle {
        id: saparator

        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: recordButtonHint.bottom
        anchors.topMargin: 20

        height: 5

        color: Theme.primaryLight.color
    }

    Label {
        id: secondStepLabel

        enabled: secondStepEnabled

        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: saparator.bottom
        anchors.topMargin: 20

        text: qsTr("Print his name")
        font.pointSize: 15
    }

    Rectangle {
        anchors.right: secondStepLabel.left
        anchors.rightMargin: 10
        anchors.verticalCenter: secondStepLabel.verticalCenter
        color: Theme.primaryLight.color
        height: 36
        width: height
        radius: height / 2

        Rectangle {
            anchors.fill: parent
            anchors.margins: 2
            color: Theme.primaryLight.textColor

            height: parent.height - 8
            width: height
            radius: height / 2

            Label {
                anchors.centerIn: parent
                text: qsTr("2")
                font.pointSize: 15
                enabled: secondStepEnabled
            }
        }
    }

    TextField {
        id: textField
        text: ""
        font.pointSize: 15

        enabled: secondStepEnabled

        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: secondStepLabel.bottom
        anchors.topMargin: 20
    }

    LabelToolButton {
        id: saveButton

        anchors.top: textField.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 100

        enabled: textField.text != ""

        text: qsTr("Save")
        font.pointSize: 15

        primaryActiveColor: Theme.secondary.color
        primaryHoverColor: Theme.secondaryDark.color
        primaryPressColor: Theme.secondaryLight.color
        secondaryActiveColor: Theme.primary.color
        secondaryHoverColor: Theme.primaryDark.color
        secondaryPressColor: Theme.primaryLight.color
        labelActiveColor: Theme.secondary.titleColor
        labelHoverColor: Theme.secondaryDark.titleColor
        labelPressColor: Theme.secondaryLight.titleColor
    }

}
