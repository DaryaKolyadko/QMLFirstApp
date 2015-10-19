#ifndef RECEIVER_H
#define RECEIVER_H

#include <QObject>
#include <QQmlApplicationEngine>

class Receiver : public QObject
{
    Q_OBJECT

private:
    QObject *enterNameTextField;
    QObject *greetingLabel;

public:
    explicit Receiver(QObject *parent = 0);
    QQmlApplicationEngine engine;
    QObject* getEnterNameTextField();
    QObject* getGreetingLabel();
    void setEnterNameTextField(QObject* obj);
    void setGreetingLabel(QObject* obj);

signals:

public slots:
    void recieveHelloButtonClick();
};

#endif // RECEIVER_H
