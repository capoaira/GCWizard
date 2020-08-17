import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/bifid.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/polybios.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';

class Bifid extends StatefulWidget {
  @override
  BifidState createState() => BifidState();
}

class BifidState extends State<Bifid> {
  var _inputController;
  var _alphabetController;

  var _currentMode = GCWSwitchPosition.left;

  String _currentInput = '';
  String _currentAlphabet = '';

  PolybiosMode _currentBifidMode = PolybiosMode.AZ09;
  BifidAlphabetMode _currentBifidAlphabetMode = BifidAlphabetMode.JToI;

  GCWSwitchPosition _currentMatrixMode = GCWSwitchPosition.left;         /// switches between 5x5 or 6x6 square

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController(text: _currentInput);
    _alphabetController = TextEditingController(text: _currentAlphabet);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _alphabetController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var BifidModeItems = {
      PolybiosMode.AZ09 : i18n(context, 'bifid_mode_az09'),
      PolybiosMode.ZA90 : i18n(context, 'bifid_mode_za90'),
      PolybiosMode.CUSTOM : i18n(context, 'bifid_mode_custom'),
    };
    var BifidAlphabetModeItems = {
      BifidAlphabetMode.JToI : i18n(context, 'bifid_alphabet_mod_jtoi'),
      BifidAlphabetMode.CToK : i18n(context, 'bifid_alphabet_mod_ctok'),
      BifidAlphabetMode.WToVV : i18n(context, 'bifid_alphabet_mod_wtovv'),
      BifidAlphabetMode.RemoveQ : i18n(context, 'bifid_alphabet_mod_removeq'),
    };

    return Column(
      children: <Widget>[
        GCWTextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              _currentInput = text;
            });
          },
        ),

        GCWTwoOptionsSwitch(
          value: _currentMode,
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),

        GCWTextDivider(
            text: i18n(context, 'common_alphabet')
        ),

        GCWDropDownButton(
          value: _currentBifidMode,
          onChanged: (value) {
            setState(() {
              _currentBifidMode = value;
            });
          },
          items: BifidModeItems.entries.map((mode) {
            return DropdownMenuItem(
              value: mode.key,
              child: Text(mode.value),
            );
          }).toList(),
        ),

        _currentBifidMode == PolybiosMode.CUSTOM
          ? GCWTextField(
              hintText: i18n(context, 'common_alphabet'),
              controller: _alphabetController,
              onChanged: (text) {
                setState(() {
                  _currentAlphabet = text;
                  print(_currentAlphabet);
                });
              },
            )
          : Container(),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'bifid_matrix'),
          leftValue: i18n(context, 'bifid_mode_5x5'),
          rightValue: i18n(context, 'bifid_mode_6x6'),
          onChanged: (value) {
            setState(() {
              _currentMatrixMode = value;
            });
          },
        ),

        _currentMatrixMode == GCWSwitchPosition.left
          ? GCWTextDivider(
              text: i18n(context, 'bifid_alphabet_mod')
            )
          : Container(), //empty widget

        _currentMatrixMode == GCWSwitchPosition.left
          ? GCWDropDownButton(
              value: _currentBifidAlphabetMode,
              onChanged: (value) {
                setState(() {
                  _currentBifidAlphabetMode = value;
                });
              },
              items: BifidAlphabetModeItems.entries.map((mode) {
                return DropdownMenuItem(
                  value: mode.key,
                  child: Text(mode.value),
                );
              }).toList(),
            )
          : Container(), //empty widget

        _buildOutput()
      ],
    );
  }

  _buildOutput() {
    var key;
    if (_currentMatrixMode == GCWSwitchPosition.left) {
      key = "12345";
    } else {
      key = "123456";
    }

    if (_currentInput == null || _currentInput.length == 0)
      return GCWDefaultOutput(text: '');

    var _currentOutput = BifidOutput('', '', '');
    if (_currentMode == GCWSwitchPosition.left) {
      _currentOutput = encryptBifid(
        _currentInput,
        key,
        mode: _currentBifidMode,
        alphabet: _currentAlphabet,
        alphabetMode: _currentBifidAlphabetMode
      );
    } else {
      _currentOutput = decryptBifid(
        _currentInput,
        key,
        mode: _currentBifidMode,
        alphabet: _currentAlphabet,
        alphabetMode: _currentBifidAlphabetMode
      );
    }

    if (_currentOutput.state == 'ERROR') {
      showToast(i18n(context, _currentOutput.output));
      return GCWDefaultOutput(text: '');
    }

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWOutputText(
            text: _currentOutput.output
          ),
          GCWTextDivider(
            text: i18n(context, 'bifid_usedgrid')
          ),
          GCWOutputText(
            text: _currentOutput.grid,
            isMonotype: true,
          )
        ],
      ),
    );
  }
}