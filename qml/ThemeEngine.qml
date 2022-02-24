pragma Singleton

import QtQuick 2.15
import QtQuick.Controls.Material 2.15

Item {
    enum ThemeNames {

        // WatchFlower
        THEME_PLANT = 0,
        THEME_SNOW = 1,
        THEME_DAY = 2,
        THEME_NIGHT = 3,

        // dSphere
        THEME_LIGHT_DESKTOP = 4,
        THEME_DARK_DESKTOP = 5,
        THEME_LIGHT_MOBILE = 6,
        THEME_DARK_MOBILE = 7,

        // Offloadbuddy
        THEME_LIGHT_AND_WARM = 8,
        THEME_DARK_AND_SPOOKY = 9,
        THEME_PLAIN_AND_BORING = 10,
        THEME_BLOOD_AND_TEARS = 11,
        THEME_MIGHTY_KITTENS = 12,

        THEME_LAST
    }
    property int currentTheme: -1

    ////////////////

    property int themeStatusbar
    property string colorStatusbar

    // Header
    property string colorHeader
    property string colorHeaderContent
    property string colorHeaderHighlight

    // Sidebar
    property string colorSidebar
    property string colorSidebarContent
    property string colorSidebarHighlight

    // Action bar
    property string colorActionbar
    property string colorActionbarContent
    property string colorActionbarHighlight

    // Tablet bar
    property string colorTabletmenu
    property string colorTabletmenuContent
    property string colorTabletmenuHighlight

    // Content
    property string colorBackground
    property string colorForeground

    property string colorPrimary
    property string colorSecondary
    property string colorSuccess
    property string colorWarning
    property string colorError

    property string colorText
    property string colorSubText
    property string colorIcon
    property string colorSeparator

    property string colorLowContrast
    property string colorHighContrast

    // App specific
    property string colorDeviceWidget
    property string sidebarSelector // 'arrow' or 'bar'

    // Qt Quick controls & theming
    property string colorComponent
    property string colorComponentText
    property string colorComponentContent
    property string colorComponentBorder
    property string colorComponentDown
    property string colorComponentBackground

    property int componentHeight: 40
    property int componentRadius: 4
    property int componentBorderWidth: 1

    ////////////////

    // Palette colors
    property string colorLightGreen: "#09debc" // unused
    property string colorGreen
    property string colorDarkGreen: "#1ea892" // unused
    property string colorBlue
    property string colorYellow
    property string colorOrange
    property string colorRed
    property string colorGrey: "#555151" // unused
    property string colorLightGrey: "#a9bcb8" // unused

    // Fixed colors
    readonly property string colorMaterialBlue: "#2196f3"
    readonly property string colorMaterialThisblue: "#448aff"
    readonly property string colorMaterialIndigo: "#3f51b5"
    readonly property string colorMaterialPurple: "#9c27b0"
    readonly property string colorMaterialDeepPurple: "#673ab7"
    readonly property string colorMaterialRed: "#f44336"
    readonly property string colorMaterialOrange: "#ff9800"
    readonly property string colorMaterialLightGreen: "#8bc34a"

    readonly property string colorMaterialLightGrey: "#f8f8f8"
    readonly property string colorMaterialGrey: "#eeeeee"
    readonly property string colorMaterialDarkGrey: "#ececec"
    readonly property string colorNeutralDay: "#e4e4e4"
    readonly property string colorNeutralNight: "#ffb300"

    ////////////////

    // Fonts (sizes in pixel) (WIP)
    readonly property int fontSizeHeader: (Qt.platform.os === "ios" || Qt.platform.os === "android") ? 22 : 26
    readonly property int fontSizeTitle: 24
    readonly property int fontSizeContentVerySmall: 12
    readonly property int fontSizeContentSmall: 14
    readonly property int fontSizeContent: 16
    readonly property int fontSizeContentBig: 18
    readonly property int fontSizeContentVeryBig: 20
    readonly property int fontSizeComponent: (Qt.platform.os === "ios" || Qt.platform.os === "android") ? 14 : 15

    ////////////////////////////////////////////////////////////////////////////

    function getThemeIndex(name) {
        var index = -1

        if (name === "THEME_PLANT") index = ThemeEngine.THEME_PLANT
        else if (name === "THEME_SNOW") index = ThemeEngine.THEME_SNOW
        else if (name === "THEME_DAY") index = ThemeEngine.THEME_DAY
        else if (name === "THEME_NIGHT") index = ThemeEngine.THEME_NIGHT

        else if (name === "THEME_LIGHT_AND_WARM") index = ThemeEngine.THEME_LIGHT_AND_WARM
        else if (name === "THEME_DARK_AND_SPOOKY") index = ThemeEngine.THEME_DARK_AND_SPOOKY
        else if (name === "THEME_PLAIN_AND_BORING") index = ThemeEngine.THEME_PLAIN_AND_BORING
        else if (name === "THEME_BLOOD_AND_TEARS") index = ThemeEngine.THEME_BLOOD_AND_TEARS
        else if (name === "THEME_MIGHTY_KITTENS") index = ThemeEngine.THEME_MIGHTY_KITTENS

        else if (name === "THEME_LIGHT_DESKTOP") index = ThemeEngine.THEME_LIGHT_DESKTOP
        else if (name === "THEME_DARK_DESKTOP") index = ThemeEngine.THEME_DARK_DESKTOP
        else if (name === "THEME_LIGHT_MOBILE") index = ThemeEngine.THEME_LIGHT_MOBILE
        else if (name === "THEME_DARK_MOBILE") index = ThemeEngine.THEME_DARK_MOBILE

        return index
    }
    function getThemeName(index) {
        var name = ""

        if (index === ThemeEngine.THEME_PLANT) name = "THEME_PLANT"
        else if (index === ThemeEngine.THEME_SNOW) name = "THEME_SNOW"
        else if (index === ThemeEngine.THEME_DAY) name = "THEME_DAY"
        else if (index === ThemeEngine.THEME_NIGHT) name = "THEME_NIGHT"

        else if (index === ThemeEngine.THEME_LIGHT_AND_WARM) name = "THEME_LIGHT_AND_WARM"
        else if (index === ThemeEngine.THEME_DARK_AND_SPOOKY) name = "THEME_DARK_AND_SPOOKY"
        else if (index === ThemeEngine.THEME_PLAIN_AND_BORING) name = "THEME_PLAIN_AND_BORING"
        else if (index === ThemeEngine.THEME_BLOOD_AND_TEARS) name = "THEME_BLOOD_AND_TEARS"
        else if (index === ThemeEngine.THEME_MIGHTY_KITTENS) name = "THEME_MIGHTY_KITTENS"

        else if (index === ThemeEngine.THEME_LIGHT_DESKTOP) name = "THEME_LIGHT_DESKTOP"
        else if (index === ThemeEngine.THEME_DARK_DESKTOP) name = "THEME_DARK_DESKTOP"
        else if (index === ThemeEngine.THEME_LIGHT_MOBILE) name = "THEME_LIGHT_MOBILE"
        else if (index === ThemeEngine.THEME_DARK_MOBILE) name = "THEME_DARK_MOBILE"

        return name
    }

    ////////////////////////////////////////////////////////////////////////////

    Component.onCompleted: loadTheme(settingsManager.appTheme)
    Connections {
        target: settingsManager
        function onAppThemeChanged() { loadTheme(settingsManager.appTheme) }
    }

    function loadTheme(newIndex) {
        //console.log("ThemeEngine.loadTheme(" + newIndex + ")")
        var themeIndex = -1

        // Get the theme index
        if ((typeof newIndex === 'string' || newIndex instanceof String)) {
            themeIndex = getThemeIndex(newIndex)
        } else {
            themeIndex = newIndex
        }

        // Validate the result
        if (themeIndex < 0 || themeIndex >= ThemeEngine.THEME_LAST) {
            themeIndex = ThemeEngine.THEME_LIGHT_AND_WARM // default theme
        }

        // Handle day/night themes
        if (settingsManager.appThemeAuto) {
            var rightnow = new Date()
            var hour = Qt.formatDateTime(rightnow, "hh")
            if (hour >= 21 || hour <= 8) {
                themeIndex = ThemeEngine.THEME_NIGHT
            }
        }

        // Do not reload the same theme
        if (themeIndex === currentTheme) return




        if (themeIndex === ThemeEngine.THEME_SNOW) {

            colorGreen = "#85c700"
            colorBlue = "#4cafe9"
            colorYellow = "#facb00"
            colorOrange = "#ffa635"
            colorRed = "#ff7657"

            themeStatusbar = Material.Dark
            colorStatusbar = "white"

            colorHeader = "white"
            colorHeaderContent = "#444"
            colorHeaderHighlight = colorMaterialDarkGrey

            colorSidebar = "white"
            colorSidebarContent = "#444"
            colorSidebarHighlight = colorMaterialDarkGrey

            colorActionbar = colorGreen
            colorActionbarContent = "white"
            colorActionbarHighlight = "#7ab800"

            colorTabletmenu = "#ffffff"
            colorTabletmenuContent = "#9d9d9d"
            colorTabletmenuHighlight = "#0079fe"

            colorBackground = "white"
            colorForeground = colorMaterialLightGrey

            colorPrimary = colorYellow
            colorSecondary = "#ffe800"
            colorSuccess = colorGreen
            colorWarning = colorOrange
            colorError = colorRed

            colorText = "#474747"
            colorSubText = "#666666"
            colorIcon = "#606060"
            colorSeparator = colorMaterialDarkGrey
            colorLowContrast = "white"
            colorHighContrast = "#303030"

            colorDeviceWidget = "#fdfdfd"

            componentHeight = 40
            componentRadius = 20
            componentBorderWidth = 2

            colorComponent = "#EFEFEF"
            colorComponentText = "black"
            colorComponentContent = "black"
            colorComponentBorder = "#EAEAEA"
            colorComponentDown = "#DADADA"
            colorComponentBackground = "#FAFAFA"

        } else if (themeIndex === ThemeEngine.THEME_PLANT) {

            colorGreen = "#07bf97"
            colorBlue = "#4CA1D5"
            colorYellow = "#ffba5a"
            colorOrange = "#ffa635"
            colorRed = "#ff7657"

            themeStatusbar = Material.Dark
            colorStatusbar = "#009688"

            colorHeader = colorGreen
            colorHeaderContent = "white"
            colorHeaderHighlight = "#009688"

            colorSidebar = colorGreen
            colorSidebarContent = "white"
            colorSidebarHighlight = "#009688"

            colorActionbar = "#00b5c4"
            colorActionbarContent = "white"
            colorActionbarHighlight = "#069fac"

            colorTabletmenu = "#f3f3f3"
            colorTabletmenuContent = "#9d9d9d"
            colorTabletmenuHighlight = "#0079fe"

            colorBackground = (Qt.platform.os === "android" || Qt.platform.os === "ios") ? "white" : colorMaterialLightGrey
            colorForeground = (Qt.platform.os === "android" || Qt.platform.os === "ios") ? colorMaterialLightGrey : colorMaterialGrey

            colorPrimary = colorGreen
            colorSecondary = colorLightGreen
            colorSuccess = colorGreen
            colorWarning = colorOrange
            colorError = colorRed

            colorText = "#333333"
            colorSubText = "#666666"
            colorIcon = "#606060"
            colorSeparator = colorMaterialDarkGrey
            colorLowContrast = "white"
            colorHighContrast = "black"

            colorDeviceWidget = "#fdfdfd"

            componentHeight = 40
            componentRadius = 4
            componentBorderWidth = 2

            colorComponent = "#EAEAEA"
            colorComponentText = "black"
            colorComponentContent = "black"
            colorComponentBorder = "#E3E3E3"
            colorComponentDown = "#D0D0D0"
            colorComponentBackground = "#EAEAEA"

        } else if (themeIndex === ThemeEngine.THEME_DAY) {

            colorGreen = "#8cd200"
            colorBlue = "#4cafe9"
            colorYellow = "#ffcf00"
            colorOrange = "#ffa635"
            colorRed = "#ff7657"

            themeStatusbar = Material.Dark
            colorStatusbar = colorNeutralNight

            colorHeader = "#ffcf00"
            colorHeaderContent = "white"
            colorHeaderHighlight = colorNeutralNight

            colorSidebar = "#ffcf00"
            colorSidebarContent = "white"
            colorSidebarHighlight = colorNeutralNight

            colorActionbar = colorGreen
            colorActionbarContent = "white"
            colorActionbarHighlight = "#7ab800"

            colorTabletmenu = "#f3f3f3"
            colorTabletmenuContent = "#9d9d9d"
            colorTabletmenuHighlight = "#0079fe"

            colorBackground = "white"
            colorForeground = colorMaterialLightGrey

            colorPrimary = colorYellow
            colorSecondary = "#ffe800"
            colorSuccess = colorGreen
            colorWarning = colorOrange
            colorError = colorRed

            colorText = "#474747"
            colorSubText = "#666666"
            colorIcon = "#606060"
            colorSeparator = colorMaterialDarkGrey
            colorLowContrast = "white"
            colorHighContrast = "#303030"

            colorDeviceWidget = "#fdfdfd"

            componentHeight = 40
            componentRadius = 8
            componentBorderWidth = 2

            colorComponent = "#EFEFEF"
            colorComponentText = "black"
            colorComponentContent = "black"
            colorComponentBorder = "#E8E8E8"
            colorComponentDown = "#DDDDDD"
            colorComponentBackground = "#FAFAFA"

        } else if (themeIndex === ThemeEngine.THEME_NIGHT) {

            colorGreen = "#58CF77"
            colorBlue = "#4dceeb"
            colorYellow = "#fcc632"
            colorOrange = "#ff8f35"
            colorRed = "#e8635a"

            themeStatusbar = Material.Dark
            colorStatusbar = "#725595"

            colorHeader = "#b16bee"
            colorHeaderContent = "white"
            colorHeaderHighlight = "#725595"

            colorSidebar = "#b16bee"
            colorSidebarContent = "white"
            colorSidebarHighlight = "#725595"

            colorActionbar = colorBlue
            colorActionbarContent = "white"
            colorActionbarHighlight = "#4dabeb"

            colorTabletmenu = "#292929"
            colorTabletmenuContent = "#808080"
            colorTabletmenuHighlight = "#bb86fc"

            colorBackground = "#313236"
            colorForeground = "#292929"

            colorPrimary = "#bb86fc"
            colorSecondary = "#b16bee"
            colorSuccess = colorGreen
            colorWarning = colorOrange
            colorError = colorRed

            colorText = "#EEE"
            colorSubText = "#AAA"
            colorIcon = "#b9babe"
            colorSeparator = "#404040"
            colorLowContrast = "#111"
            colorHighContrast = "white"

            colorDeviceWidget = "#333"

            componentHeight = 40
            componentRadius = 4
            componentBorderWidth = 2

            colorComponent = "#757575"
            colorComponentText = "#eee"
            colorComponentContent = "white"
            colorComponentBorder = "#777"
            colorComponentDown = "#595959"
            colorComponentBackground = "#292929"

        }






        if (themeIndex === ThemeEngine.THEME_LIGHT_AND_WARM) {

            colorHeader =               "#DADADA"
            colorHeaderContent =        "#353637"
            colorHeaderHighlight =      Qt.darker(colorHeader, 1.1)

            colorSidebar =              "#3A3A3A"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     Qt.darker(colorSidebar, 1.5)

            colorActionbar =            "#8CD200"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   "#73AD00"

            colorBackground =           "#F4F4F4"
            colorForeground =           "#E5E5E5"

            colorPrimary =              "#FFCA28"
            colorSecondary =            "#FFDD28"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#FFAC00"
            colorError =                "#E64B39"

            colorText =                 "#222"
            colorSubText =              "#555"
            colorIcon =                 "#333"
            colorSeparator =            "#E4E4E4"
            colorLowContrast =          "white"
            colorHighContrast =         "black"

            colorComponent =            "#E6E6E6"
            colorComponentText =        "black"
            colorComponentContent =     "black"
            colorComponentBorder =      "#C1C1C1"
            colorComponentDown =        "#E4E4E4"
            colorComponentBackground =  "#FAFAFA"

            componentRadius = 4
            componentBorderWidth = 2
            sidebarSelector = ""

        } else if (themeIndex === ThemeEngine.THEME_DARK_AND_SPOOKY) {

            colorHeader =               "#282828"
            colorHeaderContent =        "#C0C0C0"
            colorHeaderHighlight =      Qt.lighter(colorHeader, 1.4)

            colorSidebar =              "#2E2E2E"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     Qt.lighter(colorSidebar, 1.4)

            colorActionbar =            "#FEC759"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   "#FFAF00"

            colorBackground =           "#404040"
            colorForeground =           "#555555"

            colorPrimary =              "#FF9F1A" // indigo: "#6C5ECD"
            colorSecondary =            "#FFB81A" // indigo2: "#9388E5"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#FE8F2D"
            colorError =                "#D33E39"

            colorText =                 "white"
            colorSubText =              "#AAA"
            colorIcon =                 "white"
            colorSeparator =            "#666"
            colorLowContrast =          "black"
            colorHighContrast =         "white"

            colorComponent =            "#555"
            colorComponentText =        "white"
            colorComponentContent =     "white"
            colorComponentBorder =      "#666"
            colorComponentDown =        "#333"
            colorComponentBackground =  "#505050"

            componentRadius = 3
            componentBorderWidth = 1
            sidebarSelector = ""

        } else if (themeIndex === ThemeEngine.THEME_PLAIN_AND_BORING) {

            colorHeader =               "#E8E8E8"
            colorHeaderContent =        "#353637"
            colorHeaderHighlight =      Qt.darker(colorHeader, 1.06)

            colorSidebar =              "#2A5D92"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     Qt.darker(colorSidebar, 1.3)

            colorActionbar =            "#FFD54A"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   "#FFC831"

            colorBackground =           "#FEFEFE"
            colorForeground =           "#F0F0F0"

            colorPrimary =              "#0079E3"
            colorSecondary =            "#00A0E3"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#FFC107"
            colorError =                "#FF5722"

            colorText =                 "#333"
            colorSubText =              "#666"
            colorIcon =                 "#333"
            colorSeparator =            "#E0E0E0"
            colorLowContrast =          "white"
            colorHighContrast =         "black"

            colorComponent =            "#F3F3F3"
            colorComponentText =        "black"
            colorComponentContent =     "black"
            colorComponentBorder =      "#D1D1D1"
            colorComponentDown =        "#E1E1E1"
            colorComponentBackground =  "#F3F3F3"

            componentRadius = 4
            componentBorderWidth = 1
            sidebarSelector = "arrow"

        } else if (themeIndex === ThemeEngine.THEME_BLOOD_AND_TEARS) {

            colorHeader =               "#141414"
            colorHeaderContent =        "white"
            colorHeaderHighlight =      "#222"

            colorSidebar =              "#181818"
            colorSidebarContent =       "#DDD"
            colorSidebarHighlight =     "#222"

            colorActionbar =            "#009EE2"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   "#0089C3"

            colorBackground =           "#222"
            colorForeground =           "#333"

            colorPrimary =              "#009EE2"
            colorSecondary =            "#00BEE2"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#FFDB63"
            colorError =                "#FA6871"

            colorText =                 "#D2D2D2"
            colorSubText =              "#A3A3A3"
            colorIcon =                 "#A0A0A0"
            colorSeparator =            "#666"
            colorLowContrast =          "black"
            colorHighContrast =         "white"

            colorComponent =            "white"
            colorComponentText =        "black"
            colorComponentContent =     "black"
            colorComponentBorder =      "#E4E4E4"
            colorComponentDown =        "#DDD"
            colorComponentBackground =  "white"

            componentRadius = 1
            componentBorderWidth = 1
            sidebarSelector = "bar"

        } else if (themeIndex === ThemeEngine.THEME_MIGHTY_KITTENS) {

            colorHeader =               "#FFB4DC"
            colorHeaderContent =        "#944197"
            colorHeaderHighlight =      Qt.darker(colorHeader, 1.1)

            colorSidebar =              "#E31D8D"
            colorSidebarContent =       "#FFF06D"
            colorSidebarHighlight =     Qt.darker(colorSidebar, 1.2)

            colorActionbar =            "#FFE400"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   "#FFBF00"

            colorBackground =           "white"
            colorForeground =           "#FFDDEE"

            colorPrimary =              "#FFE400"
            colorSecondary =            "#FFF600"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#944197"
            colorError =                "#FA6871"

            colorText =                 "#932A97"
            colorSubText =              "#B746BB"
            colorIcon =                 "#FFE400"
            colorSeparator =            "#E4E4E4"
            colorLowContrast =          "white"
            colorHighContrast =         "red"

            colorComponent =            "#FF87D0"
            colorComponentText =        "#944197"
            colorComponentContent =     "white"
            colorComponentBorder =      "#F592C1"
            colorComponentDown =        "#FF9ED9"
            colorComponentBackground =  "#FFF4F9"

            componentRadius = 20
            componentBorderWidth = 2
            sidebarSelector = ""
        }




        if (themeIndex === ThemeEngine.THEME_LIGHT_DESKTOP) {

            themeStatusbar = Material.Light
            colorStatusbar = colorMaterialDarkGrey

            colorHeader =               "#CBCBCB"
            colorHeaderContent =        "#353637"
            colorHeaderHighlight =      Qt.darker(colorHeader, 1.1)

            colorSidebar =              "#2e2e2e"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     Qt.darker(colorSidebar, 1.5)

            colorActionbar =            "#8cd200"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   "#73AD00"

            colorBackground =           "#EEEEEE"
            colorForeground =           "#E0E0E0"

            colorPrimary =              "#ffca28"
            colorSecondary =            "#ffdb28"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#ffac00"
            colorError =                "#dc4543"

            colorText =                 "#222222"
            colorSubText =              "#555555"
            colorIcon =                 "#333333"
            colorSeparator =            "#E4E4E4"
            colorLowContrast =          "white"
            colorHighContrast =         "black"

            colorComponent =            "#DBDBDB"
            colorComponentText =        "black"
            colorComponentContent =     "black"
            colorComponentBorder =      "#c1c1c1"
            colorComponentDown =        "#E4E4E4"
            colorComponentBackground =  "#FAFAFA"

            componentHeight = 40
            componentRadius = 4
            componentBorderWidth = 2

        } else if (themeIndex === ThemeEngine.THEME_DARK_DESKTOP) {

            themeStatusbar = Material.Dark
            colorStatusbar = "#292929"

            colorHeader =               "#292929"
            colorHeaderContent =        "#e0e0e0"
            colorHeaderHighlight =      Qt.lighter(colorHeader, 1.4)

            colorSidebar =              "#2e2e2e"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     "#404040"

            colorActionbar =            "#fed859"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   "#FFBA00"

            colorBackground =           "#404040"
            colorForeground =           "#555555"

            colorPrimary =              "#8457ff" // indigo: "#6C5ECD" // orange: "#ff9f1a"
            colorSecondary =            "#9388e5" // indigo2: "#9388e5" // orange2: "#ffb81a"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#e38541"
            colorError =                "#dc322f"

            colorText =                 "white"
            colorSubText =              "#aaaaaa"
            colorIcon =                 "white"
            colorSeparator =            "#333"
            colorLowContrast =          "black"
            colorHighContrast =         "white"

            colorComponent =            "#555555"
            colorComponentText =        "white"
            colorComponentContent =     "white"
            colorComponentBorder =      "#666666"
            colorComponentDown =        "#333333"
            colorComponentBackground =  "#505050"

            componentHeight = 40
            componentRadius = 4
            componentBorderWidth = 2

        } else if (themeIndex === ThemeEngine.THEME_LIGHT_MOBILE) {

            themeStatusbar = Material.Light
            colorStatusbar = colorMaterialDarkGrey

            colorHeader =               colorMaterialGrey
            colorHeaderContent =        "#f44336" // colorMaterialRed
            colorHeaderHighlight =      Qt.darker(colorHeader, 1.1)

            colorSidebar =              "#3A3A3A"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     Qt.darker(colorSidebar, 1.5)

            colorActionbar =            "#e8635a"
            colorActionbarContent =     "white"
            colorActionbarHighlight =   ""

            colorTabletmenu =           "#f3f3f3"
            colorTabletmenuContent =    "#9d9d9d"
            colorTabletmenuHighlight =  "#0079fe"

            colorBackground =           colorMaterialLightGrey
            colorForeground =           colorMaterialGrey

            colorPrimary =              colorMaterialRed
            colorSecondary =            "#ff7b36" // colorMaterialOrange
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#ffac00"
            colorError =                "#dc322f"

            colorText =                 "#303030"
            colorSubText =              "#666666"
            colorIcon =                 "#494949"
            colorSeparator =            colorMaterialGrey
            colorLowContrast =          "white"
            colorHighContrast =         "black"

            colorComponent =            "#eaeaea"
            colorComponentText =        "black"
            colorComponentContent =     "black"
            colorComponentBorder =      "#b3b3b3"
            colorComponentDown =        "#cacaca"
            colorComponentBackground =  colorBackground

        } else if (themeIndex === ThemeEngine.THEME_DARK_MOBILE) {

            themeStatusbar = Material.Dark
            colorStatusbar = "#292929"

            colorHeader =               "#292929"
            colorHeaderContent =        "#ee8c21"
            colorHeaderHighlight =      Qt.lighter(colorHeader, 1.4)

            colorSidebar =              "#2E2E2E"
            colorSidebarContent =       "white"
            colorSidebarHighlight =     Qt.lighter(colorSidebar, 1.4)

            colorTabletmenu =           "#292929"
            colorTabletmenuContent =    "#808080"
            colorTabletmenuHighlight =  "#bb86fc"

            colorBackground =           "#313236"
            colorForeground =           "#292929"

            colorPrimary =              "#ff9f1a"
            colorSecondary =            "#ffb81a"
            colorSuccess =              colorMaterialLightGreen
            colorWarning =              "#e38541"
            colorError =                "#dc322f"

            colorText =                 "white"
            colorSubText =              "#AAAAAA"
            colorIcon =                 "#cccccc"
            colorSeparator =            "#404040"
            colorLowContrast =          "black"
            colorHighContrast =         "white"

            colorComponent =            "#666666"
            colorComponentText =        "white"
            colorComponentContent =     "white"
            colorComponentBorder =      "#666666"
            colorComponentDown =        "#444444"
            colorComponentBackground =  "#505050"

        }




        // This will emit the signal 'onCurrentThemeChanged'
        currentTheme = themeIndex
    }
}