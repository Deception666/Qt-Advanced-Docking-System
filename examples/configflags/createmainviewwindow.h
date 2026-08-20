#ifndef CREATEMAINVIEWWINDOW_H
#define CREATEMAINVIEWWINDOW_H

#include <QMainWindow>

#include <memory>

namespace Ui
{
    class CreateMainViewWindow;
}  // namespace Ui

class CreateMainViewWindow : public QMainWindow
{
    Q_OBJECT

public:
    CreateMainViewWindow(QWidget* parent = nullptr);
    ~CreateMainViewWindow();

private:
    void SetupConfigFlagsTreeWidget();
    void SetupAutoHideFlagsListTreeWidget();

    std::unique_ptr<Ui::CreateMainViewWindow> ui;

};

#endif // CREATEMAINVIEWWINDOW_H
