import { Navigation } from "react-native-navigation";
import { Platform } from "react-native";
import Icon from "react-native-vector-icons/Ionicons";

const startTabs = () => {
  Promise.all([
    Icon.getImageSource(Platform.OS === "android" ? "md-map" : "ios-map", 30),
    Icon.getImageSource(
      Platform.OS === "android" ? "md-share-alt" : "ios-share-alt",
      30
    ),
    Icon.getImageSource(Platform.OS === "android" ? "md-menu" : "ios-menu", 30)
  ]).then(sources => {
    Navigation.setRoot({
      root: {
        sideMenu: {
          left: {
            visible: false,
            component: {
              name: "MyApp.SideDrawerScreen"
            }
          },
          center: {
            stack: {
              id: "startTabs",
              children: [
                {
                  bottomTabs: {
                    children: [
                      {
                        component: {
                          name: "MyApp.FindPlaceScreen",
                          options: {
                            topBar: {
                              title: {
                                text: "Find Place"
                              },
                              leftButtons: {
                                id: "sideDrawerToggle",
                                icon: sources[2]
                              }
                            },
                            bottomTab: {
                              text: "Find Place",
                              icon: sources[0]
                            },
                            sideMenu: {}
                          }
                        }
                      },
                      {
                        component: {
                          name: "MyApp.SharePlaceScreen",
                          options: {
                            topBar: {
                              title: {
                                text: "Share Place"
                              },
                              leftButtons: {
                                id: "sideDrawerToggle",
                                icon: sources[2]
                              }
                            },
                            bottomTab: {
                              text: "Share Place",
                              icon: sources[1]
                            },
                            sideMenu: {}
                          }
                        }
                      }
                    ]
                  }
                }
              ]
            }
          }
        }
      }
    });
  });
};

export default startTabs;
