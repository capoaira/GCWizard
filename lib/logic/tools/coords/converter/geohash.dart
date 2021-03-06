import 'package:latlong/latlong.dart';

List<Map<String, String>> _alphabet = [
  {'character': '0', 'binary': '00000'},
  {'character': '1', 'binary': '00001'},
  {'character': '2', 'binary': '00010'},
  {'character': '3', 'binary': '00011'},
  {'character': '4', 'binary': '00100'},
  {'character': '5', 'binary': '00101'},
  {'character': '6', 'binary': '00110'},
  {'character': '7', 'binary': '00111'},
  {'character': '8', 'binary': '01000'},
  {'character': '9', 'binary': '01001'},
  {'character': 'b', 'binary': '01010'},
  {'character': 'c', 'binary': '01011'},
  {'character': 'd', 'binary': '01100'},
  {'character': 'e', 'binary': '01101'},
  {'character': 'f', 'binary': '01110'},
  {'character': 'g', 'binary': '01111'},
  {'character': 'h', 'binary': '10000'},
  {'character': 'j', 'binary': '10001'},
  {'character': 'k', 'binary': '10010'},
  {'character': 'm', 'binary': '10011'},
  {'character': 'n', 'binary': '10100'},
  {'character': 'p', 'binary': '10101'},
  {'character': 'q', 'binary': '10110'},
  {'character': 'r', 'binary': '10111'},
  {'character': 's', 'binary': '11000'},
  {'character': 't', 'binary': '11001'},
  {'character': 'u', 'binary': '11010'},
  {'character': 'v', 'binary': '11011'},
  {'character': 'w', 'binary': '11100'},
  {'character': 'x', 'binary': '11101'},
  {'character': 'y', 'binary': '11110'},
  {'character': 'z', 'binary': '11111'},
];

const _binaryLength = 5;

String _getCharacterByBinary(String binary) {
  var characterSet = _alphabet.firstWhere((entry) => entry['binary'] == binary);
  return characterSet['character'];
}

String _getBinaryByCharacter(String character) {
  var characterSet = _alphabet.firstWhere((entry) => entry['character'] == character);
  return characterSet['binary'];
}

List<String> _splitIntoBinaryChunks(String binary) {
  List<String> chunks = [];
  int i = 0;
  while (i + _binaryLength <= binary.length) {
    chunks.add(binary.substring(i, i + _binaryLength));
    i += _binaryLength;
  }

  return chunks;
}

String _generateBinaryFromCoord(double coord, double lowerBound, double upperBound, int length) {

  var binaryOut = '';

  while (binaryOut.length < length) {
    var middle = (lowerBound + upperBound) / 2.0;
    if (coord >= middle) {
      binaryOut += '1';
      lowerBound = middle;
    } else {
      binaryOut += '0';
      upperBound = middle;
    }
  }

  return binaryOut;
}

String latLonToGeohash(LatLng coords, int geohashLength) {
  int binaryCoordLength = (geohashLength / 2).floor() * _binaryLength;

  String latBinaryOut = _generateBinaryFromCoord(coords.latitude, -90.0, 90.0, binaryCoordLength);
  String lonBinaryOut = _generateBinaryFromCoord(coords.longitude, -180.0, 180.0, binaryCoordLength);

  var binary = '';
  int i = 0;
  while (i < latBinaryOut.length) {
    binary += lonBinaryOut[i] + latBinaryOut[i];
    i++;
  }

  return _splitIntoBinaryChunks(binary).map((chunk) => _getCharacterByBinary(chunk)).join();
}

LatLng geohashToLatLon(String geohash) {
  geohash = geohash.toLowerCase();
  var binary = geohash.split('').map((character) => _getBinaryByCharacter(character)).join();

  var latBinary = '';
  var lonBinary = '';

  var i = 0;
  while (i < binary.length) {
    lonBinary += binary[i];
    if ((i + 1) < binary.length)
      latBinary += binary[i + 1];
    i += 2;
  }

  var lat = _getCoordFromBinary(latBinary, -90.0, 90.0);
  var lon = _getCoordFromBinary(lonBinary, -180.0, 180.0);

  return LatLng(lat, lon);
}

double _getCoordFromBinary(String binary, double lowerBound, double upperBound) {
  var coord = 0.0;

  binary.split('').forEach((bit) {
    var middle = (lowerBound + upperBound) / 2.0;

    if (bit == '1') {
      lowerBound = middle;
    } else {
      upperBound = middle;
    }

    coord = (lowerBound + upperBound) / 2.0;
  });

  return coord;
}