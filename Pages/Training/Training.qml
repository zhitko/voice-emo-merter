import QtQuick 2.14
import QtQuick.Controls 2.14
import QtCharts 2.14

import "../../Components"
import "../../App"

TrainingForm {
    id: root
    objectName: Enum.pageTraining

    property int minPitch: 0
    property int maxPitch: 1

    StackView.onActivated: {
        console.log("Training.StackView.onActivated")
        Bus.hideAllBottomActions()
        Bus.showPlayButton = true
        Bus.showSaveResultsButton = Bus.recordPath !== ""
        Bus.showRecordButton = true
        Bus.showOpenButton = true

        loadSettings()

        initializeData()
    }

    function initializeData() {
    }

    function loadSettings() {
        let settings = Bus.getSettingsMap()
    }
}
