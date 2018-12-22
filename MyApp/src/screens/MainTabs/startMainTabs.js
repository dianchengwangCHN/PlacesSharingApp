import { Navigation } from "react-native-navigation";
import Icon from "react-native-vector-icons/Ionicons";

const startTabs = () => {
  Promise.all([
    Icon.getImageSource("md-map", 30),
    Icon.getImageSource("ios-share-alt", 30)
  ]).then(sources => {
    Navigation.setRoot({
      root: {
        bottomTabs: {
          children: [
            {
              component: {
                name: "MyApp.FindPlaceScreen",
                options: {
                  bottomTab: {
                    text: "Find Place",
                    icon: sources[0]
                  }
                }
              }
            },
            {
              component: {
                name: "MyApp.SharePlaceScreen",
                options: {
                  bottomTab: {
                    text: "Share Place",
                    icon: sources[1]
                  }
                }
              }
            }
          ]
        }
      }
    });
  });
};

export default startTabs;
