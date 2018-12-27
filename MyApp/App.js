import { Navigation } from "react-native-navigation";
import { Provider } from "react-redux";
import configureStore from "./src/store/configureStore";

import AuthScreen from "./src/screens/Auth/Auth";
import SharePlaceScreen from "./src/screens/SharePlace/SharePlace";
import FindPlaceScreen from "./src/screens/FindPlace/FindPlace";
import PlaceDetailScreen from "./src/screens/PlaceDetail/PlaceDetail";
import SideDrawer from "./src/screens/SideDrawer/SideDrawer";

const store = configureStore();

// Register Screens
Navigation.registerComponentWithRedux(
  "MyApp.AuthScreen",
  () => AuthScreen,
  Provider,
  store
);
Navigation.registerComponentWithRedux(
  "MyApp.SharePlaceScreen",
  () => SharePlaceScreen,
  Provider,
  store
);
Navigation.registerComponentWithRedux(
  "MyApp.FindPlaceScreen",
  () => FindPlaceScreen,
  Provider,
  store
);
Navigation.registerComponentWithRedux(
  "MyApp.PlaceDetailScreen",
  () => PlaceDetailScreen,
  Provider,
  store
);
Navigation.registerComponentWithRedux(
  "MyApp.SideDrawerScreen",
  () => SideDrawer,
  Provider,
  store
);

// Start a App
Navigation.events().registerAppLaunchedListener(() => {
  Navigation.setRoot({
    root: {
      stack: {
        children: [
          {
            component: {
              name: "MyApp.AuthScreen",
              options: {
                topBar: {
                  title: {
                    text: "Login"
                  }
                }
              }
            }
          }
        ]
      }
    }
  });
});
