import QtQuick 2.14
import QtQuick.Controls 2.14

import "../../App"

TestsForm {
    id: root
    objectName: Enum.pageTests

    function actionFn(value, name) {
        console.log("FilesForm actionFn: ", value, name)
        Bus.openFileDialogProceed(value)
    }

    StackView.onActivated: {
        console.log("FilesForm.StackView.onActivated")
        Bus.hideAllBottomActions()
        root.filesList.setActionFunction(root.actionFn)
        root.filesList.setGetFilesFunction(Bus.getTests)
        root.filesList.loadFiles()
    }
}
