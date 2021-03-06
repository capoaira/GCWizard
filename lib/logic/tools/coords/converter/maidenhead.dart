import 'package:gc_wizard/utils/alphabets.dart';
import 'package:latlong/latlong.dart';

LatLng maidenheadToLatLon (String maidenhead) {
  maidenhead = maidenhead.toUpperCase();

  int res = 1;
  double reslon = 20;
  double reslat = 10;

  double lat = 0.0;
  double lon = 0.0;

  for (int i = 0; i < maidenhead.length; i += 2) {
    if (res == 1) {
      lon = ((alphabet_AZ[maidenhead[0]] - 1) * 20).toDouble();
      lat = ((alphabet_AZ[maidenhead[1]] - 1) * 10).toDouble();
      res = 2;
    } else if (res % 2 == 1)  {
      reslon /= 24;
      reslat /= 24;
      lon += (alphabet_AZ[maidenhead[i]] - 1).toDouble() * reslon;
      lat += (alphabet_AZ[maidenhead[i + 1]] - 1).toDouble() * reslat;
      ++res;
    } else {
      reslon /= 10;
      reslat /= 10;
      lon += int.tryParse(maidenhead[i]) * reslon;
      lat += int.tryParse(maidenhead[i + 1]) * reslat;
      ++res;
    }
  }

  lon -= 180;
  lat -= 90;

  return LatLng(lat, lon);
}

String latLonToMaidenhead (LatLng coord) {
  var lon = coord.longitude + 180.0;
  var lat = coord.latitude + 90.0;

  int resolution = 8;

  String out = '';

  int intlon;
  int intlat;

  if (resolution >= 1) {
    intlon = (lon / 20.0).floor();
    lon -= intlon * 20.0;
    intlat = (lat / 10.0).floor();
    lat -= intlat * 10.0;
    out += alphabet_AZIndexes[intlon + 1];
    out += alphabet_AZIndexes[intlat + 1];
  }

  if (resolution >= 2.0) {
    intlon = (lon / 2.0).floor();
    lon -= intlon * 2.0;
    intlat = (lat).floor();
    lat -= intlat;

    out += intlon.toString();
    out += intlat.toString();
  }

  int i = 3;
  double reslon = 2.0;
  double reslat = 1.0;

  while (i <= resolution) {
    if (i % 2 == 1)  {
      reslon /= 24.0;
      reslat /= 24.0;
      intlon = (lon / reslon).floor();
      lon -= intlon * reslon;
      intlat = (lat / reslat).floor();
      lat -= intlat * reslat;

      out += alphabet_AZIndexes[intlon + 1];
      out += alphabet_AZIndexes[intlat + 1];
    } else {
      reslon /= 10.0;
      reslat /= 10.0;
      intlon = (lon / reslon).floor();
      lon -= intlon * reslon;
      intlat = (lat / reslat).floor();
      lat -= intlat * reslat;

      out += intlon.toString();
      out += intlat.toString();
    }

    ++i;
  }

  return out;
}