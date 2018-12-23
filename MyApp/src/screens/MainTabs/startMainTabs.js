import { Navigation } from "react-native-navigation";
import Icon from "react-native-vector-icons/Ionicons";

const startTabs = () => {
  Promise.all([
    Icon.getImageSource("md-map", 30),
    Icon.getImageSource("ios-share-alt", 30),
    Icon.getImageSource("ios-menu", 30)
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
