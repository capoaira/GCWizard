import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/gray.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/base/gcw_textfield.dart';
import 'package:gc_wizard/widgets/common/base/gcw_toast.dart';
import 'package:gc_wizard/widgets/common/gcw_default_output.dart';
import 'package:gc_wizard/widgets/common/gcw_encrypt_buttonbar.dart';
import 'package:gc_wizard/widgets/common/gcw_output.dart';
import 'package:gc_wizard/widgets/common/gcw_text_divider.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Gray extends StatefulWidget {
  @override
  GrayState createState() => GrayState();
}

class GrayState extends State<Gray> {
  var _inputDecimalController;
  var _inputBinaryController;
  var _currentOutput = GrayOutput('', '', '', '');

  String _currentInput = '';
  GCWSwitchPosition _currentMode = GCWSwitchPosition.left;

  String outputLine1 = '';
  String outputLine2 = '';
  String outputLine3 = '';

  var _decimalMaskFormatter = MaskTextInputFormatter(
      mask: '#' * 10000, // allow 10000 characters input
      filter: {"#": RegExp(r'[0-9]')}
  );

  var _binaryDigitsMaskFormatter = MaskTextInputFormatter(
      mask: '#' * 5000, // allow 5000 4-digit binary blocks, spaces will be set automatically after each block
      filter: {"#": RegExp(r'[01]')}
  );


  @override
  void initState() {
    super.initState();
    _inputDecimalController = TextEditingController(text: _currentInput);
    _inputBinaryController = TextEditingController(text: _currentInput);
  }

  @override
  void dispose() {
    _inputBinaryController.dispose();
    _inputDecimalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        _currentMode == GCWSwitchPosition.left
            ? GCWTextField(
            controller: _inputDecimalController,
            inputFormatters: [_decimalMaskFormatter],
            onChanged: (text){
              setState(() {
                _currentInput = text;
              });
            }
        )
            : GCWTextField (
            controller: _inputBinaryController,
            inputFormatters: [_binaryDigitsMaskFormatter],
            onChanged: (text){
              setState(() {
                _currentInput = text;
              });
            }
        ),

        GCWTwoOptionsSwitch(
          title: i18n(context, 'gray_mode'),
          leftValue: i18n(context, 'gray_mode_decimal'),
          rightValue: i18n(context, 'gray_mode_binary'),
          onChanged: (value) {
            setState(() {
              _currentMode = value;
            });
          },
        ),

        GCWEncryptButtonBar(
          onPressedEncode: () {
            if (_currentInput == null || _currentInput.length == 0) {
              showToast(i18n(context, 'Gray_error_no_encrypt_input'));
            } else {
              if (_currentMode == GCWSwitchPosition.left) {
                setState(() {
                  _currentOutput = encryptGray(_currentInput, mode: GrayMode.Decimal);
                });
                outputLine1 = i18n(context, 'gray_output_input_binary');
                outputLine2 = i18n(context, 'gray_output_output_gray_decimal');
                outputLine3 = i18n(context, 'gray_output_output_gray_binary');
              } else {
                setState(() {
                  _currentOutput = encryptGray(_currentInput, mode: GrayMode.Binary);
                });
                outputLine1 = i18n(context, 'gray_output_input_binary');
                outputLine2 = i18n(context, 'gray_output_output_gray_decimal');
                outputLine3 = i18n(context, 'gray_output_output_gray_binary');
              }
            }
          },
          onPressedDecode: () {
            if (_currentInput == null || _currentInput.length == 0) {
              showToast(i18n(context, 'Gray_error_no_output'));
            } else {
              if (_currentMode == GCWSwitchPosition.left) {
                setState(() {
                  _currentOutput = decryptGray(_currentInput, mode: GrayMode.Decimal);
                });
                outputLine1 = i18n(context, 'gray_output_input_binary');
                outputLine2 = i18n(context, 'gray_output_output_decimal');
                outputLine3 = i18n(context, 'gray_output_output_binary');
              } else {
                setState(() {
                  _currentOutput = decryptGray(_currentInput, mode: GrayMode.Binary);
                });
                outputLine1 = i18n(context, 'gray_output_input_decimal');
                outputLine2 = i18n(context, 'gray_output_output_decimal');
                outputLine3 = i18n(context, 'gray_output_output_binary');
              }
            }
          },
        ),
        _buildOutput(context)
      ],
    );
  }

  Widget _buildOutput(BuildContext context) {
    if (_currentOutput.state == null || _currentOutput.state == '')
      return Container();

    if (_currentOutput.state == 'ERROR') {
      showToast(i18n(context, _currentOutput.output_plain));
      return GCWDefaultOutput(
          text: '' //TODO: Exception
      );
    }

    List<List> grayValues;
    if (_currentMode == GCWSwitchPosition.left) {
      grayValues = [
        [outputLine1, _currentOutput.output_plain],
        [outputLine2, _currentOutput.output_gray_decimal],
        [outputLine3, _currentOutput.output_gray_binary],
      ];
    } else {
      grayValues = [
        [i18n(context, 'gray_output_input_decimal'), _currentOutput.output_plain],
        [i18n(context, 'gray_output_output_gray_decimal'), _currentOutput.output_gray_decimal],
        [i18n(context, 'gray_output_output_gray_binary'), _currentOutput.output_gray_binary],
      ];
    }

    var rows = columnedMultiLineOutput(grayValues, flexValues: [2, 1]);
    rows.insert(0,
        GCWTextDivider(
            text: i18n(context, 'common_output')
        )
    );

    return
      Column(
      children: rows
    );

/*

    return GCWOutput(
      child: Column(
        children: <Widget>[
          GCWOutputText(
              text: _currentOutput.output_plain_binary + '\n'
                  + _currentOutput.output_gray_decimal + '\n'
                  + _currentOutput.output_gray_binary
          ),
        ],
      ),
    );
*/
  }
}