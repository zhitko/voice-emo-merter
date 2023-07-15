import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

import "../../App"
import "../../Components/"
import "../../Components/Buttons"
import "../../Components/FontAwesome"
import "../../Components/Material"

Page {
    id: root
    title: qsTr("Choose or Create a New Voice")

//    property alias generalizedButton: generalizedButton
    property alias filesList: filesList

//    LabelToolButton {
//        id: generalizedButton

//        anchors.top: parent.top
//        anchors.topMargin: 20
//        anchors.right: parent.right
//        anchors.rightMargin: 30
//        anchors.left: parent.left
//        anchors.leftMargin: 30
//        height: 40

//        text: qsTr("Emotionality testing by generalized voice")
//        font.pointSize: 14

//        primaryActiveColor: Theme.secondary.color
//        primaryHoverColor: Theme.secondaryDark.color
//        primaryPressColor: Theme.secondaryLight.color
//        secondaryActiveColor: Theme.primary.color
//        secondaryHoverColor: Theme.primaryDark.color
//        secondaryPressColor: Theme.primaryLight.color
//        labelActiveColor: Theme.secondary.titleColor
//        labelHoverColor: Theme.secondaryDark.titleColor
//        labelPressColor: Theme.secondaryLight.titleColor
//    }

    FilesList {
        id: filesList
        showAddButton: true

//        anchors.top: generalizedButton.bottom
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }
}
