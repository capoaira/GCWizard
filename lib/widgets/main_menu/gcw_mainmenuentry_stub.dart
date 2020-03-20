import 'package:flutter/material.dart';
import 'package:gc_wizard/theme/colors.dart';
import 'package:gc_wizard/theme/theme.dart';
import 'package:gc_wizard/utils/alphabets.dart';
import 'package:gc_wizard/widgets/common/base/gcw_dropdownbutton.dart';
import 'package:gc_wizard/widgets/common/base/gcw_iconbutton.dart';
import 'package:gc_wizard/widgets/utils/common_widget_utils.dart';


class GCWMainMenuEntryStub extends StatefulWidget {
  final Widget content;

  const GCWMainMenuEntryStub({
    Key key,
    this.content
  }) : super(key: key);

  @override
  GCWMainMenuEntryStubState createState() => GCWMainMenuEntryStubState();
}

class GCWMainMenuEntryStubState extends State<GCWMainMenuEntryStub> {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: 20,
          bottom: 20
        ),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/logo/circle_border_128.png',
                width: 100.0,
                height: 100.0,
              ),
            ),
            Container(
              width: 350,
              child: Container(
                decoration: BoxDecoration(
                  //color: ThemeColors.accent,
                  border: Border.all(
                      color: ThemeColors.accent,
                      width: 2
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(roundedBorderRadius),
                ),
                child: widget.content ?? Container(),
                padding: EdgeInsets.all(10)
              ),
              padding: EdgeInsets.only(
                top: 50
              ),
            )
          ],
        )
    );
  }
}