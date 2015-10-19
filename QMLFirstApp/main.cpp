#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "receiver.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    Receiver receiver;
    QQmlContext* ctx = receiver.engine.rootContext();
    ctx->setContextProperty("receiver", &receiver);
    receiver.engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
