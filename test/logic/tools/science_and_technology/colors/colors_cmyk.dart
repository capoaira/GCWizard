import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_cmyk.dart';
import 'package:gc_wizard/logic/tools/science_and_technology/colors/colors_rgb.dart';

void main() {
  group("Colors.CMYK:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : RGB(123, 230, 12), 'expectedOutput' : CMYK(0.46521739130434775, 0.0, 0.9478260869565217, 0.0980392156862745)},
      {'input' : RGB(0, 0, 0), 'expectedOutput' : CMYK(0.0, 0.0, 0.0, 1.0)},
      {'input' : RGB(255, 255, 255), 'expectedOutput' : CMYK(0.0, 0.0, 0.0, 0.0)},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var cmyk = CMYK.fromRGB(elem['input']);
        expect((cmyk.cyan - elem['expectedOutput'].cyan).abs() < 1e-5, true);
        expect((cmyk.magenta - elem['expectedOutput'].magenta).abs() < 1e-5, true);
        expect((cmyk.yellow - elem['expectedOutput'].yellow).abs() < 1e-5, true);
        expect((cmyk.key - elem['expectedOutput'].key).abs() < 1e-5, true);

        var rgb = cmyk.toRGB();
        expect((rgb.red - elem['input'].red).abs() < 1e-5, true);
        expect((rgb.green - elem['input'].green).abs() < 1e-5, true);
        expect((rgb.blue - elem['input'].blue).abs() < 1e-5, true);
      });
    });
  });

  group("Colors.CMY:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : RGB(123, 230, 12), 'expectedOutput' : CMY(0.5176470588235293, 0.0980392156862745, 0.9529411764705882)},
      {'input' : RGB(0, 0, 0), 'expectedOutput' : CMY(1.0, 1.0, 1.0)},
      {'input' : RGB(255, 255, 255), 'expectedOutput' : CMY(0.0, 0.0, 0.0)},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var cmy = CMY.fromRGB(elem['input']);
        expect((cmy.cyan - elem['expectedOutput'].cyan).abs() < 1e-5, true);
        expect((cmy.magenta - elem['expectedOutput'].magenta).abs() < 1e-5, true);
        expect((cmy.yellow - elem['expectedOutput'].yellow).abs() < 1e-5, true);

        var rgb = cmy.toRGB();
        expect((rgb.red - elem['input'].red).abs() < 1e-5, true);
        expect((rgb.green - elem['input'].green).abs() < 1e-5, true);
        expect((rgb.blue - elem['input'].blue).abs() < 1e-5, true);
      });
    });
  });
}