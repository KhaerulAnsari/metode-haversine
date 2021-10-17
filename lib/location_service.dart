import 'dart:async';

import 'package:location/location.dart';
import 'package:tampilkoordinat/user_location.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> _locationStreamContoller =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationStreamContoller.stream;

  LocationService() {
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationStreamContoller.add(UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude));
          }
        });
      }
    });
  }
  void dispose() => _locationStreamContoller.close();
}
