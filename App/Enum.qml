pragma Singleton
import QtQuick 2.14

Item {
    readonly property string pageHome: "../Pages/Home/Home.qml"
    readonly property string pageSettings: "../Pages/Settings/Settings.qml"
    readonly property string pageTestRecord: "../Pages/TestRecord/TestRecord.qml"
    readonly property string pageTrainingRecord: "../Pages/TrainingRecord/TrainingRecord.qml"
    readonly property string pageResults: "../Pages/Results/Results.qml"
    readonly property string pagePolicy: "../Pages/Policy/Policy.qml"
    readonly property string pageAddExample: "../Pages/AddExample/AddExample.qml"
    readonly property string pageFiles: "../Pages/Files/Files.qml"

    readonly property string pageTests: "../Pages/Tests/Tests.qml"
    readonly property string pageTraining: "../Pages/Training/Training.qml"

    readonly property string modeTraining: "mode_training"
}
