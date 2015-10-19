#include "receiver.h"
#include <QVariant>
#include <qdebug.h>

Receiver::Receiver(QObject *parent) : QObject(parent)
{
    enterNameTextField = NULL;
    greetingLabel = NULL;
}

void Receiver::recieveHelloButtonClick()
{
    if(enterNameTextField == NULL || greetingLabel == NULL)
    {
        QObject *rootObject = engine.rootObjects().first();
        QObject *tabView = rootObject->findChild<QObject*>("tabView");
        QObject *tabHello = tabView->findChild<QObject*>("helloTab");
        enterNameTextField = tabHello->findChild<QObject*>("enterNameTextField");
        greetingLabel = tabHello->findChild<QObject*>("greetingLabel");
    }
    greetingLabel->setProperty("text", "Hello, " + (enterNameTextField->property("text")).toString() + "!");
}

QObject* Receiver::getEnterNameTextField()
{
    return enterNameTextField;
}

QObject* Receiver::getGreetingLabel()
{
    return greetingLabel;
}

void Receiver::setEnterNameTextField(QObject* obj)
{
    enterNameTextField = obj;
}

void Receiver::setGreetingLabel(QObject* obj)
{
    greetingLabel = obj;
}
