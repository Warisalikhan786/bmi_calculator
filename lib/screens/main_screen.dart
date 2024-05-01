// ignore_for_file: constant_identifier_names, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

enum BMIStatus {
  Underweight,
  NormalWeight,
  Overweight,
  Obesity,
}

class BMIResult {
  final double bmi;
  final BMIStatus status;
  BMIResult(this.bmi, this.status);
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController heightFeetController = TextEditingController();
  TextEditingController heightInchesController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  var result = '';
  var status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            result != ''
                ? Text(
                    result,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: status == BMIStatus.Underweight
                          ? Colors.lightGreen
                          : status == BMIStatus.NormalWeight
                              ? Colors.green
                              : status == BMIStatus.Overweight
                                  ? Colors.redAccent.shade100
                                  : Colors.red,
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 50.0),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: heightFeetController,
                    decoration: InputDecoration(
                      labelText: "Height (Feet)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: TextFormField(
                    controller: heightInchesController,
                    decoration: InputDecoration(
                      labelText: "Height (Inches)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: weightController,
              decoration: InputDecoration(
                labelText: "Weight",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                double heightFeet =
                    double.parse(heightFeetController.text.trim());
                double heightInches =
                    double.parse(heightInchesController.text.trim());
                double weight = double.parse(weightController.text.trim());

                // Convert height from feet and inches to inches
                double height = (heightFeet * 12) + heightInches;

                final bmi = calculateBMI(weight, height);
                status = calculateBMIStatus(bmi);

                result = 'BMI: ${bmi.toStringAsFixed(2)},\n$status';
                print(status);
                setState(() {});
              },
              child: const Text("Calculate"),
            )
          ],
        ),
      ),
    );
  }

  double calculateBMI(double weight, double heightInInches) {
    // Convert height from inches to meters
    double heightInMeters = heightInInches * 0.0254; // 1 inch = 0.0254 meters

    // Calculate BMI
    double bmi = weight / (heightInMeters * heightInMeters);

    return bmi;
  }

  BMIStatus calculateBMIStatus(double bmi) {
    if (bmi < 18.5) {
      return BMIStatus.Underweight;
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return BMIStatus.NormalWeight;
    } else if (bmi >= 25 && bmi < 29.9) {
      return BMIStatus.Overweight;
    } else {
      return BMIStatus.Obesity;
    }
  }
}
