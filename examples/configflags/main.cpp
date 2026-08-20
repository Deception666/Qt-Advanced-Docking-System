#include "createmainviewwindow.h"
#include <QApplication>
#include <QSize>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    CreateMainViewWindow w;
    w.show();
    w.resize(w.devicePixelRatioF() * w.size());
    return a.exec();
}
