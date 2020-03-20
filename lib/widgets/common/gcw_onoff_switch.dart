import 'package:flutter/material.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/widgets/common/base/gcw_switch.dart';
import 'package:gc_wizard/widgets/common/base/gcw_text.dart';

class GCWOnOffSwitch extends StatefulWidget {
  final Function onChanged;
  final String title;
  final value;
  final bool notitle;

  const GCWOnOffSwitch({Key key, this.value, this.onChanged, this.title, this.notitle: false}) : super(key: key);

  @override
  GCWOnOffSwitchState createState() => GCWOnOffSwitchState();
}

class GCWOnOffSwitchState extends State<GCWOnOffSwitch> {
  var _currentValue = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        widget.notitle ? Container() : Expanded(
          child: GCWText(
            text: (widget.title ?? i18n(context, 'default_switch_title')) + ':'
          ),
          flex: 1
        ),
        Expanded(
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded (
                  child: Container(),
                  flex: 1
                ),
                GCWSwitch(
                  value: widget.value ?? _currentValue,
                  onChanged: widget.onChanged,
                  inactiveThumbColor: ThemeColors.gray,
                ),
                Expanded (
                  child: Container(),
                  flex: 1
                ),
              ],
            ),
          ),
          flex: 3
        )
      ],
    );
  }
}