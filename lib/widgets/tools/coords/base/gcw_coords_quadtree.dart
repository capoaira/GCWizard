import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/coords/converter/quadtree.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/utils/textinputformatter/wrapper_for_masktextinputformatter.dart';
import 'package:latlong/latlong.dart';

class GCWCoordsQuadtree extends StatefulWidget {
  final Function onChanged;

  const GCWCoordsQuadtree({Key key, this.onChanged}) : super(key: key);

  @override
  GCWCoordsQuadtreeState createState() => GCWCoordsQuadtreeState();
}

class GCWCoordsQuadtreeState extends State<GCWCoordsQuadtree> {
  var _controller;
  var _currentCoord = '';

  var _maskInputFormatter = WrapperForMaskTextInputFormatter(
    mask: '#' * 100,
    filter: {"#": RegExp(r'[0123]')}
  );

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _currentCoord);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column (
      children: <Widget>[
        GCWTextField(
          controller: _controller,
          inputFormatters: [_maskInputFormatter],
          onChanged: (ret) {
            setState(() {
              _currentCoord = ret;
              _setCurrentValueAndEmitOnChange();
            });
          }
        ),
      ]
    );
  }

  _setCurrentValueAndEmitOnChange() {
    try {
      LatLng coords = quadtreeToLatLon(_currentCoord.split('').map((character) => int.tryParse(character)).toList());
      widget.onChanged(coords);
    } catch(e) {}
  }
}