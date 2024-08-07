import QtQuick 2.14
import QtQuick.Controls 2.14

import "../../App"

FilesForm {
    id: root
    objectName: Enum.pageFiles

    function actionFn(value, name) {
        console.log("FilesForm actionFn: ", value, name)
        Bus.openCalmTemplate(value)
        Bus.setActiveTemplateName(name)
        Bus.cleanAngryTemplate()
        Bus.stackView.pop()
        Bus.goApplicationModePage(true)
    }

    StackView.onActivated: {
        console.log("FilesForm.StackView.onActivated")
        Bus.hideAllBottomActions()
        root.filesList.setActionFunction(root.actionFn)
        root.filesList.setGetFilesFunction(Bus.getTemplates)
        root.filesList.loadFiles()
    }
}
