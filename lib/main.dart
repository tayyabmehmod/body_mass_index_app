import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyHomeState();
}

class MyHomeState extends State<MyHomePage> {
  var wtcontroller = TextEditingController();
  var ftcontroller = TextEditingController();
  var inchcontroller = TextEditingController();
  var result = "";
  Gradient? bgGradient; // ✅ store gradient instead of solid color
  var msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text('Your BMI')),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: bgGradient ??
              LinearGradient(
                colors: [Colors.white, Colors.white], // default white
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  "Enter your data",
                  style: TextStyle(
                      color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 30),

            // Weight
            SizedBox(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: wtcontroller,
                decoration: InputDecoration(
                  label: Text("Weight (kg)"),
                  prefixIcon: Icon(Icons.line_weight),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Height Feet
            SizedBox(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: ftcontroller,
                decoration: InputDecoration(
                  label: Text("Height (Feet)"),
                  prefixIcon: Icon(Icons.height),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 1.5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Height Inches
            SizedBox(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: inchcontroller,
                decoration: InputDecoration(
                  label: Text("Height (Inches)"),
                  prefixIcon: Icon(Icons.height),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    wtcontroller.clear();
                    ftcontroller.clear();
                    inchcontroller.clear();
                    setState(() {
                      result = "";
                      bgGradient = LinearGradient(
                        colors: [Colors.white, Colors.white],
                      );
                    });
                  },
                  child: Text("Reset"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () {
                      var weight = wtcontroller.text.toString();
                      var ft = ftcontroller.text.toString();
                      var inch = inchcontroller.text.toString();

                      if (weight.isNotEmpty &&
                          ft.isNotEmpty &&
                          inch.isNotEmpty) {
                        var iwt = int.parse(weight);
                        var ift = int.parse(ft);
                        var iinch = int.parse(inch);

                        var tinch = (ift * 12) + iinch;
                        var tcm = tinch * 2.54;
                        var tm = tcm / 100;

                        var bmi = iwt / (tm * tm);

                        if (bmi >= 30) {
                          msg = "You are Obese";
                          bgGradient = LinearGradient(
                            colors: [Colors.red.shade900, Colors.red.shade400],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          );
                        } else if (bmi >= 25) {
                          msg = "You are Overweight";
                          bgGradient = LinearGradient(
                            colors: [Colors.orange.shade700, Colors.deepOrange.shade300],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          );
                        } else if (bmi >= 18.5) {
                          msg = "You are Healthy";
                          bgGradient = LinearGradient(
                            colors: [Colors.green.shade400, Colors.green.shade200],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          );
                        } else {
                          msg = "You are Underweight";
                          bgGradient = LinearGradient(
                            colors: [Colors.blue.shade400, Colors.blue.shade200],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          );
                        }

                        setState(() {
                          result = "$msg \n Your BMI is : ${bmi.toStringAsFixed(2)}";
                        });
                      } else {
                        setState(() {
                          result = "⚠ Please fill all the blanks";
                        });
                      }
                    },
                    child: Text("Calculate")),
              ],
            ),
            SizedBox(height: 15),

            Text(
              result,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
                letterSpacing: 1.2,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.black26,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
