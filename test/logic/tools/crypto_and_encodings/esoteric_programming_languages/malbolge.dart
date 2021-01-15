import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/malbolge.dart';

void main() {

  group("malbolge.interpreter", () {

    // https://en.wikipedia.org/wiki/Malbolge
    // https://lutter.cc/malbolge/  welcome
    // https://github.com/zb3/malbolge-tools/tree/master/samples
    // https://lutter.cc/malbolge/digital_root.mal
    // https://lutter.cc/malbolge/adder.mal
    // https://www.trs.css.i.nagoya-u.ac.jp/projects/Malbolge/malbolge/rot13.txt
    // https://raw.githubusercontent.com/zb3/malbolge-tools/master/samples/helloworld-eu.mb HelloWorld_EU
    // https://github.com/graue/esofiles/blob/master/malbolge/src/beer.mal
    // https://zb3.me/malbolge-tools/#generator

    var blank = '''bCBA@?>=<;:9876543210/.-,+*)('&%\$#"!~}|{zyxwvutsrqponmlkjihgfedcba`_^]\[ZYXWVUTSRQPONMLKJIHGFEDCBA@L''';
    var HelloWorld =    '''(=<`#9]~6ZY32Vx/4Rs+0No-&Jk)"Fh}|Bcy?`=*z]Kw%oG4UUS0/@-ejc(:'8dc''';
    var Welcome =       '''(=&`:#>!}5Y3y70wSus+Oppomm\$H"!h}\${Abx>+{;s'&Z''';
    var HelloWorld_EU = '''D'`Nq"!\~Z{ji7CBeuQPqp.'mm\$Gj!EfC0"c>w_{)sr8YXtsl2Sonmf,jLbaf_%cE[`Y}@?[ZYRvVUTSRQJImM/KDhHA)E>bB\$@?>=6Z{3810/.R2r0/.'&+\$H('&feBc!~}vut:xwpXn4lqpingf,jLbaf_%cE[`Y}]\U=SwQ9UNrR4PINGLEiCHG@EDCB;_987[;:9810Tut,+0)Mnm+*)"'~D\$dc!x}vu;\\xqpo54Uqjing-NMiha'edFEa`_X|\[T<RvPUTSLQPImM/KJIBAeED=BA:9]=<;{z870T432+*)M'&%\$)('~D\$dc!~}v<tsxwvon4lTjohmlkjib(fH%]E[`Y^W{>=YXQuUTMRQJImMLEDCg*F?>=<A@?8\<|432V6v43,+Opo'&%I#('~D\$#"!a}|u;y[Zpotm3qponmfN+iha`_%FEaZ~^@?UZSRWVOsM5KJONGkEJCHA@d>&BA@9]76Z498165.-Q10)o'&J*)(!~}C{zy~w=^]sxqpo5slkjongf,MLbgf_dc\"Z_X|V[ZSw:VOTMRKo21GLEJCgG@E>CB;_?!7<54Xy1U/432+O/.',%\$#G'&feBc!x>_uzyrq7XWsl2ponmfN+ihJI_%]b[!BX]\UTx;WPUTMq4PONGLEiC+AeEDCB;@?87[;4387654-Q1*/.-&J*)('gf\$#z@xw={]\\xqpo54Uqjing-NMiha'edFEa`_X|\>=YXWPOsSLQJOHlF.DhHGFE>&<`@9>=<;4X87w5.-210/(L,+*ji!E%\$#zyxwv<]\\xwpun4lTjinmle+Lbaf_^]#DZ_^]VzTSRQVONMqQJOHlF.JIBf)dD=BA:?>7[|:9876/.3,PO/o-&J*ji!&}\$#z@~w_{zs9Zvutsrkpi/POe+Lha`_%cba`BX|\[T<RvVUT65Ko2NGFjDIHG@?c=B;_?!=<;4X2765.3,1*NM',+*#(!E%\${cy?w_{zyxwp6tsrkpong-Njchgf_^\$\aZY^]\[Tx;WPUTMqQPONM/EiCHG@dDCB;_"!=<5Y3876/.3,PO/o-&J*ji!&}\$#z@~w_{zs9Zvotm3DpRQ.lNjchgf_^\$E[!_X]VzyYXQ9UNrRQ32NMLEDhH*@ED=<`@9>=<;4Xy165.-Q10/.'&J*)(!g}Cd"!xw=*''';
    var beer =          '''bCBA@?>=<;:9876543210/.-,+*)('&%\$#"!~}|{zyxwvutsrqponmlkjihgfedcba`_^]\[ZYXWVUTSRQPONMLKJIHGFEDCBA@?!7<;:9876543210/.-&J*)('&%\$#"!~}|{zyxwvutsrqponmlkjihgfHdcba`_^]\[ZYXWVUTSRQPONMLKJIHGFED=a\$@?8\<5:9870T4-210)M-,l*#Gh&%\$#"!~}|{zs9wvun4rqponmlkjihgfedcba`_^]\[ZYXWVOsSRKPONMLKJIHGFE>bBA@?>=}54X876543210/.-,+*)('&%\$d"!~}|u;yxZvutsrqponmlkjihgfedcba`Y}W\UyYXWV8Nr5QJONMLKJIHG@dDC%A@?>=<;:9876/S3210/.-,%\$H('&f|{A!~}|{]s9Zvutsrqj0ngle+ihgfedcE"`_A]\[ZYXQuUTSRKPONMLEiIHG@?c=BA@?>7[;:z876543210/(-,+*#G'~%\${Ab~w|{zyr87utsUqjonmle+ihgfedcba`_^]\>ZYXQuUT6RKoONM/EiI+GF?cCB\$@?>=<5Y927654-Q10/.-,+*)('&f\$#"!~w=^zyrwvo5srqponmlkjihJfedcba`_^]VzZYXQVUTMqQPON0FEiIHGFED&BA@?>=<;:92V65u-Q1*/(L,%*)('&%\$#"!~}|u;yxwvXnm3qponmlkjihJf_%cba`Y^]\[TxRWVUTSLpPONMLKJCHGF?cC%;_?87[;:9876543s1*)M-,+*)('&%\$#"!~}|{]yxwvutsrk1ongle+ihgfedFba`Y}]\[Z<XWVUTMRQJnN0LKJIHGF?cCBA@?>=<;:9876543210/.n,+\$H('&%\$#"!~}|{zyxqvutm3kponmle+ihgfedcE"C_^]\[TxXWVUTSR4PONMLEi,HGFE>bBA#?>7<;:98765.R21q/(L,+*)('&%\$#"!~w|u;\\xwvun4rkpoh.lkjihgfedcE"`_^]\[ZYXW9UTSRQPONMLKJIHAeEDCBA@?>=};4X876543s10/.',+*)('&%\${A!~}|{zyxwvutsrqpRnmlkjihgfedcba`_^W{[ZYXWV8NrRQPONML.JIHAeED=BA@?8\<5:981U5u3,P0/.-m+*)(!Ef|{A!x}|{t:xwvutVlqponmf,jihgfedcE"`_^]\>ZYXQuUTSRQPONML.JIHAeE>CBA@?8\65Y987w5.R21q/.'K+*)('&f\$#"!~}v<]sxwvun4rqponmlkjihgfedcbD`_^]VzZYXQVUTMqQP2HMLKJIHG@dDCBA@?>=<;:9876v43210/.-,%I)('&%\$#"!aw={zsxwvo5srqpRnmlkjiha'edcE"`_^]\[ZYXWVUT6RKoINGkKJIH*@EDCBA:^!=<;:98765432+O/.-,+*)('~%\${A!aw={zyxZvutmrk1onmlkjihgfedFb[!_^]\[=SwWVU7SLpJONMLKJIHG@dD&<A@?>=<;:3Wx65432+O/o-,+\$H('&%\$#zy?}|{zyxwputsrqpong-kjihJ`_%cba`_^]VUy<RWVUTSRQPONGkKJIHGFEDCBA@?!7<5Y9876543210/.-,+*)('&%\$#"!~}|{z\\xq7otsrqponmlkd*hgfedcb[`_^W{[ZSXWVUTSRQPONMLKJIHGFEDC<`@?>=<|:3W76543210/o-,+*)('&}C#"b~}|{tyr8vutsrqponmlkjihgfedcbD`_^]VzZYXQVUTSRQJnNML.DIHG@dD&BA@?8\<|:9876/S-210)Mn,+*)('&%\$#"!~}|{zyxq7utsrqpRhmf,jihgfedcbD`_^]VzZYRQuUTS5QPINMFjJI+GF?cCBA@?!=<;:987654-Qr0)Mn&+*)('&%\${A!~}|{]yxwvutsrqponmle+ihgfedcba`_^]\[=Sw:VUTSRKoINGkKJIH*@E>b<A@?8\};:9870T4-,P0/.-m%*)"F&%\$d"!~}|u;\\xq7otsrqponmlkd*bg`&dcba`_^@\[ZYXWVUTSLpPINMLKJCgAFEDCBA@?8\}54X876543210/.-,+*)('&%\$d"!~}|{zyxwvutsrqponmlkjihgfedcba`_^]\[ZYXWVUNrRQPONMLKDIHGF?c&<A@?>=<;4X87654t210/.-,%I)('g%\$#"!~}|{zyxwp6tsrkpong-kjihgfedcbD`_^]\[TxX:VOTMqQPO1MLKDhHGFEDC%A@?>=<;:3Wx654-Qr0/.-,+*)('~D\${"!~}|{t:xZvutsrqponmlkjihgfedcba`Y}]\[ZYXWV8TMRQJnNMLKJCgGFE>CBA@?>7[|:981U54t21*/.-&J*)i!E%\$#"!~}|{z\\xq7utslqj0ngle+ihgfedcE"C_^]\[TxXWVUTSRQP2NMLEiIHGFE'CBA@?>7[;{9276543210)M-,+*)(!E%\$#"!~}|{ts9wvunsrqponmlkjihgfedcba`_^]\[TxXWPUTSRQJnNMFjJIHGFE'=aA@?>=<;498765.Rs10).-,+*)"F&%e#"!~}|{zs9wvutVrqponmlkjihg`&dcba`_X]VzZYXWPUTSRKoONM/KJIHGF?cCBA@?>=<|:9876543,P0/.-m+*)(!Ef|#"!~}|{zyr8%
''';
    var koordinaten =   '''bCBA@?>=<;:9876543210/.-,+*)('&%\$#"!~}|{zyxwvutsrqponmlkjihgfedcba`_^]\[ZYXWVUTSRQPONMLKJIHGFEDCBA@9>=<;:987654321*N.-,+*)i'&}C#"!~}|{zyxwvutsrqponmlkjiha`&dcba`_^]?zZYXWVUTSRQPONMLKJIH*FEDCBA@?>=<54X87654321q)M-,+*j('&%\$#"!~}|u;yxwpun4rqponmlkjihJfedc\"C_X]VzZY;WPtTSRQPONGLKJCgGFED=BA@?>=6Z:98765.3210/.'K+k)('&%\$#"!~}|{zs9wYotsl2ponmlNjihgfedcba`_^]\[ZYXQuUT6RKoONMLKJCHGFEDCBA@?8\}5:98765.R2r0/(-&J\$)('&%|B"!~w={zy[wvutmrk1onmlkdihgf_%Fba`Y^W{[ZYXQVOsSLKo2NMLEJIBfFEDCBA@?>=<;498765.R2+O/.-,+*#G'&%\$#"!~}|u;yxwvo5srqponmlkMc)g`e^\$\a`_X|\[ZYXWVUTSR4POHMFjJ,HAFEDC<`@?>=};:9876/S321q/.-&%I)('&f|B"!~}|uzs9Zvutslk1|
''';
    var malbolge =      '''bCBA@?>=<;:9876543210/.-,+*)('&%\$#"!~}|{zyxwvutsrqponmlkjihgfedcba`_^]\[ZYXWVUTSRQPONMLKJIHGFEDCBA@?!=<;:38765432+Op.'K+*)(!&%\$#"!~}|{zyxwvutsrqponmlkjihgfedcba`_^]\[ZYXWVUTSRQPONMFjJIH*F?cCBA:^>=<;:9876543210/.-&J*)i'&}C#"!~}|{tyxwvun4rqpRhmf,jiKgf_%cb[`_^]\[ZSwWVU7SLpPONM/KJIHGFE>b%A@?>=<;:9876543210/.-,+\$H('&}\${A!~}v{zyr8vutVrqponmlkjihgfedcba`_^]Vzg
''';

    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '',  'program' : HelloWorld, 'expectedOutput' : ['Hello World!']},
      {'input' : '',  'program' : Welcome, 'expectedOutput' : ['Welcome']},
      {'input' : '',  'program' : blank, 'expectedOutput' : ['']},
      {'input' : '\n',  'program' : HelloWorld_EU, 'expectedOutput' : ['This program does not use cookies. We have to say this in order to comply with the new EU no-cookie policy. Do you accept this? Press enter to accept.\nHello world!\n']},
      {'input' : '',  'program' : beer, 'expectedOutput' : ['Bottles of beer on the wall, 99 bottles of beer.\nTake one down and pass it around, 98 bottles of beer on the wall.\n\n98 Bottles of beer on the wall, 98 bottles of beer.\nTake one down and pass it around, ']},
      {'input' : '',  'program' : koordinaten, 'expectedOutput' : ['Der Cache liegt bei N 52 27.345 E 013 09.783']},
      {'input' : '',  'program' : malbolge, 'expectedOutput' : ['Mark mag Malbolge']},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = interpretMalbolge(elem['program'], elem['input'], false).output;
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("malbolge.generator", () {

    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : '',  'expectedOutput' : "ioooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooov"},
      {'input' : 'Hello World!',      'expectedOutput' : "ioooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooopooooooooooooooooop<ooo*oop<pooop<pop<oooooooooooooooopoop<oooooo*<ooooo*ooop<ooopooooop<*ooooooooop<oo*op<ooopooooooop<*oopoooooooop<v"},
      {'input' : 'Welcome',           'expectedOutput' : "iooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo*oooooop<ooooooo*oop<pooop<ooooo*oooooooooooooop<*ooooooooooooooooooooooooooooooooop<pooop<*ooop<v"},
      {'input' : 'Der Cache liegt bei N 52 27.345 E 013 09.783',  'expectedOutput' : 'iooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo*opooooooooooooop<oooo*oop<oooooooooooooooooooooooooopp<oooooooo*<ooooooooooooooopoooooooooooooooop<oooooooo*p<oooopoooooop<ooo*ooooop<*oooooooooooooooop<*opop<oo*op<ooooooopooop<o*oop<ooo*op<oo*op<oo*ooooopoop<oooo*oooooooooooooop<ooooooooopooooooooooooooop<*ooooooooooop<*pooooop<ooooooooooo*ooop<o*opop<op<oopoooooop<o*opop<oooo*op<ooooo*ooooopp<poooop<o*pooooop<ooooo*pooooooooop<pop<oopooooop<o*oooooooooopop<ooooooooooo*poooop<oooopop<ooopooooop<o*oopop<o*oopooop<oo*poop<oopop<ooo*opop<pop<oooop<*opop<v'},
      {'input' : 'Mark mag Malbolge', 'expectedOutput' : 'iooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo*oooopooooooop<*op<oooopoooooooooooooooooooooooooooooooooooooooooooooooooooooooop<ooo*op<ooop<oooooooooooooooooop<oo*oop<ooooooopooooop<ooo*pop<oo*oop<oopooooooop<ooo*op<oooo*ooooooop<*ooooooooooooooooooooooop<ooopop<ooopooop<ooo*oooooooooooooooooooooop<v'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = generateMalbolge(elem['input']).assembler.join('');
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}