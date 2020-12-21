import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/hashes/hashes.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bcd.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/base.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/segment_display.dart';
import 'package:gc_wizard/widgets/common/gcw_abc_spinner.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/gcw_stateful_dropdownbutton.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/multi_decoder/gcw_multi_decoder_tool_configuration.dart';
import 'package:gc_wizard/logic/tools/coords/data/coordinates.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/utils/constants.dart';
import 'package:latlong/latlong.dart';
import 'package:gc_wizard/logic/tools/coords/parser/latlon.dart';
import 'package:gc_wizard/logic/tools/coords/converter/utm.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mgrs.dart';
import 'package:gc_wizard/logic/tools/coords/converter/swissgrid.dart';
import 'package:gc_wizard/logic/tools/coords/converter/maidenhead.dart';
import 'package:gc_wizard/logic/tools/coords/converter/mercator.dart';
import 'package:gc_wizard/logic/tools/coords/converter/natural_area_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/geohash.dart';
import 'package:gc_wizard/logic/tools/coords/converter/open_location_code.dart';
import 'package:gc_wizard/logic/tools/coords/converter/quadtree.dart';
import 'package:gc_wizard/logic/tools/coords/converter/reverse_whereigo_waldmeister.dart';
import 'package:gc_wizard/logic/tools/coords/converter/gauss_krueger.dart';
import 'package:gc_wizard/logic/tools/coords/utils.dart';
import 'package:gc_wizard/widgets/tools/coords/base/utils.dart';

const MDT_INTERNALNAMES_COORDINATEFORMATS = 'coordinate_formats';
const MDT_COORDINATEFORMATS_OPTION_FORMAT = 'format';

class MultiDecoderToolCoordinateFormats extends GCWMultiDecoderTool {

  MultiDecoderToolCoordinateFormats({Key key, int id, String name, MultiDecoderToolState state, Map<String, dynamic> options, BuildContext context}) :
    super(
      key: key,
      id: id,
      name: name,
      state: state,
      internalToolName: MDT_INTERNALNAMES_COORDINATEFORMATS,
      onDecode: (String input) {
        input = input.replaceAll(RegExp(r'\s+'), ' ').toUpperCase();
        var inputParts = input.split(' ');
        LatLng coords;
        try {
          switch (options[MDT_COORDINATEFORMATS_OPTION_FORMAT]) {
            case keyCoordsDEC:
              coords = parseDEC(input);
              break;
            case keyCoordsDMM:
              coords = parseDMM(input);
              break;
            case keyCoordsDMS:
              coords = parseDMS(input);
              break;
            case keyCoordsUTM:
              coords = parseUTM(input, defaultEllipsoid());
              break;
            case keyCoordsMGRS:
              coords = parseMGRS(input, defaultEllipsoid());
              break;
            case keyCoordsSwissGrid:
              coords = parseSwissGrid(input, defaultEllipsoid());
              break;
            case keyCoordsSwissGridPlus:
              coords = parseSwissGrid(input, defaultEllipsoid(), isSwissGridPlus: true);
              break;
            case keyCoordsGaussKrueger:
              coords = parseGaussKrueger(input, defaultEllipsoid());
              break;
            case keyCoordsMaidenhead:
              coords = maidenheadToLatLon(input);
              break;
            case keyCoordsMercator:
              coords = parseMercator(input, defaultEllipsoid());
              break;
            case keyCoordsNaturalAreaCode:
              coords = parseNaturalAreaCode(input);
              break;
            case keyCoordsGeohash:
              coords = geohashToLatLon(input);
              break;
            case keyCoordsOpenLocationCode:
              coords = openLocationCodeToLatLon(input);
              break;
            case keyCoordsQuadtree:
              coords = parseQuadtree(input);
              break;
            case keyCoordsReverseWhereIGoWaldmeister:
              coords = parseWaldmeister(input);
              break;
          }
        } catch(e) {}

        if (coords == null)
          return 'Note: hhjkhjk';

        return formatCoordOutput(coords, defaultCoordFormat(), defaultEllipsoid());
      },
      options: options,
      configurationWidget: GCWMultiDecoderToolConfiguration(
        widgets: {
          MDT_COORDINATEFORMATS_OPTION_FORMAT: GCWStatefulDropDownButton(
            value: options[MDT_COORDINATEFORMATS_OPTION_FORMAT],
            onChanged: (newValue) {
              options[MDT_COORDINATEFORMATS_OPTION_FORMAT] = newValue;
            },
            items: allCoordFormats
              .where((format) => format.key != keyCoordsSlippyMap)
              .map((format) {
                return GCWDropDownMenuItem(
                  value: format.key,
                  child: i18n(context, format.name) ?? format.name,
                );
              }).toList(),
            ),
        }
      )
    );
}