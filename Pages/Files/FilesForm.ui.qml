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

    property alias filesList: filesList

    FilesList {
        id: filesList
        titleText: qsTr("Choose a personal voice to test emotionality")
        showAddButton: true
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: parent.bottom
    }
}
