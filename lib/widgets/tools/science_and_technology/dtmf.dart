import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/dtmf.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DTMF extends StatefulWidget {
  @override
  DTMFState createState() => DTMFState();
}

class DTMFState extends State<DTMF> {
  TextEditingController _encodeController;
  TextEditingController _decodeController;

  var _currentEncodeInput = '';
  var _currentDecodeInput = '';

  var _currentDecryptLowFrequency = DTMF_FREQUENCIES_LOW[0];
  var _currentDecryptHighFrequency = DTMF_FREQUENCIES_HIGH[0];

  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  @override
  void initState() {
    super.initState();
    _encodeController = TextEditingController(text: _currentEncodeInput);
    _decodeController = TextEditingController(text: _currentDecodeInput);
  }

  @override
  void dispose() {
    _encodeController.dispose();
    _decodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWTwoOptionsSwitch(
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),
        _currentMode == GCWSwitchPosition.left
          ? GCWTextField(
              controller: _encodeController,
              onChanged: (text) {
                setState(() {
                  _currentEncodeInput = text;
                });
              },
            )
          : Container(),
        _currentMode == GCWSwitchPosition.right
          ? Row(
              children: [
                Expanded(
                  child: Container(
                    child: GCWDropDownButton(
                      value: _currentDecryptLowFrequency,
                      items: DTMF_FREQUENCIES_LOW.map((frequency) {
                        return DropdownMenuItem(
                          value: frequency,
                          child: Text(frequency.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _currentDecryptLowFrequency = value;
                        });
                      },
                    ),
                    padding: EdgeInsets.only(right: DEFAULT_MARGIN),
                  )
                ),
                Expanded(
                  child: Container(
                    child: GCWDropDownButton(
                      value: _currentDecryptHighFrequency,
                      items: DTMF_FREQUENCIES_HIGH.map((frequency) {
                        return DropdownMenuItem(
                          value: frequency,
                          child: Text(frequency.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _currentDecryptHighFrequency = value;
                        });
                      },
                    ),
                    padding: EdgeInsets.only(
                      left: DEFAULT_MARGIN,
                      right: DEFAULT_MARGIN
                    ),
                  )
                ),
                GCWIconButton(
                  iconData: Icons.add,
                  onPressed: () {
                    setState(() {
                      var input = ' [$_currentDecryptLowFrequency, $_currentDecryptHighFrequency] ';
                      var cursorPosition = max(_decodeController.selection.end, 0);

                      _currentDecodeInput = _currentDecodeInput.substring(0, cursorPosition) + input + _currentDecodeInput.substring(cursorPosition);
                      _decodeController.text = _currentDecodeInput;
                      _decodeController.selection = TextSelection.collapsed(offset: cursorPosition + input.length);
                    });
                  },
                )
              ],
            )
          : Container(),
        _currentMode == GCWSwitchPosition.right
          ? GCWTextField(
              controller: _decodeController,
              onChanged: (text) {
                setState(() {
                  _currentDecodeInput = text;
                });
              },
            )
          : Container(),
        GCWTextDivider(
            text: i18n(context, 'common_output')
        ),
        _buildOutput(context)
      ],
    );
  }


  Widget _buildOutput(BuildContext context) {
    var output = '';

    if (_currentMode == GCWSwitchPosition.left) {
      output = encodeDTMF(_currentEncodeInput);
    } else
      output = decodeDTMF(_currentDecodeInput);

    return GCWOutputText(
      text: output,
    );
  }
}