import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_dec.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_dmm.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_dms.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_formatselector.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_gausskrueger.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_geohash.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_geohex.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_maidenhead.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_mercator.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_mgrs.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_naturalareacode.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_openlocationcode.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_paste_button.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_quadtree.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_reversewhereigo_waldmeister.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_slippymap.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_swissgrid.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_utm.dart';
import 'package:gc_wizard/widgets/tools/coords/base/gcw_coords_xyz.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/utils/user_location.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class GCWCoords extends StatefulWidget {
  final Function onChanged;
  final Map<String, String> coordsFormat;
  final LatLng coordinates;
  final String title;
  final bool notitle;

  const GCWCoords({Key key, this.title, this.coordinates, this.onChanged, this.coordsFormat, this.notitle: false}) : super(key: key);

  @override
  GCWCoordsState createState() => GCWCoordsState();
}

class GCWCoordsState extends State<GCWCoords> {

  Map<String, String> _currentCoordsFormat;
  LatLng _currentValue;

  LatLng _pastedCoords;

  var _currentWidget;

  var _location = Location();
  bool _isOnLocationAccess = false;

  @override
  void initState() {
    super.initState();

    _currentCoordsFormat = widget.coordsFormat ?? defaultCoordFormat();
    _setPastedCoordsFormat();
    _currentValue = widget.coordinates ?? defaultCoordinate;
    _pastedCoords = _currentValue;
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _coordsWidgets = [
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsDEC),
        'widget': GCWCoordsDEC(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsDMM),
        'widget': GCWCoordsDMM(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsDMS),
        'widget': GCWCoordsDMS(
          coordinates: _pastedCoords,
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
       'coordFormat': getCoordinateFormatByKey(keyCoordsUTM),
       'widget': GCWCoordsUTM(
         onChanged: (newValue) {
           setState(() {
             _setCurrentValueAndEmitOnChange(newValue);
           });
         },
       ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsMGRS),
        'widget': GCWCoordsMGRS(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsXYZ),
        'widget': GCWCoordsXYZ(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsSwissGrid),
        'widget': GCWCoordsSwissGrid(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsSwissGridPlus),
        'widget': GCWCoordsSwissGrid(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsGaussKrueger),
        'widget': GCWCoordsGaussKrueger(
          subtype: _currentCoordsFormat['subtype'],
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsMaidenhead),
        'widget': GCWCoordsMaidenhead(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsMercator),
        'widget': GCWCoordsMercator(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsNaturalAreaCode),
        'widget': GCWCoordsNaturalAreaCode(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsSlippyMap),
        'widget': GCWCoordsSlippyMap(
          zoom: _currentCoordsFormat['subtype'],
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsGeohash),
        'widget': GCWCoordsGeohash(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsGeoHex),
        'widget': GCWCoordsGeoHex(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsOpenLocationCode),
        'widget': GCWCoordsOpenLocationCode(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsQuadtree),
        'widget': GCWCoordsQuadtree(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
      {
        'coordFormat': getCoordinateFormatByKey(keyCoordsReverseWhereIGoWaldmeister),
        'widget': GCWCoordsReverseWhereIGoWaldmeister(
          onChanged: (newValue) {
            setState(() {
              _setCurrentValueAndEmitOnChange(newValue);
            });
          },
        ),
      },
    ];

    _pastedCoords = null;

    Column _widget;
    if (widget.notitle) {
      _widget = Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: _buildInputFormatSelector()
              ),
              Container(
                child: _buildTrailingButtons(IconButtonSize.NORMAL),
                padding: EdgeInsets.only(left: 2 * DEFAULT_MARGIN)
              )
            ],
          )
        ],
      );
    } else {
      _widget = Column(
        children: <Widget>[
          GCWTextDivider(
            text: widget.title,
            bottom: 0.0,
            trailing: _buildTrailingButtons(IconButtonSize.SMALL)
          ),
          _buildInputFormatSelector()
        ],
      );
    }

    _currentWidget = _coordsWidgets
      .firstWhere((entry) => entry['coordFormat'].key == _currentCoordsFormat['format'])['widget'];

    _widget.children.add(_currentWidget);

    return _widget;
  }

  _buildInputFormatSelector() {
    return GCWCoordsFormatSelector(
      format: _currentCoordsFormat,
      onChanged: (newValue){
        setState(() {
          if (_currentCoordsFormat != newValue) {
            _currentCoordsFormat = newValue;
            _currentValue = defaultCoordinate;

            _setCurrentValueAndEmitOnChange();
          }
          FocusScope.of(context).requestFocus(new FocusNode()); //Release focus from previous edited field
        });
      },
    );
  }

  _buildTrailingButtons(IconButtonSize size) {
    return Row(
      children: [
        Container(
          child:  GCWIconButton(
            iconData: _isOnLocationAccess ? Icons.refresh : Icons.location_on,
            size: size,
            onPressed: () {
              _setUserLocationCoords();
            },
          ),
          padding: EdgeInsets.only(right: DEFAULT_MARGIN),
        ),
        GCWCoordsPasteButton(
          size: size,
          onPasted: _setCoords
        )
      ],
    );
  }

  _setCurrentValueAndEmitOnChange([LatLng newValue]) {
    widget.onChanged({
      'coordsFormat': _currentCoordsFormat,
      'value': newValue ?? _currentValue
    });
  }

  _setCoords(Map<String, dynamic> pastedCoords) {
    if (pastedCoords == null)
      return;

    _pastedCoords = pastedCoords['coordinate'];

    _setPastedCoordsFormat();
    _currentValue = _pastedCoords;

    _setCurrentValueAndEmitOnChange();
  }

  _setPastedCoordsFormat() {
    switch(_currentCoordsFormat['format']) {
      case keyCoordsDEC:
      case keyCoordsDMM:
      case keyCoordsDMS:
        break;
      default:
        _currentCoordsFormat = {'format': keyCoordsDMM};
    }
  }

  _setUserLocationCoords() {
    if (_isOnLocationAccess)
      return;

    setState(() {
      _isOnLocationAccess = true;
    });

    checkLocationPermission(_location).then((value) {
      if (value == null || value == false) {
        setState(() {
          _isOnLocationAccess = false;
        });
        showToast(i18n(context, 'coords_common_location_permissiondenied'));

        return;
      }

      _location.getLocation().then((locationData) {
        if (locationData.accuracy > 20)
          showToast(i18n(context, 'coords_common_location_lowaccuracy', parameters: [NumberFormat('0.0').format(locationData.accuracy)]));

        _pastedCoords = LatLng(locationData.latitude, locationData.longitude);
        _currentValue = _pastedCoords;
        _setPastedCoordsFormat();

        _isOnLocationAccess = false;
        _setCurrentValueAndEmitOnChange();
      });
    });
  }
}