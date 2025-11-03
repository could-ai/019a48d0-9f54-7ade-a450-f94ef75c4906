import "package:flutter/material.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Prothrombin Calculator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const ProthrombinCalculatorPage(),
    );
  }
}

class ProthrombinCalculatorPage extends StatefulWidget {
  const ProthrombinCalculatorPage({super.key});

  @override
  State<ProthrombinCalculatorPage> createState() =>
      _ProthrombinCalculatorPageState();
}

class _ProthrombinCalculatorPageState extends State<ProthrombinCalculatorPage> {
  final TextEditingController _controller = TextEditingController();
  String _resultText = "";

  void _calculate() {
    final String inputText = _controller.text;
    if (inputText.isEmpty) {
      setState(() {
        _resultText = "Please enter a value.";
      });
      return;
    }

    final double? ptValue = double.tryParse(inputText);

    if (ptValue == null || ptValue == 0) {
      setState(() {
        _resultText = "Invalid input. Please enter a valid number.";
      });
      return;
    }

    // Calculations based on user's request
    final double ratio = ptValue / 12.0;
    final double index = (12.0 / ptValue) * 100;
    // The user's formula is inr = (ratio) ^ 1.
    // In many languages, ^ is exponentiation, so ratio to the power of 1 is just ratio.
    final double inr = ratio;

    // Formatting the results to 2 decimal places for better readability
    final String ratioStr = ratio.toStringAsFixed(2);
    final String indexStr = index.toStringAsFixed(2);
    final String inrStr = inr.toStringAsFixed(2);

    setState(() {
      _resultText = "Prothrombin Ratio: $ratioStr\n"
          "Prothrombin Index: $indexStr%\n"
          "INR: $inrStr";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prothrombin Calculator"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                controller: _controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Enter Prothrombin Time (PT)",
                  hintText: "e.g., 13.5",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculate,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text("Calculate"),
              ),
              const SizedBox(height: 30),
              const Text(
                "Results:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  _resultText,
                  style: const TextStyle(fontSize: 18, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
