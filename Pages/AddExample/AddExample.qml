import QtQuick 2.14
import QtQuick.Controls 2.14

import "../../App"

AddExampleForm {
    id: root
    objectName: Enum.pageTestRecord
    property bool fileRecorded: false
    property string filePath: ""

    StackView.onActivated: {
        console.log("AddExample onActivated")
        Bus.hideAllBottomActions()
    }

    recordButton.onRecordingStarted: (path) => {
        console.log("AddExample onRecordingStarted: ", path)
    }

    recordButton.onRecordingStopped: (path) => {
        console.log("AddExample onRecordingStopped: ", path)
        root.filePath = path
        root.fileRecorded = true
        root.secondStepEnabled = true
        root.textField.focus = true
    }

    saveButton.onClicked: {
        let fileName = textField.text
        console.log("AddExample saveButtonClicked: ", fileName)

        Bus.copyToTemplates(root.filePath, fileName.trim())
        Bus.goBack()
    }
}
