#include "backend.h"

#include <QDebug>
#include <QDir>
#include <QFileDialog>
#include <QStandardPaths>

#include "qml/qmlfileinfo.h"
#include "applicationconfig.h"

QVariantList Backend::getWaveFilesList(QString subpath)
{
#ifdef ANDROID
    const QString path = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation).at(0) +
            QDir::separator() + "VoiceEmoMeter";
#else
    const QString path = ApplicationConfig::GetFullPatternsPath(subpath);
#endif
    qDebug() << "Backend::getWaveFilesList path: " << path;
    QDir dataDir(path);
    QStringList allFiles = dataDir.entryList(ApplicationConfig::WaveFileFilter, QDir::NoDotAndDotDot | QDir::Files);
    qDebug() << "Backend::getWaveFilesList allFiles: " << allFiles;

    QVariantList fileList;

    foreach(auto file, allFiles)
    {
        QmlFileInfo info(dataDir.absoluteFilePath(file));
        qDebug() << "Backend::getWaveFilesList: " << info.getName() << " : " << info.getPath();

        fileList.append(QVariant::fromValue(info));
    }

    return fileList;
}

void Backend::copyToExamples(QString filePath, QString name) {
    qDebug() << "Backend::copyToExamples filePath: " << filePath;
    qDebug() << "Backend::copyToExamples name: " << name;
#ifdef ANDROID
    const QString path = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation).at(0) +
            QDir::separator() + "VoiceEmoMeter" + QDir::separator() + subPath;
#else
    const QString path = ApplicationConfig::GetFullTestsPath();
#endif
    qDebug() << "Backend::copyToExamples path: " << path;

    QDir dir(path);

    QFile::copy(filePath, dir.absoluteFilePath(name + ".wav"));
}

void Backend::copyToTemplates(QString filePath, QString subPath, QString name) {
    qDebug() << "Backend::copyToTemplates filePath: " << filePath;
    qDebug() << "Backend::copyToTemplates subPath: " << subPath;
    qDebug() << "Backend::copyToTemplates name: " << name;
#ifdef ANDROID
    const QString path = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation).at(0) +
            QDir::separator() + "VoiceEmoMeter" + QDir::separator() + subPath;
#else
    const QString path = ApplicationConfig::GetFullPatternsPath(subPath);
#endif
    qDebug() << "Backend::copyToTemplates path: " << path;

    QDir dir(path);

    QFile::copy(filePath, dir.absoluteFilePath(name + ".wav"));
}

void Backend::deleteWaveFile(QString path)
{
    qDebug() << "Backend::deleteWaveFile: " << path;
    QFile file (path.toLocal8Bit());
    file.remove();
}

#ifdef ANDROID
#include <QtAndroid>
bool requestAndroidExternalStoragePermissions() {
    const QVector<QString> permissions(
                {"android.permission.WRITE_EXTERNAL_STORAGE",
                 "android.permission.READ_EXTERNAL_STORAGE"}
    );
    for (const QString &permission : permissions) {
        auto result = QtAndroid::checkPermission(permission);
        if (result == QtAndroid::PermissionResult::Denied) {
            auto resultHash = QtAndroid::requestPermissionsSync(QStringList({permission}));
            if (resultHash[permission] == QtAndroid::PermissionResult::Denied) {
                return false;
            }
        }
    }
    return true;
}
#endif

QString Backend::openFileDialog()
{
#ifdef ANDROID
    const QString path = QStandardPaths::standardLocations(QStandardPaths::DownloadLocation).at(0) +
            QDir::separator() + "VoiceEmoMeter";
    qDebug() << "Backend::openFileDialog path: " << path;
    QString fileName = "";
    if (requestAndroidExternalStoragePermissions()) {
        auto fileUrl = QFileDialog::getOpenFileUrl(nullptr,
                                    tr("Open File"),
                                    path,
                                    tr("Wave (*.*)"));
        qDebug() << "Backend::openFileDialog fileUrl: " << fileUrl;
        fileName = fileUrl.toString();
    }
#else
    const QString path = ApplicationConfig::GetFullTestsPath();
    qDebug() << "Backend::openFileDialog path: " << path;
    auto fileName = QFileDialog::getOpenFileName(nullptr,
        tr("Open File"),
        path,
        tr("Wave (*.wav)"));
#endif
    qDebug() << "Backend::openFileDialog: " << fileName;

    return fileName;
}
