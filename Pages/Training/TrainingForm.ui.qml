import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.Styles 1.4
import QtCharts 2.3
import QtQuick.Layouts 1.14

import "../../App"
import "../../Components"
import "../../Components/Material"
import "../../Components/FontAwesome"

Page {
    id: root
    title: Bus.recordPath !== "" ?
               qsTr("Result of Emotionality Measurement") :
               qsTr("Preparing to Measure Emotionality")

    ResultBar {
        id: resultBar

        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: voiceChart.top
    }

    VoiceChartGraph {
        id: voiceChart

        height: parent.height / 3

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: voiceChartFooter.top
        anchors.bottomMargin: -25
    }

    VoiceChartFooter {
        id: voiceChartFooter

        anchors.bottom: metricsHeader.top
        anchors.left: voiceChart.left
        anchors.leftMargin: voiceChart.plotArea.x - 1
        width: voiceChart.plotArea.width
    }

    MetricsHeader {
        id: metricsHeader

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
