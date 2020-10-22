import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphic_calculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var userQuestion = '';
  var userAnswer = '';

  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.blueGrey[200],
     body: Column(
       children: [
         Expanded(child: Container(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               SizedBox(height: 10),
               Container(
                 padding: EdgeInsets.all(20),
                 alignment: Alignment.centerLeft,
                 child: Text(userQuestion, style: GoogleFonts.orbitron(fontSize: 20))),
               Container(
                 padding: EdgeInsets.all(20),
                 alignment: Alignment.centerRight,
                 child: Text(userAnswer, style: GoogleFonts.orbitron(fontSize: 20)))
             ],
           ),
         )),
         Expanded(
           flex: 2,
           child: Container(
           color: Colors.blueGrey[200],
           child: GridView.builder(
             itemCount: buttons.length,
             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
              itemBuilder: (BuildContext context, int index){
                return CalculatorButtons(
                  buttonTap: () => {
                    setState((){
                      if(index == 0){
                        userQuestion = '';
                        userAnswer = '';
                      } else if (index == 1){ 
                        userQuestion = userQuestion.substring(0,userQuestion.length-1);
                      } else if(index == buttons.length-1){
                        equalPressed();
                      } else{
                      userQuestion += buttons[index];
                      }
                    })
                  },
                  textColor: isOperator(buttons[index]) ? Colors.black: Colors.teal,
                  buttonText: buttons[index],
                  color: isOperator(buttons[index]) ? Colors.orange[400]: Colors.grey[100],
                );
              }
            ),
         ))
       ],
     ),
   );
  }

  bool isOperator(String x){
    if(x == '%' || x == 'x' || x == '/' || x == '-' || x == '+' || x == '=' || x == 'DEL' || x == 'C'){
      return true;
    } 
    return false;
  }

  void equalPressed(){
    String finalResult = userQuestion;
    finalResult = finalResult.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalResult);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
