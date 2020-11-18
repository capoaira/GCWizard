import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/chef_language/chef_language.dart';

void main() {

  group("chef_language.generateChef", () {

    String testNull = '''.

Ingredients.


Method.

Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.
''';
    String testTitle = '''Marks marvellous must have.

Ingredients.


Method.

Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.
''';
    String testTitleComments = '''Marks marvellous must have.

to be a wizard

Ingredients.


Method.

Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.
''';
    String testTitleCommentsTime = '''Marks marvellous must have.

to be a wizard

Ingredients.


Cooking time: 50 minutes.

Method.

Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.
''';
    String testTitleCommentsTimeTemp = '''Marks marvellous must have.

to be a wizard

Ingredients.


Cooking time: 50 minutes.

Pre-heat oven to 180 degrees Celsius.

Method.

Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.
''';

    List<Map<String, dynamic>> _inputsToExpected = [
      {'language' : 'ENG', 'auxilary' : false, 'input' : '', 'title' : '',   'remark' : '', 'time' : '', 'temperature' : '', 'expectedOutput' : testNull},
      {'language' : 'ENG', 'auxilary' : false, 'input' : '', 'title' : 'Marks marvellous must have',   'remark' : '', 'time' : '',   'temperature' : '', 'expectedOutput' : testTitle},
      {'language' : 'ENG', 'auxilary' : false, 'input' : '', 'title' : 'Marks marvellous must have', 'remark' : 'to be a wizard',   'time' : '',   'temperature' : '', 'expectedOutput' : testTitleComments},
      {'language' : 'ENG', 'auxilary' : false, 'input' : '', 'title' : 'Marks marvellous must have',   'remark' : 'to be a wizard', 'time' : '50', 'temperature' : '', 'expectedOutput' : testTitleCommentsTime},
      {'language' : 'ENG', 'auxilary' : false, 'input' : '', 'title' : 'Marks marvellous must have',   'remark' : 'to be a wizard', 'time' : '50', 'temperature' : '180', 'expectedOutput' : testTitleCommentsTimeTemp},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = generateChef(elem['language'], elem['title'], elem['remark'], elem['time'], elem['temperature'], elem['input'], elem['auxilary']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group("chef_language.interpretChef:", () {
    // OK OK    Empty recipe
    var test0 = '';

    // OK OK    Hello World Souffle
    var test1 = '''Hello World Souffle

This recipe prints the immortal words "Hello world!", in a basically brute force way. It also makes a lot of food for one person.

Ingredients.
72 g haricot beans
101 eggs
108 g lard
111 cups oil
32 zucchinis
119 ml water
114 g red salmon
100 g dijon mustard
33 potatoes

Method.
Put potatoes into the mixing bowl.
Put dijon mustard into the mixing bowl.
Put lard into the mixing bowl.
Put red salmon into the mixing bowl.
Put oil into the mixing bowl.
Put water into the mixing bowl.
Put zucchinis into the mixing bowl.
Put oil into the mixing bowl.
Put lard into the mixing bowl.
Put lard into the mixing bowl.
Put eggs into the mixing bowl.
Put haricot beans into the mixing bowl.
Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.

''';

    // OK OK    Factorial and Fish => Input
    var test3 = '''Factorial and Fish

A salty recipe for a fine fish. A tad raw, but definitely salty.

Ingredients.
1 salmon
1 pinch salt

Methods.
Take salt from refrigerator.
Put salmon into mixing bowl.
Spread the salt.
Combine salt.
Shake the salt until spreaded.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // OK OK    Fibonacci Du Fromage
    var test4 = '''Fibonacci Du Fromage

An improvement on the Fibonacci with Caramel Sauce recipe. Much less for the sweettooths, much more correct.

Ingredients.
5 g numbers
1 g cheese

Method.
Take numbers from refrigerator.
Put cheese into mixing bowl.
Put cheese into mixing bowl.
Put numbers into 2nd mixing bowl.
Remove cheese from 2nd mixing bowl.
Remove cheese from 2nd mixing bowl.
Fold numbers into 2nd mixing bowl.
Put numbers into 2nd mixing bowl.
Calculate the numbers.
Serve with salt and pepper.
Ponder the numbers until calculated.
Add cheese to 2nd mixing bowl.
Add cheese to 2nd mixing bowl.
Fold numbers into 2nd mixing bowl.
Move the numbers.
Fold cheese into mixing bowl.
Put cheese into 2nd mixing bowl.
Transfer the numbers until moved.
Pour contents of the 2nd mixing bowl into the baking dish.

Serves 1.

Salt and pepper

Ingredients.
1 g salt
1 g pepper

Method.
Fold salt into mixing bowl.
Fold pepper into mixing bowl.
Clean mixing bowl.
Put salt into mixing bowl.
Add pepper.''';

    // OK OK    Fruit Loops
    var test6 = '''Fruit Loops

Do we need to have 280 brands of breakfast cereal? No, probably not. But we have them for a reason - because some people like them.

Ingredients.
300 g milk
100 g fruit
20 g loops
20 g sugar
4 g chocolate sprinkles

Method.
Put milk into the mixing bowl.
Prepare the loops.
Add sugar.
Sprinkle the chocolate sprinkles.
Add chocolate sprinkles.
Set aside.
Sprinkle until sprinkled.
Mix the loops until prepared.
Add fruit.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // OK OK    Greatest Common Dijon Mustard => Input
    var test7 = '''Greatest Common Dijon Mustard

Ingredients.
1 tablespoon mustard seeds
1 tablespoon dry wine
3 pinches salt

Methods.
Take mustard seeds from refrigerator.
Take dry wine from refrigerator.
Age the dry wine.
	Put mustard seeds into mixing bowl.
	Divide dry wine.
	Combine dry wine.
	Fold salt into mixing bowl.
	Put mustard seeds into mixing bowl.
	Remove salt.
	Put dry wine into mixing bowl.
	Fold mustard seeds into mixing bowl.
	Fold dry wine into mixing bowl.
Leave until aged.
Put mustard seeds into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // OK OK    Hello World Souffle => aux Recipe
    var test8 = '''Hello World Souffle

This recipe prints the immortal words "Hello world!", by getting one souschef to make the souffle and another to brew the sauce.

Ingredients.
32 zucchinis
33 potatoes

Method.
Put potatoes into the mixing bowl.
Serve with World Sauce.
Put zucchinis into the mixing bowl.
Serve with Hello Souffle.
Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.

Hello Souffle

Ingredients.
72 g haricot beans
101 eggs
108 g lard
111 cups oil

Method.
Clean mixing bowl.
Put oil into the mixing bowl.
Put lard into the mixing bowl.
Put lard into the mixing bowl.
Put eggs into the mixing bowl.
Put haricot beans into the mixing bowl.

World Sauce

Ingredients.
111 cups oil
119 ml water
114 g red salmon
100 g dijon mustard
108 g lard

Method.
Clean mixing bowl.
Put dijon mustard into the mixing bowl.
Put lard into the mixing bowl.
Put red salmon into the mixing bowl.
Put oil into the mixing bowl.
Put water into the mixing bowl.''';

    // OK OK    Peas and Power => Input Input
    var test9 = '''Peas and Power

Ingredients.
200 g peas
10 carrots
1 pot

Methods.
Take peas from refrigerator.
Take carrots from refrigerator.
Put pot into mixing bowl.
Shake the carrots.
	Combine peas.
Shake the carrots until shaken.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    //          Bubbled an Bacon => Input x  and x numbers to sort
    var test10 = '''Bubbled and Baked Bacon

A tasty bacon recipe, leaving it all baked and bubbled with a little decorative flag skewer on top.
All arranged in the right order, of course. It's a pity for whoever gets to do the dishes, though; the recipe uses 4 bowls, one of which exclusively for a little wooden flag.

Ingredients.
12 slices
375 g bacon
1 flag skewer

Methods.
Take slices from refrigerator.
Put slices into 3rd mixing bowl.
Store the slices.
	Take bacon from refrigerator.
	Put bacon into mixing bowl.
Repeat the slices until stored.
Remove flag skewer from 3rd mixing bowl.
Put flag skewer into 4th mixing bowl.                                                                                                                          
Check the flag skewer.
	Put flag skewer into 4th mixing bowl.
	Remove flag skewer from 4th mixing bowl.
	Fold flag skewer into 4th mixing bowl.
	Fold slices into 3rd mixing bowl.
	Put slices into 3rd mixing bowl.
	Arrange the slices.
		Serve with greater gravy.
		Fold bacon into mixing bowl.
		Bake the bacon.
			Stir the mixing bowl for 1 minutes.
			Fold flag skewer into 4th mixing bowl.
			Put flag skewer into 4th mixing bowl.
		Heat the bacon until baked.
		Fold bacon into mixing bowl.
		Put bacon into 2nd mixing bowl.
	Arrange the slices until arranged.
	Fold slices into 3rd mixing bowl.
	Put slices into 3rd mixing bowl.
	Arrange the slices.
		Fold bacon into 2nd mixing bowl.
		Put bacon into mixing bowl.
	Arrange the slices until arranged.
Sort until checked.
Pour contents of the mixing bowl into the baking dish.

Serves 1.

Greater gravy

If the top-most ingredient in the mixing bowl is bigger than the one below it, this adds 1 ml of gravy to the mixing bowl. Otherwise, 0 ml of gravy is added.

Ingredients.
125 ml water
50 ml cream
1 ml milk
0 pinches salt
2 tablespoons corn starch

Methods.
Fold cream into mixing bowl.
Fold water into mixing bowl.
Put cream into mixing bowl.
Remove water.
Fold corn starch into mixing bowl.
Clean mixing bowl.
Put salt into mixing bowl.
Whisk the corn starch.
	Add milk.
	Set aside.
Whisk until whisked.''';

    // OK OK     SELFMADE Mum Heides delicious quiche.
    var test12 = '''Mum Heides delicious quiche.

Find some own words to descripe the recipe. Keep it funny.

Ingredients.
10 eggs
13 g flour
10 ml milk
13 ml water
10 g sugar
110 g onions
101 g beans
116 g powdered-sugar
97 g almonds
105 g grapefruit
100 ml sauce
114 g pecans
111 g peanuts
75 pinch salt

Method.
Put eggs into mixing bowl. Put flour into mixing bowl. Put milk into mixing bowl. Put water into mixing bowl. Put sugar into mixing bowl. Put flour into mixing bowl. Put eggs into mixing bowl. Put flour into mixing bowl. Put eggs into mixing bowl. Put flour into mixing bowl. Put onions into mixing bowl. Put beans into mixing bowl. Put powdered-sugar into mixing bowl. Put almonds into mixing bowl. Put onions into mixing bowl. Put grapefruit into mixing bowl. Put sauce into mixing bowl. Put pecans into mixing bowl. Put peanuts into mixing bowl. Put peanuts into mixing bowl. Put salt into mixing bowl. Liquefy contents of the mixing bowl. Pour contents of the mixing bowl into the baking dish.

Serves 1.

''';

    // OK OK     SELFMADE A mysterious marmelade cake.
    var test13 = '''A mysterious marmelade cake. 

Giving power to the brain while waiting for an idea.

Ingredients. 
56 garlic cloves
48 almonds
55 onions
32 pinch salt
101 eggs
50 pinch pepper
51 ml milk
52 dashes lemon juice
110 pinch baking soda

Method. 
Put garlic cloves into the mixing bowl.
Put almonds into the mixing bowl.
Put onions into the mixing bowl.
Put salt into the mixing bowl.
Put eggs into the mixing bowl.
Put salt into the mixing bowl.
Put pepper into the mixing bowl.
Put milk into the mixing bowl.
Put lemon juice into the mixing bowl.
Put salt into the mixing bowl.
Put baking soda into the mixing bowl.
Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish. 

Serves 1.
''';

    // OK OK     https://metacpan.org/source/SMUELLER/Acme-Chef-1.01/examples/stdin.chef
    var test14 = '''STDIN stew.

Read flour from STDIN and output it.

Ingredients.
flour

Method.
Take flour from refrigerator.
Put flour into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // OK OK     https://metacpan.org/source/SMUELLER/Acme-Chef-1.01/examples/japh.chef
    var test15 = '''JAPH Souffle.

Ingredients.
44 potatoes
114 onions
101 g flour
107 kg salt
99 bottles of beer
97 cups acid
72 l oil
32 pins
8 l urine
108 pines
101 laptops
80 mouses
47 keyboards
102 idiots
104 hackers
67 voodoo puppets
116 crackpipes
111 megawatts
110 numbers
97 commas
115 dweebs
117 sheep
74 creeps

Method.
Put potatoes into the mixing bowl.
Put onions into the mixing bowl.
Put flour into the mixing bowl.
Put salt into the mixing bowl.
Put bottles of beer into the mixing bowl.
Put acid into the mixing bowl.
Put oil into the mixing bowl.
Put pins into the mixing bowl.
Put pines into the mixing bowl.
Put onions into the mixing bowl. 
Put laptops into the mixing bowl. 
Put mouses into the mixing bowl. 
Put keyboards into the mixing bowl. 
Put idiots into the mixing bowl. 
Put flour into the mixing bowl.
Put hackers into the mixing bowl. 
Put voodoo puppets into the mixing bowl. 
Put pins into the mixing bowl. 
Put onions into the mixing bowl. 
Put flour into the mixing bowl. Put hackers into the mixing bowl. 
Put crackpipes into the mixing bowl. 
Put megawatts into the mixing bowl. Put numbers into the mixing bowl. 
Put commas into the mixing bowl. Put pins into the mixing bowl. 
Put crackpipes into the mixing bowl. Put dweebs into the mixing bowl. 
Put sheep into the mixing bowl. 
Put creeps into the mixing bowl. 
Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.
''';

    // OK OK     https://metacpan.org/source/SMUELLER/Acme-Chef-1.01/examples/exp.chef
    var test16 = '''Calculate exponentiation: sugar ^ flour.

Ingredients.
3 kg flour
2 g sugar
1 egg

Method.
Put flour into mixing bowl.
Bake the flour.
  Remove egg.
  Fold flour into mixing bowl.
  Put sugar into mixing bowl.
  Cool the flour.
    Combine sugar.
  Water the flour until cooled.
  Pour contents of the mixing bowl into the baking dish.
  Refrigerate for 1 hour.
Heat until baked.
Clean mixing bowl.
Put egg into mixing bowl.
Stir for 2 minutes.
Pour contents of the mixing bowl into the baking dish.
Refrigerate for 1 hour.

Serves 1.''';

    //  OK OK    https://metacpan.org/source/SMUELLER/Acme-Chef-1.01/examples/fac.chef
    var test17 = '''Factorial.

Ingredients.
12 cups vodka
1 bucket
1 toilet

Method.
Waste the bucket.
  Put vodka into mixing bowl.
  Serve with drug coctail.
  Fold toilet into mixing bowl.
  Clean mixing bowl.
  Put toilet into mixing bowl.
Puke the bucket until wasted.
Pour contents of the mixing bowl into the baking dish.

Serves 1.


Drug coctail.

Ingredients.
300 cigarettes
1 kg cannabis

Method.
Fold cigarettes into the mixing bowl.
Put cannabis into the mixing bowl.
Smoke the cigarettes.
  Combine cigarettes.
Breathe the cigarettes until smoked.
Fold cigarettes into the mixing bowl.
Clean mixing bowl.
Put cigarettes into mixing bowl.''';

    var test20 = '''Demo.

Gibt aus N 437 E 708 magnetisch

Zutaten.
32 ml ambra
109 Spritzer Zitronensaft
97 ml Eigelb
103 ml Öl
110 ml Calvados
101 ml Ouzo
116 ml saure Sahne
105 ml Bier
115 ml Korn
99 Tropfen flüssige Vanille
104 Spritzer Tabasco
69 ml Sahne
78 ml Whisky

Zubereitung.
Gebe Tabasco in die Rührschüssel.
Gebe flüssige Vanille in die Rührschüssel.
Gebe Korn in die Rührschüssel.
Gebe Bier in die Rührschüssel.
Gebe saure Sahne in die Rührschüssel.
Gebe Ouzo in die Rührschüssel.
Gebe Calvados in die Rührschüssel.
Gebe Öl in die Rührschüssel.
Gebe Eigelb in die Rührschüssel.
Gebe Zitronensaft in die Rührschüssel.
Gebe ambra in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.
Säubere die Rührschüssel.
Serviere mit cremige bittere Currychips.
Gebe ambra in die Rührschüssel.
Gebe Sahne in die Rührschüssel.
Gebe ambra in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.
Säubere die Rührschüssel.
Serviere mit schwere scharfe Currydressing.
Gebe ambra in die Rührschüssel.
Gebe Whisky in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.


cremige bittere Currychips

Zutaten.
12 g schmalz
59 Prisen Kümmel

Zubereitung.
Gebe schmalz in die Rührschüssel.
Kombiniere Kümmel in die Rührschüssel.


schwere scharfe Currydressing

Zutaten.
19 Prisen Anis
23 g Marmelade

Zubereitung.
Gebe Anis in die Rührschüssel.
Kombiniere Marmelade in die Rührschüssel.''';

    List<Map<String, dynamic>> _inputsToExpected = [
      {'language' : 'ENG', 'input' : '',   'recipe' : test0, 'isValid' : false, 'expectedOutput' : []},
      {'language' : 'ENG', 'input' : '',   'recipe' : test1,   'isValid' : true, 'expectedOutput' : ['Hello world!']},
      {'language' : 'ENG', 'input' : '5',   'recipe' : test3,   'isValid' : true, 'expectedOutput' : ['120']},
      {'language' : 'ENG', 'input' : '',   'recipe' : test3,   'isValid' : true, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_missing_input']},
      {'language' : 'ENG', 'input' : '20',   'recipe' : test4,   'isValid' : true, 'expectedOutput' : ['11235813213455891442333776109871597258441816765']},
      {'language' : 'ENG', 'input' : '',   'recipe' : test4,   'isValid' : true, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_missing_input']},
      {'language' : 'ENG', 'input' : '',   'recipe' : test6,   'isValid' : true, 'expectedOutput' : ['880']},
      {'language' : 'ENG', 'input' : '8 12',   'recipe' : test7,   'isValid' : true, 'expectedOutput' : ['4']},
      {'language' : 'ENG', 'input' : '',   'recipe' : test8,   'isValid' : true, 'expectedOutput' : ['Hello world!']},
      {'language' : 'ENG', 'input' : '2 4','recipe' : test9,   'isValid' : true, 'expectedOutput' : ['16']},
      {'language' : 'ENG', 'input' : '4 5 7 6 8',   'recipe' : test10,   'isValid' : true, 'expectedOutput' : ['5678']},
      {'language' : 'ENG', 'input' : '',   'recipe' : test12,   'isValid' : true, 'expectedOutput' : ['Koordinaten\r\n\r\n\r\n\r\n\r\n']},
      {'language' : 'ENG', 'input' : '',   'recipe' : test13,   'isValid' : true, 'expectedOutput' : ['n 432 e 708']},
      {'language' : 'ENG', 'input' : '5',   'recipe' : test14,   'isValid' : true, 'expectedOutput' : ['5']},
      {'language' : 'ENG', 'input' : '',   'recipe' : test14,   'isValid' : true, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_missing_input','']},
      {'language' : 'ENG', 'input' : '',   'recipe' : test15,   'isValid' : true, 'expectedOutput' : ['Just another Chef/Perl Hacker,']},
      {'language' : 'ENG', 'input' : '',   'recipe' : test16,   'isValid' : true, 'expectedOutput' : ['8']},
      {'language' : 'ENG', 'input' : '5',   'recipe' : test17,   'isValid' : true, 'expectedOutput' : ['479001600']},
      {'language' : 'DEU', 'input' : '',   'recipe' : test17,   'isValid' : true, 'expectedOutput' : ['N 437 E 708 magnetisch']},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = interpretChef(elem['language'], elem['recipe'].toLowerCase().replaceAll('-', ' '), elem['input']);
        var length = elem['expectedOutput'].length;
        for (int i = 0; i < length; i++) {
          expect(_actual[i], elem['expectedOutput'][i]);
        }
      });
    });
  }); // group

  group("chef_language.MethodExamples", () {

    // take
    var take = '''Test TAKE.

Ingredients.
input

Method.
Take input from refrigerator.
Put input into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // put
    var put = '''Test PUT.

Ingredients.
10 salt

Method.
Put salt into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // fold
    var fold = '''Test FOLD.

Ingredients.
10 salt
pepper

Method.
Put salt into mixing bowl.
Fold pepper into mixing bowl.
Put pepper into mixing bowl.
Put pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // add
    var add = '''Test ADD.

Ingredients.
10 salt
10 pepper

Method.
Put salt into mixing bowl.
Put salt into mixing bowl.
Add pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // remove
    var remove = '''Test REMOVE.

Ingredients.
10 salt
10 pepper

Method.
Put salt into mixing bowl.
Put salt into mixing bowl.
Remove pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // combine
    var combine = '''Test COMBINE.

Ingredients.
10 salt
10 pepper

Method.
Put salt into mixing bowl.
Put salt into mixing bowl.
Combine pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // divide
    var divide = '''Test DIVIDE.

Ingredients.
10 salt
10 pepper

Method.
Put salt into mixing bowl.
Put salt into mixing bowl.
Divide pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // addry
    var addry = '''Test ADDRY.

Ingredients.
10 salt
10 pepper

Method.
Add dry ingredients to mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // liquefyingredient
    var liquefyingredient = '''Test LIQUEFYINGREDIENT.

Ingredients.
65 salt
80 pepper

Method.
Put salt into mixing bowl.
Put pepper into mixing bowl.
Liquefy salt.
Put salt into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // liquefybowl
    var liquefybowl = '''Test LIQUEFYBOWL.

Ingredients.
65 salt
80 pepper

Method.
Put salt into mixing bowl.
Put pepper into mixing bowl.
Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // stir
    var stir = '''Test STIR.

Ingredients.
1 sugar
2 salt
3 salmon
4 pepper
5 wine
6 wodka

Method.
Put sugar into mixing bowl.
Put salt into mixing bowl.
Put salmon into mixing bowl.
Put pepper into mixing bowl.
Put wine into mixing bowl.
Put wodka into mixing bowl.
Stir for 2 minutes.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // stiringredient 2654321 => 6524321
    var stiringredient = '''Test STIRINGREDIENT INTO THE MIXING BOWL

Ingredients.
1 sugar
2 salt
3 salmon
4 pepper
5 wine
6 wodka

Method.
Put sugar into mixing bowl.
Put salt into mixing bowl.
Put salmon into mixing bowl.
Put pepper into mixing bowl.
Put wine into mixing bowl.
Put wodka into mixing bowl.
Put salt into mixing bowl.
Stir salt into the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // clean
    var clean = '''Test CLEAN.

Ingredients.
65 salt
80 pepper

Method.
Put salt into mixing bowl.
Put pepper into mixing bowl.
Clean mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // loop
    var loop = '''Test LOOP.

Ingredients.
5 g salt
80 g pepper

Method.
Count the salt.
   Put pepper into mixing bowl.
   Add pepper into mixing bowl.
   Fold pepper into mixing bowl.
Count the salt until counted.
Put pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // serve
    var serve = '''Test SERVE.

Ingredients.
5 g salt
80 g pepper
0 air

Method.
Put air into mixing bowl.
Count the salt.
   Serve with chili.
Count the salt until counted.
Pour contents of the mixing bowl into the baking dish.

Serves 1.


chili.

Ingredients.
1 g harissa

Method.
Add harissa into mixing bowl.''';

    // refrigerate
    var refrigerate = '''Test REFRIGERATE.

Ingredients.
65 salt
80 pepper

Method.
Put salt into mixing bowl.
Put pepper into mixing bowl.
Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.
Refrigerate.

Serves 1.''';

    // refrigeratenumber
    var refrigeratenumber = '''Test REFRIGERATE.

Ingredients.
65 salt
80 pepper

Method.
Put salt into mixing bowl.
Put pepper into mixing bowl.
Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.
Refrigerate for 1 hours.

Serves 1.''';

    List<Map<String, dynamic>> _inputsToExpected = [
      {'language' : 'ENG', 'input' : '5',  'recipe' : take, 'isValid' : false, 'expectedOutput' : ['5']},
      {'language' : 'ENG', 'input' : '',  'recipe' : take, 'isValid' : false, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_missing_input']},
      {'language' : 'ENG', 'input' : '',   'recipe' : put,   'isValid' : true, 'expectedOutput' : ['10']},
      {'language' : 'ENG', 'input' : '',   'recipe' : fold,   'isValid' : true, 'expectedOutput' : ['1010']},
      {'language' : 'ENG', 'input' : '',   'recipe' : add,   'isValid' : true, 'expectedOutput' : ['2010']},
      {'language' : 'ENG', 'input' : '',   'recipe' : remove,   'isValid' : true, 'expectedOutput' : ['010']},
      {'language' : 'ENG', 'input' : '',   'recipe' : combine,   'isValid' : true, 'expectedOutput' : ['10010']},
      {'language' : 'ENG', 'input' : '',   'recipe' : divide,   'isValid' : true, 'expectedOutput' : ['110']},
      {'language' : 'ENG', 'input' : '',   'recipe' : addry,   'isValid' : true, 'expectedOutput' : ['20']},
      {'language' : 'ENG', 'input' : '',   'recipe' : liquefyingredient,   'isValid' : true, 'expectedOutput' : ['A8065']},
      {'language' : 'ENG', 'input' : '',   'recipe' : liquefybowl,   'isValid' : true, 'expectedOutput' : ['PA']},
      {'language' : 'ENG', 'input' : '',   'recipe' : stir,   'isValid' : true, 'expectedOutput' : ['546321']},
      {'language' : 'ENG', 'input' : '2654321',   'recipe' : stiringredient,   'isValid' : true, 'expectedOutput' : ['6524321']},
      {'language' : 'ENG', 'input' : '',   'recipe' : clean,   'isValid' : true, 'expectedOutput' : ['']},
      {'language' : 'ENG', 'input' : '',   'recipe' : loop,   'isValid' : true, 'expectedOutput' : ['2560']},
      {'language' : 'ENG', 'input' : '',   'recipe' : serve,   'isValid' : true, 'expectedOutput' : ['55555555555555555555555555555555']},
      {'language' : 'ENG', 'input' : '',   'recipe' : refrigerate,   'isValid' : true, 'expectedOutput' : []},
      {'language' : 'ENG', 'input' : '',   'recipe' : refrigeratenumber,   'isValid' : true, 'expectedOutput' : ['PA']},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = interpretChef(elem['language'], elem['recipe'].toLowerCase().replaceAll('-', ' '), elem['input']);
        var length = elem['expectedOutput'].length;
        for (int i = 0; i < length; i++) {
          expect(_actual[i], elem['expectedOutput'][i]);
        }
      });
    });
  });

  group("chef_language.testErrors", () {

    // NO INPUT
    var testNoInput = '''Test NO INPUT.

Ingredients.
input

Method.
Take input from refrigerator.
Put input into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // put
    var testPutNoInput = '''Test PUT.

Ingredients.
10 gr salt

Method.
Put into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // fold into empty bowl
    var testFoldEmptyBow = '''Test FOLD empty bowl.

Ingredients.
10 g salt
10 g pepper

Method.
Fold pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // add to empty bowl
    var testAddEmptyBowl = '''Test ADD empty bowl.

Ingredients.
10 g salt
10 g pepper

Method.
Add pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // remove from empty bol
    var testRemoveEmptyBowl = '''Test REMOVE empty bowl.

Ingredients.
10 g salt
10 g pepper

Method.
Remove pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // combine with empty bowl
    var testCombineEmptyBowl = '''Test COMBINE with empty bowl.

Ingredients.
10 g salt
10 g pepper

Method.
Combine pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // divide into empty bowl
    var testDivideEmptyBowl = '''Test DIVIDE into empry bowl.

Ingredients.
10 g salt
10 g pepper

Method.
Divide pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // addry
    var testAddryNoIngredients = '''Test ADDRY.

Ingredients.
10 ml salt
10 ml pepper

Method.
Add dry ingredients to mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // liquefybowl empty bowl
    var testLiquefyEmptyBowl = '''Test LIQUEFY empty bowl.

Ingredients.
65 g salt
80 g pepper

Method.
Liquefy contents of the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // stir emptyBowl
    var testStirEmptyBowl = '''Test STIR empty bowl.

Ingredients.
1 sugar
2 salt
3 salmon
4 pepper
5 wine
6 wodka

Method.
Stir for 2 minutes.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // stiringredient
    var testStirNoIngredient = '''Test STIRINGREDIENT INTO THE MIXING BOWL

Ingredients.
1 sugar
2 salt
3 salmon
4 pepper
5 wine
6 wodka

Method.
Put sugar into mixing bowl.
Put salmon into mixing bowl.
Put pepper into mixing bowl.
Put wine into mixing bowl.
Stir salt into the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // stiringredient
    var testStirEmptyIngredient = '''Test STIRINGREDIENT INTO THE MIXING BOWL

Ingredients.
1 sugar
salt
3 salmon
4 pepper
5 wine
6 wodka

Method.
Put sugar into mixing bowl.
Put salmon into mixing bowl.
Put pepper into mixing bowl.
Put wine into mixing bowl.
Stir salt into the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // loop
    var testLoopWrongEnd = '''Test LOOP.

Ingredients.
5 g salt
80 g pepper

Method.
Count the salt.
   Put pepper into mixing bowl.
   Add pepper into mixing bowl.
   Fold pepper into mixing bowl.
Count salt until counted.
Put pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // loop
    var testLoopWrongStart = '''Test LOOP.

Ingredients.
5 g salt
80 g pepper

Method.
Count salt.
   Put pepper into mixing bowl.
   Add pepper into mixing bowl.
   Fold pepper into mixing bowl.
Count the salt until counted.
Put pepper into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.''';

    // serve
    var testServeNoRecipe = '''Test SERVE.

Ingredients.
5 g salt
80 g pepper
0 air

Method.
Put air into mixing bowl.
Count the salt.
   Serve chili.
Count the salt until counted.
Pour contents of the mixing bowl into the baking dish.

Serves 1.


chili.

Ingredients.
1 g harissa

Method.
Add harissa into mixing bowl.''';

    // serve
    var testServeNoNumber = '''Test SERVE.

Ingredients.
5 g salt
80 g pepper
0 air

Method.
Put air into mixing bowl.
Add pepper into mixing bowl.
Combine salt into mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves.''';

    List<Map<String, dynamic>> _inputsToExpected = [
      {'language' : 'ENG', 'input' : '',  'recipe' : testNoInput, 'isValid' : false, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_missing_input']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testPutNoInput,   'isValid' : true, 'expectedOutput' : ['chef_error_syntax','chef_error_syntax_method','1 : put into mixing bowl','']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testFoldEmptyBow,   'isValid' : true, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_folded_from_empty_mixing_bowl','chef_error_runtime_method_step','1 : Type.Fold => 1']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testAddEmptyBowl,   'isValid' : true, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_add_to_empty_mixing_bowl','chef_error_runtime_method_step','1 : Type.Add => 1']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testRemoveEmptyBowl,   'isValid' : true, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_remove_from_empty_mixing_bowl','chef_error_runtime_method_step','1 : Type.Remove => 1']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testCombineEmptyBowl,   'isValid' : true, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_combine_with_empty_mixing_bowl','chef_error_runtime_method_step','1 : Type.Combine => 1']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testDivideEmptyBowl,   'isValid' : true, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_divide_from_empty_mixing_bowl','chef_error_runtime_method_step','1 : Type.Divide => 1']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testAddryNoIngredients,   'isValid' : true, 'expectedOutput' : ['0']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testLiquefyEmptyBowl,   'isValid' : true, 'expectedOutput' : ['']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testStirEmptyBowl,   'isValid' : true, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_stir_empty_mixing_bowl','chef_error_runtime_method_step','1 : Type.Stir => 1']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testStirNoIngredient,   'isValid' : true, 'expectedOutput' : ['4351']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testStirEmptyIngredient,   'isValid' : true, 'expectedOutput' : ['5431']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testLoopWrongEnd,   'isValid' : true, 'expectedOutput' : ['chef_error_syntax','chef_error_syntax_method','5 : count salt until counted',]},
      {'language' : 'ENG', 'input' : '',   'recipe' : testLoopWrongStart,   'isValid' : true, 'expectedOutput' : ['chef_error_syntax','chef_error_syntax_method','1 : count salt',]},
      {'language' : 'ENG', 'input' : '',   'recipe' : testServeNoRecipe,   'isValid' : true, 'expectedOutput' : ['chef_error_syntax','chef_error_syntax_method','3 :   serve chili']},
      {'language' : 'ENG', 'input' : '',   'recipe' : testServeNoNumber,   'isValid' : true, 'expectedOutput' : ['chef_error_syntax','chef_error_syntax_serves','chef_error_syntax_serves_without_number','serves.']},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = interpretChef(elem['language'], elem['recipe'].toLowerCase().replaceAll('-', ' '), elem['input']);
        var length = elem['expectedOutput'].length;
        for (int i = 0; i < length; i++) {
          expect(_actual[i], elem['expectedOutput'][i]);
        }
      });
    });
  });

  group("chef_language.generatedRecipes", () {

      var testDEUgenerated = '''Testrezept in Deutsch.

Nur mal so zum probieren

Zutaten.
56 Spritzer Zitronensaft
48 g Kartoffeln
55 Zwiebeln
32 ml geschlagene Eier
69 Scheiben Brot
50 g Milchschokolade
51 ml Rotwein
52 gr Süßkartoffeln
78 ml Milch

Kochzeit: 50 minuten.

Vorheizen des Ofens auf 160 Grad Celsius.

Zubereitung.
Gebe Zitronensaft in die Rührschüssel.
Gebe Kartoffeln in die Rührschüssel.
Gebe Zwiebeln in die Rührschüssel.
Gebe geschlagene Eier in die Rührschüssel.
Gebe Brot in die Rührschüssel.
Gebe geschlagene Eier in die Rührschüssel.
Gebe Milchschokolade in die Rührschüssel.
Gebe Rotwein in die Rührschüssel.
Gebe Süßkartoffeln in die Rührschüssel.
Gebe geschlagene Eier in die Rührschüssel.
Gebe Milch in die Rührschüssel.
Verflüssige die Inhalte der Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

      var testDEUgeneratedAux = '''Demo .

n 437 e 708 r2d2

Zutaten.
32 ml ambra
50 ml Rum
100 ml Espresso
114 ml Calvados
101 Spritzer Zitronensaft
110 Tropfen flüssige Vanille

Zubereitung.
Gebe Rum in die Rührschüssel.
Gebe Espresso in die Rührschüssel.
Gebe Rum in die Rührschüssel.
Gebe Calvados in die Rührschüssel.
Gebe ambra in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.
Säubere die Rührschüssel.
Serviere mit leichte bittere Honigchips.
Gebe Ambra in die Rührschüssel.
Gebe Zitronensaft in die Rührschüssel.
Gebe ambra in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.
Säubere die Rührschüssel.
Serviere mit fluffige süße Ketchupdressing.
Gebe Ambra in die Rührschüssel.
Gebe flüssige Vanille in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.


leichte bittere Honigchips

Zutaten.
12 g Süßkartoffeln
59 g Kakaopulver

Zubereitung.
Gebe Süßkartoffeln in die Rührschüssel.
Kombiniere Kakaopulver in die Rührschüssel.


fluffige süße Ketchupdressing

Zutaten.
19 Teelöffel Chili
23 Prisen Anis

Zubereitung.
Gebe Chili in die Rührschüssel.
Kombiniere Anis in die Rührschüssel.
''';

      var testENGgeneratedAux = '''Demo .

n 437 e 708 r2d2

Ingredients.
32 ml ambergris
50 ml raki
100 ml calvados
114 ml gin
101 ml sour cream
110 ml water

Method.
Put raki into the mixing bowl.
Put calvados into the mixing bowl.
Put raki into the mixing bowl.
Put gin into the mixing bowl.
Put ambergris into the mixing bowl.
Pour contents of the mixing bowl into the baking dish.
Clean mixing bowl.
Serve with heavy hot ketchupsauce.
Put ambergris into the mixing bowl.
Put sour cream into the mixing bowl.
Put ambergris into the mixing bowl.
Pour contents of the mixing bowl into the baking dish.
Clean mixing bowl.
Serve with creamy sour honeydressing.
Put ambergris into the mixing bowl.
Put water into the mixing bowl.
Pour contents of the mixing bowl into the baking dish.

Serves 1.


heavy hot ketchupsauce

Ingredients.
12 g shrimps
59 g zucchini

Method.
Put shrimps into the mixing bowl.
Combine zucchini into mixing bowl.


creamy sour honeydressing

Ingredients.
19 g cocoa powder
23 g mixed fruits

Method.
Put cocoa powder into the mixing bowl.
Combine mixed fruits into mixing bowl.''';

      List<Map<String, dynamic>> _inputsToExpected = [
        {'language' : 'DEU', 'input' : '',  'recipe' : testDEUgenerated, 'isValid' : false, 'expectedOutput' : ['N 432 E 708']},
        {'language' : 'DEU', 'input' : '',  'recipe' : testDEUgeneratedAux, 'isValid' : false, 'expectedOutput' : ['n 437 e 708 r2d2']},
        {'language' : 'ENG', 'input' : '',  'recipe' : testENGgeneratedAux, 'isValid' : false, 'expectedOutput' : ['n 437 e 708 r2d2']},
      ];

      _inputsToExpected.forEach((elem) {
        test('input: ${elem['input']}', () {
          var _actual = interpretChef(elem['language'], elem['recipe'].toLowerCase().replaceAll('-', ' '), elem['input']);
          var length = elem['expectedOutput'].length;
          for (int i = 0; i < length; i++) {
            expect(_actual[i], elem['expectedOutput'][i]);
          }
        });
      });
  });

  group("chef_language.deuAnweisungen", () {


    // take
    var nehme = '''Test TAKE.

Zutaten.
inGebe

Zubereitung.
Nehme inGebe aus dem Kühlschrank.
Gebe inGebe in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // Gebe
    var gebe = '''Test Gebe.

Zutaten.
10 salz

Zubereitung.
Gebe Salz in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // fold
    var unterhebe = '''Test FOLD.

Zutaten.
10 Salz
Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Unterhebe Pfeffer in die Rührschüssel.
Gebe Pfeffer in die Rührschüssel.
Gebe Pfeffer in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // add
    var fuegehinzu = '''Test ADD.

Zutaten.
10 Salz
10 Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Gebe Salz in die Rührschüssel.
Füge hinzu Pfeffer in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // remove
    var entferne = '''Test REMOVE.

Zutaten.
10 Salz
10 Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Gebe Salz in die Rührschüssel.
Entferne Pfeffer in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // combine
    var kombiniere = '''Test COMBINE.

Zutaten.
10 Salz
10 Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Gebe Salz in die Rührschüssel.
Kombiniere Pfeffer in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // divide
    var teile = '''Test DIVIDE.

Zutaten.
10 Salz
10 Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Gebe Salz in die Rührschüssel.
Teile Pfeffer in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // addry
    var fuegeHinzuTrockeneZutaten = '''Test ADDRY.

Zutaten.
10 Salz
10 Pfeffer

Zubereitung.
Füge hinzu feste Zutaten zur Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // liquefyingredient
    var verfluessigeZutat = '''Test LIQUEFYINGREDIENT.

Zutaten.
65 Salz
80 Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Gebe Pfeffer in die Rührschüssel.
Verflüssige Salz.
Gebe Salz in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // liquefybowl
    var verfluessigeSchuessel = '''Test LIQUEFYBOWL.

Zutaten.
65 Salz
80 Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Gebe Pfeffer in die Rührschüssel.
Verflüssige die Inhalte der Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // stir
    var ruehre = '''Test STIR.

Zutaten.
1 sugar
2 Salz
3 salmon
4 Pfeffer
5 wine
6 wodka

Zubereitung.
Gebe sugar in die Rührschüssel.
Gebe Salz in die Rührschüssel.
Gebe salmon in die Rührschüssel.
Gebe Pfeffer in die Rührschüssel.
Gebe wine in die Rührschüssel.
Gebe wodka in die Rührschüssel.
Rühre für 2 Minuten.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // stiringredient 2654321 => 6524321
    var ruehreZutat = '''Test STIRINGREDIENT INTO THE Rührschüssel

Zutaten.
1 sugar
2 Salz
3 salmon
4 Pfeffer
5 wine
6 wodka

Zubereitung.
Gebe sugar in die Rührschüssel.
Gebe Salz in die Rührschüssel.
Gebe salmon in die Rührschüssel.
Gebe Pfeffer in die Rührschüssel.
Gebe wine in die Rührschüssel.
Gebe wodka in die Rührschüssel.
Gebe Salz in die Rührschüssel.
Rühre Salz in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // clean
    var saeubere = '''Test CLEAN.

Zutaten.
65 Salz
80 Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Gebe Pfeffer in die Rührschüssel.
Säubere die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // loop
    var schleife = '''Test LOOP.

Zutaten.
5 g Salz
80 g Pfeffer

Zubereitung.
Zähle das Salz.
   Gebe Pfeffer in die Rührschüssel.
   Füge hinzu Pfeffer in die Rührschüssel.
   Unterhebe Pfeffer in die Rührschüssel.
prüfe das Salz bis gezählt.
Gebe Pfeffer in die Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.''';

    // serve
    var serviere = '''Test SERVE.

Zutaten.
5 g Salz
80 g Pfeffer
0 air

Zubereitung.
Gebe air in die Rührschüssel.
zähle das Salz.
   Serviere mit chili.
zähle das Salz bis gezählt.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.

Portionen 1.


chili.

Zutaten.
1 g Harissa

Zubereitung.
Füge hinzu harissa in die Rührschüssel.''';

    // Gefriere
    var gefriere = '''Test Gefriere.

Zutaten.
65 Salz
80 Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Gebe Pfeffer in die Rührschüssel.
Verflüssige die Inhalte der Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.
Gefriere.

Portionen 1.''';

    // Gefrierenumber
    var gefriereNummer = '''Test Gefriere.

Zutaten.
65 Salz
80 Pfeffer

Zubereitung.
Gebe Salz in die Rührschüssel.
Gebe Pfeffer in die Rührschüssel.
Verflüssige die Inhalte der Rührschüssel.
Gieße die Inhalte der Rührschüssel auf die Servierplatte.
Gefriere für 1 Stunde.

Portionen 1.''';

    List<Map<String, dynamic>> _inputsToExpected = [
      {'language' : 'DEU', 'input' : '5',  'recipe' : nehme, 'isValid' : false, 'expectedOutput' : ['5']},
      {'language' : 'DEU', 'input' : '',  'recipe' : nehme, 'isValid' : false, 'expectedOutput' : ['chef_error_runtime','chef_error_runtime_missing_input']},
      {'language' : 'DEU', 'input' : '',   'recipe' : gebe,   'isValid' : true, 'expectedOutput' : ['10']},
      {'language' : 'DEU', 'input' : '',   'recipe' : unterhebe,   'isValid' : true, 'expectedOutput' : ['1010']},
      {'language' : 'DEU', 'input' : '',   'recipe' : fuegehinzu,   'isValid' : true, 'expectedOutput' : ['2010']},
      {'language' : 'DEU', 'input' : '',   'recipe' : entferne,   'isValid' : true, 'expectedOutput' : ['010']},
      {'language' : 'DEU', 'input' : '',   'recipe' : kombiniere,   'isValid' : true, 'expectedOutput' : ['10010']},
      {'language' : 'DEU', 'input' : '',   'recipe' : teile,   'isValid' : true, 'expectedOutput' : ['110']},
      {'language' : 'DEU', 'input' : '',   'recipe' : fuegeHinzuTrockeneZutaten,   'isValid' : true, 'expectedOutput' : ['20']},
      {'language' : 'DEU', 'input' : '',   'recipe' : verfluessigeZutat,   'isValid' : true, 'expectedOutput' : ['A8065']},
      {'language' : 'DEU', 'input' : '',   'recipe' : verfluessigeSchuessel,   'isValid' : true, 'expectedOutput' : ['PA']},
      {'language' : 'DEU', 'input' : '',   'recipe' : ruehre,   'isValid' : true, 'expectedOutput' : ['546321']},
      {'language' : 'DEU', 'input' : '2654321',   'recipe' : ruehreZutat,   'isValid' : true, 'expectedOutput' : ['6524321']},
      {'language' : 'DEU', 'input' : '',   'recipe' : saeubere,   'isValid' : true, 'expectedOutput' : ['']},
      {'language' : 'DEU', 'input' : '',   'recipe' : schleife,   'isValid' : true, 'expectedOutput' : ['2560']},
      {'language' : 'DEU', 'input' : '',   'recipe' : serviere,   'isValid' : true, 'expectedOutput' : ['55555555555555555555555555555555']},
      {'language' : 'DEU', 'input' : '',   'recipe' : gefriere,   'isValid' : true, 'expectedOutput' : []},
      {'language' : 'DEU', 'input' : '',   'recipe' : gefriereNummer,   'isValid' : true, 'expectedOutput' : ['PA']},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () {
        var _actual = interpretChef(elem['language'], elem['recipe'].toLowerCase().replaceAll('-', ' '), elem['input']);
        var length = elem['expectedOutput'].length;
        for (int i = 0; i < length; i++) {
          expect(_actual[i], elem['expectedOutput'][i]);
        }
      });
    });
  });


}