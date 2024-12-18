import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Assesstment',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String name = '';
  String email = '';
  String _result = '';
  // Initial red color for errors
  Color _resultColor = Colors.red;

  // Create a list of the contact methods and make the email one the default
  final List<String> methods = ["Email", "Phone", "SMS"];
  String selectedMethod = "Email";

  // Update name according to the name input value
  void updateName(String value) {
    setState(() {
      name = value;
    });
  }

  // Update name according to the name input value
  void updateEmail(String value) {
    setState(() {
      email = value;
    });
  }

  // Default selected gender value (nullable)
  String? _gender;

  // Default checkbox value
  bool _isChecked = false;

  void updateMethod(String method) {
    setState(() {
      selectedMethod = method;
    });
  }

  // Method to update selectedMethod
  void submitForm() {
    setState(() {
      // RegExp for email validation i got from google
      final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );

      if (name.isEmpty || email.isEmpty || _gender == null) {
        _result = 'Please fill out all fields';
      } else if (!emailRegex.hasMatch(email)) {
        _result = 'Please enter a valid email address';
      } else {
        // Black color if everything is filled correctly
        _resultColor = Colors.black;
        String isSubscribed = _isChecked ? "Yes" : "No";
        _result =
            'Submitted Information:\nName: $name\nEmail: $email\nGender: $_gender\nPreferred Contact Method: $selectedMethod\nSubscribed to Newsletter: $isSubscribed';
      }
    });
  }

  // Method to clear form
  void clearForm() {
    setState(() {
      name = '';
      email = '';
      _gender = null;
      selectedMethod = "Email";
      _isChecked = false;
      _result = '';
      _resultColor = Colors.red;
      _controllerName.clear(); 
      _controllerEmail.clear();
    });
  }

  void updateGender(String gender) {
    setState(() {
      _gender = gender;
    });
  }

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  // boolean to see the visibility of the output
  bool _showOutput = false;

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerEmail.dispose();
    super.dispose();
  }

  void showOutput() {
    setState(() {
      _showOutput = !_showOutput; // Toggle visibility
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Make the title bold, white and centered as seen in the example
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "A Simple Contact Form",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 131, 214),
      ),
      body: Padding(
        // Add 20 pixels of margin to the left
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          // Align all items to the top left position
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use SizedBox classes to add spacing between elements
            const SizedBox(height: 20),
            const Text("Name"),
            const SizedBox(height: 10),
            SizedBox(
              // Make the width of the elements max size :D
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: _controllerName,
                onChanged: updateName,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter your name'),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Email"),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                onChanged: updateEmail,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter your email'),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Gender', style: TextStyle(fontSize: 18.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  value: "Male",
                  groupValue: _gender,
                  onChanged: (val) {
                    setState(() {
                      _gender = val as String;
                    });
                  },
                ),
                const Text('Male', style: TextStyle(fontSize: 18.0)),
                Radio(
                  value: "Female",
                  groupValue: _gender,
                  onChanged: (val) {
                    setState(() {
                      _gender = val as String;
                    });
                  },
                ),
                const Text('Female', style: TextStyle(fontSize: 18.0)),
                Radio(
                  value: "Other",
                  groupValue: _gender,
                  onChanged: (val) {
                    setState(() {
                      _gender = val as String;
                    });
                  },
                ),
                const Text('Others', style: TextStyle(fontSize: 18.0)),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Preferred Contact Method",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            DropDown(
              methods: methods,
              selectedMethod: selectedMethod,
              updateMethod: updateMethod,
            ),
            const SizedBox(height: 20),
            Row(children: [
              Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ?? false;
                  });
                },
              ),
              const Text("Subscribe to newsletter"),
            ]),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 150.0),
                ElevatedButton(
                  onPressed: submitForm,
                  child: const Row(
                    children: [
                      // Add the check icon next to the submit text
                      Icon(Icons.check),
                      // Add spacing between icon and text
                      SizedBox(width: 4.0),
                      Text("Submit"),
                    ],
                  ),
                ),
                // Dynamic spacing between both buttons
                Expanded(child: Container()),
                ElevatedButton(
                  onPressed: clearForm,
                  child: const Row(
                    children: [
                      // Add the x icon next to the clear text
                      Icon(Icons.close),
                      // Add spacing between icon and text
                      SizedBox(width: 4.0),
                      Text("Clear"),
                    ],
                  ),
                ),
                const SizedBox(width: 150.0),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(_result,
              textAlign: TextAlign.center, 
              style: TextStyle(
                fontSize: 24,
                color: _resultColor,
              )),
            )
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  final List<String> methods;
  final String selectedMethod;
  final ValueChanged<String> updateMethod;

  const DropDown({
    super.key,
    required this.methods,
    required this.selectedMethod,
    required this.updateMethod,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: MediaQuery.of(context).size.width * 0.9,
      initialSelection: widget.selectedMethod,
      onSelected: (method) {
        setState(() {
          widget.updateMethod(method as String);
        });
      },
      dropdownMenuEntries:
          widget.methods.map<DropdownMenuEntry<String>>((String method) {
        return DropdownMenuEntry(value: method, label: method);
      }).toList(),
    );
  }
}
