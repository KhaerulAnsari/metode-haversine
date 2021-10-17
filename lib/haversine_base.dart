import 'dart:math';

class Haversine {
  static final R = 6372000; // In kilometers

  static double haversine(double latitude1, longitude1, latitude2, longitude2) {
    double dlat = _toRadians(latitude2 - latitude1);
    double dlon = _toRadians(longitude2 - longitude1);
    latitude1 = _toRadians(latitude1);
    latitude2 = _toRadians(latitude2);
    double a = pow(sin(dlat / 2), 2) +
        pow(sin(dlon / 2), 2) * cos(latitude1) * cos(latitude2);
    double c = 2 * asin(sqrt(a));
    return R * c;
  }

  static double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
