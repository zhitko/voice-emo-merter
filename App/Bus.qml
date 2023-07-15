pragma Singleton
import QtQuick 2.14

import intondemo.backend 1.0

Item {
    id: root

    property var stackView
    property var settings

    property bool showRecordButton: false
    property bool canRecordButton: true
    property bool showPlayButton: false
    property bool showSaveResultsButton: false
    property bool canPlayButton: true
    property bool showOpenButton: false
    property bool canOpenButton: true
    property bool canOpenTemplateButton: true

    property string currentPage: ""

    property string templateMalePath: "male"
    property string templateFemalePath: "female"
    property bool isMaleTemplate: true
    property string activeTemplateName: ""
    property double compareResult: 0
    property string compareDate: ""

    property string recordPath: ""
    property string templatePath: ""
    property string angryTemplatePath: ""
    property string calmTemplatePath: ""
    property var results: ({})

    property var pointsHistory: []
    property var marksHistory: []

    property string applicationMode: Enum.modeTraining

    property string angryKey: "angry"
    property string calmKey: "calm"

    Backend {
        id: backend
    }

    function setIsMale(isMale) {
        isMaleTemplate = isMale
        backend.setApplicationMode(isMale)
    }

    function getSettings() {
        console.log("Action.getSettings")
        return backend.getSettings()
    }

    function getSettingValue(id) {
        console.log("Action.getSettingValue")
        return backend.getSettingValue(id)
    }

    function getSettingsMap() {
        console.log("Action.getSettingsMap")
        let settings = getSettings()
        let settingsMap = {}

        settings.forEach(setting => {
            settingsMap[setting.key] = setting.value
        });

        return settingsMap
    }

    function setSettings(name, value) {
        console.log("Action.setSettings", name, value)
        return backend.setSettings(name, value)
    }

    function getSavedResults() {
        console.log("Action.getSavedResults")
        return backend.getSavedResults()
    }

    function saveResults() {
        console.log("Action.getSavedResults")
        return backend.saveResult(results)
    }

    function setResultItem(key, value) {
        console.log("Action.addResult", key, value)
        results[key] = value
    }

    function getExamples() {
        console.log("Action.getExamples")
        return backend.getWaveFilesList()
    }

    function getTemplates() {
        console.log("Action.getTemplates", isMaleTemplate)
        return backend.getWaveFilesList(isMaleTemplate ? templateMalePath : templateFemalePath)
    }

    function copyToExamples(filePath, name) {
        console.log("Action.copyToExamples: ", filePath, name)
        return backend.copyToExamples(filePath, name)
    }

    function copyToTemplates(filePath, name) {
        console.log("Action.copyToExamples: ", filePath, name)
        let subPath = isMaleTemplate ? templateMalePath : templateFemalePath
        return backend.copyToTemplates(filePath, subPath, name)
    }

    function setCompareResult(value) {
        root.compareResult = value
        root.compareDate = new Date().toLocaleDateString(undefined, { year:"numeric", month:"long", day:"numeric"})
    }

    function cleanCompareResult() {
        root.compareResult = 0
        root.compareDate = ""
    }

    /*---------------------------------------------------------
      History
      ---------------------------------------------------------*/
    function isPointInArray(array, value) {
        console.log("isPointInArray: ", value.x, value.y)
        return !!array.find((element) => {
            console.log("isPointInArray find: ", element.x, element.y)
            return element.x === value.x && element.y === value.y
        })
    }

    function addPointToHistory(value) {
        console.log("addPointToHistory: ", value.x, value.y)
        if (isPointInArray(root.pointsHistory, value)) return

        root.pointsHistory.push(value)
        addMarkToHistory(value)
    }

    function addMarkToHistory(value) {        
        console.log("addMarkToHistory: ", value.x, value.y)

        let r = Math.sqrt(value.x*value.x + value.y*value.y)
        if (r > 1) r = 1
        let mark = 10 - r * 10
        console.log("addMarkToHistory mark: ", mark)

        root.marksHistory.push(mark)
    }

    function cleanPointHistory() {
        root.pointsHistory = []
    }

    function cleanMarkHistory() {
        root.marksHistory = []
    }

    function getPointHistory() {
        return root.pointsHistory
    }

    function getMarkHistory() {
        return root.marksHistory
    }

    function getMarkHistoryLastElement() {
        return root.marksHistory[root.marksHistory.length - 1]
    }

    function getMarkAvg() {
        return root.marksHistory.reduce((t, v) => { return t += v}) / root.marksHistory.length
    }

    function cleanHistory() {
        cleanPointHistory()
        cleanMarkHistory()
    }

    /*---------------------------------------------------------
      Actions
      ---------------------------------------------------------*/
    function openTemplates() {
        if (isMaleTemplate) {
            openMaleAngryTemplate()
            openMaleCalmTemplate()
        } else {
            openFemaleAngryTemplate()
            openFemaleCalmTemplate()
        }
    }

    function openMaleAngryTemplate() {
        openAngryTemplate("male_angry.wav")
    }

    function openMaleCalmTemplate() {
        openCalmTemplate("male_calm.wav")
    }

    function openFemaleAngryTemplate() {
        openAngryTemplate("female_angry.wav")
    }

    function openFemaleCalmTemplate() {
        openCalmTemplate("female_calm.wav")
    }

    function openCalmTemplate(path) {
        root.templatePath = root.calmTemplatePath = openTemplate(calmKey, path)
    }

    function openAngryTemplate(path) {
        root.angryTemplatePath = openTemplate(angryKey, path)
    }

    function cleanCalmTemplate() {
        root.templatePath = root.calmTemplatePath = ""
        cleanCompareResult()
    }

    function cleanAngryTemplate() {
        root.angryTemplatePath = ""
        cleanCompareResult()
    }

    function cleanRecord() {
        root.recordPath = ""
        cleanCompareResult()
    }

    function openTemplate(key, path) {
        console.log("openTemplate: ", key, path)
        Bus.templatePath = path
        return backend.openTemplate(key, path)
    }

    function setActiveTemplateName(name) {
        root.activeTemplateName = name
    }

    function getActiveTemplateName() {
        return root.activeTemplateName
    }


    function setApplicationModePath(path) {
        console.log("setApplicationModePath: Record Path")
        setRecordPath(path)
    }

    function setRecordPath(path) {
        root.recordPath = path
    }

    function setTemplatePath(path) {
        root.templatePath = path
    }

    function startRecord(reloadPath = true) {
        console.log("Action.startRecord")

        let path = backend.startStopRecordWaveFile(reloadPath)
        if (reloadPath) {
            setApplicationModePath(path)
        }

        root.canRecordButton = false
        root.canPlayButton = false
        root.canOpenTemplateButton = false
        root.canOpenButton = false
        return path
    }

    function stopRecord(reloadPath = true) {
        console.log("Action.stopRecord")
        let path = backend.startStopRecordWaveFile(reloadPath)

        if (reloadPath) {
            console.log("Action.stopRecord stackView.pop")
            stackView.pop()
            if (stackView.currentItem.objectName === "../Pages/Training/Training.qml") {
                console.log("Action.stopRecord stackView.pop", stackView.currentItem.objectName)
                stackView.pop()
            }
            goApplicationModePage()
        }

        root.canRecordButton = true
        root.canOpenTemplateButton = true
        root.canPlayButton = true
        root.canOpenButton = true
        return path
    }

    function play(playing, isTemplate) {
        console.log("Action.play : ", playing)
        if (!isTemplate && root.recordPath !== "") {
            console.log("Try play file : ", root.recordPath)
            backend.playWaveFile(root.recordPath, playing)
        } else
        if (isTemplate && root.templatePath !== "") {
            console.log("Try play file : ", root.templatePath)
            backend.playWaveFile(root.templatePath, playing)
        }
    }

    function openFileDialog() {
        console.log("Action.openFileDialog")
        let newPath = backend.openFileDialog()
        console.log("Action.openFileDialog: newPath = ", newPath)
        let isChanged = root.recordPath !== newPath
        console.log("Action.openFileDialog: isChanged = ", isChanged)

        if (isChanged) {
            stackView.pop()
            if (stackView.currentItem.objectName === "../Pages/Training/Training.qml" ||
                    stackView.currentItem.objectName === "../Pages/Test/Test.qml") {
                console.log("Action.stopRecord stackView.pop", stackView.currentItem.objectName)
                stackView.pop()
            }
            setApplicationModePath(newPath)
            goApplicationModePage(true)
        }
    }

    function openTemplateFileDialog() {
        console.log("Action.openTemplateFileDialog")
        let newPath = backend.openFileDialog()
        console.log("Action.openTemplateFileDialog: newPath = ", newPath)
        let isChanged = root.templatePath !== newPath
        console.log("Action.openTemplateFileDialog: isChanged = ", isChanged)
        root.templatePath = newPath

        if (isChanged) {
            goApplicationModePage(true)
        }
    }

    /*---------------------------------------------------------
      Data processing
      ---------------------------------------------------------*/

    function getLength(isTemplate) {
        if (!isTemplate && root.recordPath !== "") {
            return backend.getWaveLength(root.recordPath, isTemplate)
        } else
        if (isTemplate && root.templatePath !== "") {
            return backend.getWaveLength(root.templatePath, isTemplate)
        } else {
            return 0
        }
    }

    function getWaveData() {
        if (root.recordPath !== "") {
            return backend.getWaveData(root.recordPath)
        } else {
            return []
        }
    }

    function getSegmentsByIntensity() {
        if (root.recordPath !== "") {
            return backend.getSegmentsByIntensity(root.recordPath)
        } else {
            return []
        }
    }

    function getPitchData() {
        if (root.recordPath !== "") {
            return backend.getPitchDataCutted(root.recordPath)
        } else {
            return []
        }
    }

    function getFullPitchData() {
        if (root.recordPath !== "") {
            return backend.getPitchFullData(root.recordPath)
        } else {
            return []
        }
    }

    function getPitchMinMax() {
        return backend.getPitchMinMax()
    }

    function getOctavesData(isTemplate, isAngry = true) {
        if (!isTemplate && root.recordPath === "") return []
        if (isTemplate && isAngry && root.angryTemplatePath === "") return []
        if (isTemplate && !isAngry && root.calmTemplatePath === "") return []

        return backend.getPitchFrequencySegmentsCount(
            isTemplate ? (isAngry ? root.angryKey : root.calmKey) : root.recordPath,
            isTemplate
        )
    }

    function getOctavesCategories() {
        return backend.getOctavesCategories(Bus.applicationMode === Enum.modeTraining)
    }

    function getOctavesOptimazedCategories() {
        return backend.getOctavesOptimazedCategories()
    }

    function getFullOctavesData() {
        if (root.recordPath !== "") {
            return backend.getPitchFrequencyCount(root.recordPath)
        } else {
            return []
        }
    }

    function getFullTemplateOctavesData() {
        if (root.templatePath !== "") {
            return backend.getTemplatePitchFrequencyCount(root.templatePath)
        } else {
            return []
        }
    }

    function getDerivativeData(isFull) {
        if (root.recordPath !== "") {
            return backend.getPitchDerivativeCount(root.recordPath, isFull)
        } else {
            return []
        }
    }

    function getTemplateDerivativeData(isFull) {
        if (root.templatePath !== "") {
            return backend.getTemplatePitchDerivativeCount(root.templatePath, isFull)
        } else {
            return []
        }
    }

    function getPitchOcavesMetrics(cutted, isTemplate) {
        if (isTemplate && root.templatePath === "") return []
        if (!isTemplate && root.recordPath === "") return []

        return backend.getPitchOcavesMetrics(
            isTemplate ? root.templatePath : root.recordPath,
            cutted,
            isTemplate
        )
    }

    function getSpectrumData(isTemplate, isAngry = true) {
        if (!isTemplate && root.recordPath === "") return []
        if (isTemplate && isAngry && root.angryTemplatePath === "") return []
        if (isTemplate && !isAngry && root.calmTemplatePath === "") return []

        return backend.getSpectrumData(
            isTemplate ? (isAngry ? root.angryKey : root.calmKey) : root.recordPath,
            isTemplate
        )
    }

    function getMetrics() {
        if (root.recordPath === "" || root.calmTemplatePath === "")
            return [
                "C (min/record/max): 0/0/0", "B (min/record/max): 0/0/0"
            ]

        if (root.angryTemplatePath === "") {
            return backend.getMetricsSingle(root.recordPath, root.calmKey, root.isMaleTemplate)
        } else {
            return backend.getMetrics(root.recordPath, root.angryKey, root.calmKey)
        }
    }

    /*---------------------------------------------------------
      Navigation
      ---------------------------------------------------------*/

    function isPage(page) {
        return currentPage === page
    }

    function goToPage(page, params = {}, force = false) {
        console.log("Bus.goToPage stackView.depth: ", stackView.depth)
        if (currentPage !== page || force) {
            currentPage = page
            stackView.push(page, params)
            console.warn("Bus.goToPage currentPage: ", currentPage)
            validatePage()
        }
    }

    function goBack() {
        if (stackView.depth > 1)
        {
            stackView.pop()
            currentPage = stackView.currentItem.objectName
            console.warn("Bus.goBack currentPage: ", currentPage)
            validatePage()
        }
    }

    function validatePage() {
        if (!currentPage) {
            console.warn("Current page do not have objectName: ", stackView.currentItem)
        }
    }

    function isHomePage() {
        return isPage(Enum.pageHome)
    }

    function goHome() {
        goToPage(Enum.pageHome)
    }

    function isRecordPage() {
        return isPage(Enum.pageTestRecord) || isPage(Enum.pageTrainingRecord)
    }

    function goRecord(mode, startRecording, firstRun = true) {
        goToPage(Enum.pageTrainingRecord, {
            startRecording: startRecording,
            showOpenButton: !Bus.isMobile(),
            firstRun: firstRun
        })
    }

    function goApplicationModePage(force = false) {
        goTraining(force)
    }

    function isTestPage() {
        return isPage(Enum.pageTest)
    }

    function goTest(force = false) {
        goToPage(Enum.pageTest, {}, force)
    }

    function isTrainingPage() {
        return isPage(Enum.pageTraining)
    }

    function goTraining(force = false) {
        goToPage(Enum.pageTraining, {}, force)
    }

    function isSettingsPage() {
        return isPage(Enum.pageSettings)
    }

    function goSettings() {
        goToPage(Enum.pageSettings)
    }

    function isResultsPage() {
        return isPage(Enum.pageResults)
    }

    function goResults() {
        goToPage(Enum.pageResults)
    }

    function isPolicyPage() {
        return isPage(Enum.pagePolicy)
    }

    function goPolicy() {
        goToPage(Enum.pagePolicy)
    }

    function isAddExamplePage() {
        return isPage(Enum.pageAddExample)
    }

    function goAddExample() {
        goToPage(Enum.pageAddExample)
    }

    function isFiles() {
        return isPage(Enum.pageFiles)
    }

    function goFilesMale() {
        goFiles(true)
    }

    function goFilesFemale() {
        goFiles(false)
    }

    function goFiles(isMale) {
        console.log("Bus.goFiles isMale: ", isMale)
        setIsMale(isMale)
        goToPage(Enum.pageFiles)
    }

    /*---------------------------------------------------------
      Helpers
      ---------------------------------------------------------*/

    function isMobile() {
        return backend.isMobile()
    }

    function hideAllBottomActions() {
        console.log("Bus.hideAllBottomActions")
        root.showRecordButton = false
        root.showPlayButton = false
        root.showOpenButton = false
        root.showSaveResultsButton = false
    }

    function getTimer(interval, parent) {
        let timer = Qt.createQmlObject("import QtQuick 2.0; Timer {}", parent)
        timer.interval = interval
        return timer
    }

    function reinitialize() {
        console.log("Bus::reinitialize")
        cleanRecord()
        cleanCalmTemplate()
        cleanAngryTemplate()
        backend.reinitialize()
    }

}
