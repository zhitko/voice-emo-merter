import QtQuick 2.14
import QtQuick.Controls 2.14

import "../../App"

FilesForm {
    id: root
    objectName: Enum.pageFiles

    StackView.onActivated: {
        console.log("FilesForm.StackView.onActivated")
        Bus.hideAllBottomActions()
        root.filesList.loadFiles()
    }

//    generalizedButton.onClicked: {
//        Bus.setActiveTemplateName("")
//        Bus.stackView.pop()
//        Bus.openTemplates()
//        Bus.goTraining()
//    }
}
