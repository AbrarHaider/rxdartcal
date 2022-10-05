import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calbtn(String btntxt, Color btncolor, Color txtcolor) {
    return Container(
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: () {
          calculation(btntxt);
        },
        child: Text(
          btntxt,
          style: TextStyle(
            fontSize: 20,
            color: txtcolor,
          ),
        ),
        shape: CircleBorder(),
        color: btncolor,
        padding: EdgeInsets.all(20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf3f6db5),
      appBar: AppBar(
        backgroundColor: Color(0xf3f6db5),
        title: Center(
          child: Text(
            "Calulator",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontFamily: "Lobster",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: NetworkImage(
        //           "https://i.pinimg.com/originals/af/8d/63/af8d63a477078732b79ff9d9fc60873f.jpg",
        //         ),
        //         fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 20, left: 10),
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 80,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calbtn("AC", Colors.grey, Colors.black),
                  calbtn("+/-", Colors.grey, Colors.black),
                  calbtn("%", Colors.grey, Colors.black),
                  calbtn("/", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calbtn("7", Colors.grey[850], Colors.white),
                  calbtn("8", Colors.grey[850], Colors.white),
                  calbtn("9", Colors.grey[850], Colors.white),
                  calbtn("x", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calbtn("4", Colors.grey[850], Colors.white),
                  calbtn("5", Colors.grey[850], Colors.white),
                  calbtn("6", Colors.grey[850], Colors.white),
                  calbtn("-", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calbtn("1", Colors.grey[850], Colors.white),
                  calbtn("2", Colors.grey[850], Colors.white),
                  calbtn("3", Colors.grey[850], Colors.white),
                  calbtn("+", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 34, right: 120),
                    onPressed: () {
                      calculation(btntxt)
                    },
                    shape: StadiumBorder(),
                    child: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.grey[850],
                  ),
                  calbtn(".", Colors.grey[850], Colors.white),
                  calbtn("=", Colors.amber[700], Colors.white),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {
    if (btnText == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
