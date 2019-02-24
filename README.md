# PlacesSharingApp
A mobile App that allows user to upload photo and location information of places.

* Built the app UI with React Native in Javascript and Flutter in Dart respectively.
* Utilized Firebase as backend to provide user authentication and realtime database services.
* Pluged in image-picker to allow user select photo to share.
* Integrated Google Map API to render map and location marker.
* Adopted Cloud Function in Node.js runtime to store image to Google Cloud Storage and trigger a delete operation on image when its corresponding entry is deleted from database.

## Demo
### React Native:
<image src="./demo/react-native_demo.gif" height="500"/>

### Flutter:
<image src="./demo/flutter_demo.gif" height="500"/>

For the Flutter version, since the google maps plugin is still on developer preview stage, some features are expected to be finished soon.
