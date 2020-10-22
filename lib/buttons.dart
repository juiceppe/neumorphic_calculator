import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CalculatorButtons extends StatelessWidget {

  final String buttonText;
  final color;
  final buttonTap;
  final textColor;

  CalculatorButtons({this.buttonText, this.color, this.textColor, this.buttonTap});

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: buttonTap,
       margin: EdgeInsets.all(7),
       style: NeumorphicStyle( 
        border: NeumorphicBorder(
          isEnabled: true,
          color: Colors.grey,
          width: 0.1
        ),
        color: color,
        shape: NeumorphicShape.concave,
            boxShape: NeumorphicBoxShape.circle(), 
            depth: 20,
            lightSource: LightSource.topLeft,
       ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 20,
                color: textColor
              ),
            ),
          )
    );
  }
}