import 'package:latlong/latlong.dart';
import 'package:gc_wizard/logic/tools/coords/converter/chsh/geohex4j/geohex.dart';

LatLng geoHexToLatLon (String geoHex) {
  Zone zone = getZoneByCode(geoHex);
  return LatLng(zone.lat, zone.lon);
}

String latLonToGeoHex (LatLng coord, int precision) {
  Zone zone = getZoneByLocation(coord.latitude, coord.longitude, precision);
  return zone.code;
}