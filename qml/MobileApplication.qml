import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import ThemeEngine 1.0
import MobileUI 1.0

ApplicationWindow {
    id: appWindow
    minimumWidth: 480
    minimumHeight: 960

    flags: Qt.Window // | Qt.MaximizeUsingFullscreenGeometryHint
    color: Theme.colorBackground
    visible: true

    property bool isHdpi: (utilsScreen.screenDpi > 128)
    property bool isDesktop: (Qt.platform.os !== "ios" && Qt.platform.os !== "android")
    property bool isMobile: (Qt.platform.os === "ios" || Qt.platform.os === "android")
    property bool isPhone: ((Qt.platform.os === "ios" || Qt.platform.os === "android") && (utilsScreen.screenSize < 7.0))
    property bool isTablet: ((Qt.platform.os === "ios" || Qt.platform.os === "android") && (utilsScreen.screenSize >= 7.0))

    // Mobile stuff ////////////////////////////////////////////////////////////

    // 1 = Qt.PortraitOrientation, 2 = Qt.LandscapeOrientation
    // 4 = Qt.InvertedPortraitOrientation, 8 = Qt.InvertedLandscapeOrientation
    property int screenOrientation: Screen.primaryOrientation
    property int screenOrientationFull: Screen.orientation
    onScreenOrientationChanged: handleNotchesTimer.restart()

    property int screenPaddingStatusbar: 0
    property int screenPaddingNotch: 0
    property int screenPaddingLeft: 0
    property int screenPaddingRight: 0
    property int screenPaddingBottom: 0

    Timer {
        id: handleNotchesTimer
        interval: 33
        repeat: false
        onTriggered: handleNotches()
    }

    function handleNotches() {
/*
        console.log("handleNotches()")
        console.log("screen width : " + Screen.width)
        console.log("screen width avail  : " + Screen.desktopAvailableWidth)
        console.log("screen height : " + Screen.height)
        console.log("screen height avail  : " + Screen.desktopAvailableHeight)
        console.log("screen orientation: " + Screen.orientation)
        console.log("screen orientation (primary): " + Screen.primaryOrientation)
*/
        if (Qt.platform.os !== "ios") return
        if (typeof quickWindow === "undefined" || !quickWindow) {
            handleNotchesTimer.restart()
            return
        }

        // Statusbar text color hack (iOS)
        mobileUI.statusbarTheme = (Theme.themeStatusbar === 0) ? 1 : 0
        mobileUI.statusbarTheme = Theme.themeStatusbar

        // Margins
        var safeMargins = utilsScreen.getSafeAreaMargins(quickWindow)
        if (safeMargins["total"] === safeMargins["top"]) {
            screenPaddingStatusbar = safeMargins["top"]
            screenPaddingNotch = 0
            screenPaddingLeft = 0
            screenPaddingRight = 0
            screenPaddingBottom = 0
        } else if (safeMargins["total"] > 0) {
            if (Screen.orientation === Qt.PortraitOrientation) {
                screenPaddingStatusbar = 20
                screenPaddingNotch = 12
                screenPaddingLeft = 0
                screenPaddingRight = 0
                screenPaddingBottom = 6
            } else if (Screen.orientation === Qt.InvertedPortraitOrientation) {
                screenPaddingStatusbar = 12
                screenPaddingNotch = 20
                screenPaddingLeft = 0
                screenPaddingRight = 0
                screenPaddingBottom = 6
            } else if (Screen.orientation === Qt.LandscapeOrientation) {
                screenPaddingStatusbar = 0
                screenPaddingNotch = 0
                screenPaddingLeft = 32
                screenPaddingRight = 0
                screenPaddingBottom = 0
            } else if (Screen.orientation === Qt.InvertedLandscapeOrientation) {
                screenPaddingStatusbar = 0
                screenPaddingNotch = 0
                screenPaddingLeft = 0
                screenPaddingRight = 32
                screenPaddingBottom = 0
            } else {
                screenPaddingStatusbar = 0
                screenPaddingNotch = 0
                screenPaddingLeft = 0
                screenPaddingRight = 0
                screenPaddingBottom = 0
            }
        } else {
            screenPaddingStatusbar = 0
            screenPaddingNotch = 0
            screenPaddingLeft = 0
            screenPaddingRight = 0
            screenPaddingBottom = 0
        }
/*
        console.log("total:" + safeMargins["total"])
        console.log("top:" + safeMargins["top"])
        console.log("left:" + safeMargins["left"])
        console.log("right:" + safeMargins["right"])
        console.log("bottom:" + safeMargins["bottom"])

        console.log("RECAP screenPaddingStatusbar:" + screenPaddingStatusbar)
        console.log("RECAP screenPaddingNotch:" + screenPaddingNotch)
        console.log("RECAP screenPaddingLeft:" + screenPaddingLeft)
        console.log("RECAP screenPaddingRight:" + screenPaddingRight)
        console.log("RECAP screenPaddingBottom:" + screenPaddingBottom)
*/
    }

    MobileUI {
        id: mobileUI
        property bool isLoading: true

        statusbarTheme: Theme.themeStatusbar
        statusbarColor: isLoading ? "white" : Theme.colorStatusbar
        navbarColor: {
            if (isLoading) return "white"
            if (appContent.state === "Tutorial") return Theme.colorHeader
            return Theme.colorBackground
        }
    }

    MobileHeader {
        id: appHeader
        width: appWindow.width
        anchors.top: appWindow.top
    }

    MobileDrawer {
        id: appDrawer
        width: (appWindow.screenOrientation === Qt.PortraitOrientation || appWindow.width < 480) ? 0.8 * appWindow.width : 0.5 * appWindow.width
        height: appWindow.height
    }

    // Events handling /////////////////////////////////////////////////////////

    Component.onCompleted: {
        handleNotchesTimer.restart()
        mobileUI.isLoading = false
    }

    Connections {
        target: appHeader
        function onLeftMenuClicked() {
            if (appContent.state === "MainView") {
                appDrawer.open()
            } else {
                if (appContent.state === "Permissions")
                    appContent.state = "About"
                else
                    appContent.state = "MainView"
            }
        }
        function onRightMenuClicked() {
            //
        }

        function onDeviceRefreshButtonClicked() {
            //
        }
    }

    Connections {
        target: Qt.application
        function onStateChanged() {
            switch (Qt.application.state) {
                case Qt.ApplicationSuspended:
                    //console.log("Qt.ApplicationSuspended")
                    break
                case Qt.ApplicationHidden:
                    //console.log("Qt.ApplicationHidden")
                    break
                case Qt.ApplicationInactive:
                    //console.log("Qt.ApplicationInactive")
                    break
                case Qt.ApplicationActive:
                    //console.log("Qt.ApplicationActive")

                    // Check if we need an 'automatic' theme change
                    Theme.loadTheme(settingsManager.appTheme)
                    break
            }
        }
    }

    Timer {
        id: exitTimer
        interval: 3000
        running: false
        repeat: false
        onRunningChanged: exitWarning.opacity = running
    }

    // User generated events handling //////////////////////////////////////////

    function backAction() {
        if (appContent.state === "MainView") {
            if (exitTimer.running)
                Qt.quit()
            else
                exitTimer.start()
        } else if (appContent.state === "Permissions") {
            appContent.state = "About"
        } else if (appContent.state !== "MainView") {
            appContent.state = "MainView"
        }
    }
    function forwardAction() {
        //
    }
    function deselectAction() {
        //
    }

    // UI sizes ////////////////////////////////////////////////////////////////

    property bool headerUnicolor: (Theme.colorHeader === Theme.colorBackground)

    property bool singleColumn: {
        if (isMobile) {
            if ((isPhone && screenOrientation === Qt.PortraitOrientation) ||
                (isTablet && width < 512)) { // can be a 2/3 split screen on tablet
                return true
            } else {
                return false
            }
        } else {
            return (appWindow.width < appWindow.height)
        }
    }

    property bool wideMode: (isDesktop && width >= 560) || (isTablet && width >= 480)
    property bool wideWideMode: (width >= 640)

    // QML /////////////////////////////////////////////////////////////////////

    FocusScope {
        id: appContent
        anchors.top: appHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        focus: true
        Keys.onBackPressed: backAction()

        MainView {
            anchors.fill: parent
            id: screenMainView
        }

        Settings {
            id: screenSettings
            anchors.fill: parent
            anchors.bottomMargin: mobileMenu.hhv
        }
        MobilePermissions {
            id: screenPermissions
            anchors.fill: parent
            anchors.bottomMargin: mobileMenu.hhv
        }
        About {
            id: screenAbout
            anchors.fill: parent
            anchors.bottomMargin: mobileMenu.hhv
        }

        Component.onCompleted: {
            //
        }

        // Initial state
        state: "MainView"

        onStateChanged: {
            //
        }

        states: [
            State {
                name: "MainView"
                PropertyChanges { target: appHeader; title: "QmlAppTemplate"; }
                PropertyChanges { target: screenMainView; enabled: true; visible: true; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenPermissions; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "Settings"
                PropertyChanges { target: appHeader; title: qsTr("Settings"); }
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: true; enabled: true; }
                PropertyChanges { target: screenPermissions; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "Permissions"
                PropertyChanges { target: appHeader; title: qsTr("Permissions"); }
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenPermissions; visible: true; enabled: true; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "About"
                PropertyChanges { target: appHeader; title: qsTr("About"); }
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenPermissions; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: true; enabled: true; }
            }
        ]
    }

    ////////////////

    MobileMenu {
        id: mobileMenu
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    ////////////////

    Text {
        id: exitWarning
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 32
        anchors.horizontalCenter: parent.horizontalCenter

        visible: opacity
        opacity: 0
        Behavior on opacity { OpacityAnimator { duration: 333 } }

        text: qsTr("Press one more time to exit...")
        textFormat: Text.PlainText
        font.pixelSize: Theme.fontSizeContent
        color: Theme.colorForeground

        Rectangle {
            anchors.fill: parent
            anchors.margins: -8
            z: -1
            radius: 4
            color: Theme.colorSubText
        }
    }
}