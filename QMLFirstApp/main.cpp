#include <QApplication>
#include <QQmlApplicationEngine>
#include <mainwindow.h>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
   engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    //stopWatchLabel = engine.findChild<QObject*>("stopWatchLabel");
  //  QObject* obj = engine.
   // MainWindow mw;
  //  mw.show();
    return app.exec();
}

