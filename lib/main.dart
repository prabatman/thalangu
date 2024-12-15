import 'package:flutter/material.dart';

void main() {
  runApp(const MridangamKeyboardApp());
}

class MridangamKeyboardApp extends StatelessWidget {
  const MridangamKeyboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const KeyboardScreen(),
    );
  }
}

class KeyboardScreen extends StatefulWidget {
  const KeyboardScreen({Key? key}) : super(key: key);

  @override
  _KeyboardScreenState createState() => _KeyboardScreenState();
}

class _KeyboardScreenState extends State<KeyboardScreen> {
  final TextEditingController _textController = TextEditingController();
  bool isSpecialCharacter = false;
  bool isQwerty = false;

  // Add text to the input field
  void _addText(String text) {
    setState(() {
      _textController.text += "$text ";
    });
  }

  // Move to the next line
  void _moveToNextLine() {
    setState(() {
      _textController.text += "\n";
    });
  }

  // Build buttons with dynamic sizes
  Widget _buildKeyButton(String text, BuildContext context,
      {bool isWide = false, IconData? icon, Color textColor = Colors.black}) {
    final double buttonWidth = isWide
        ? MediaQuery.of(context).size.width * 0.25
        : MediaQuery.of(context).size.width / 10;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizedBox(
        width: buttonWidth,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            if (icon != null && icon == Icons.arrow_back) {
              setState(() {
                _textController.text = _textController.text.isNotEmpty
                    ? _textController.text
                        .substring(0, _textController.text.length - 1)
                    : '';
              });
            } else if (text == "Enter") {
              _moveToNextLine();
            } else if (text == "QWERTY") {
              setState(() {
                isQwerty = true;
              });
            } else if (text == "Back to Mridangam") {
              setState(() {
                isQwerty = false;
              });
            } else {
              _addText(text);
            }
          },
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  // Build the Mridangam keyboard layout
  Widget _buildMridangamKeyboard(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(10, (index) {
            String label = index == 9 ? "0" : "${index + 1}";
            return _buildKeyButton(label, context);
          }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeyButton("(long pause)", context, isWide: true),
            _buildKeyButton("QWERTY", context, isWide: true),
            _buildKeyButton("Ta Ka Tha Ri Ki Ta Tha Ka", context, isWide: true),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeyButton("Tha", context, textColor: Colors.red),
            _buildKeyButton("Lan", context, textColor: Colors.red),
            _buildKeyButton("Gu", context, textColor: Colors.red),
            _buildKeyButton("Mi", context),
            _buildKeyButton("X", context),
            _buildKeyButton("Ki", context),
            _buildKeyButton("Ta", context),
            _buildKeyButton("Ka", context),
            _buildKeyButton("Dhi", context),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeyButton("", context, icon: Icons.arrow_upward),
            _buildKeyButton("Thom", context),
            _buildKeyButton("Dhin", context),
            _buildKeyButton("Ri", context),
            _buildKeyButton("Nu", context),
            _buildKeyButton("Tham", context),
            _buildKeyButton("Nam", context),
            _buildKeyButton("Na", context),
            _buildKeyButton("", context, icon: Icons.arrow_back),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeyButton("# !", context),
            _buildKeyButton(",", context),
            _buildKeyButton("Space", context, isWide: true),
            _buildKeyButton(".", context),
            _buildKeyButton("", context, icon: Icons.keyboard_return),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mridangam Keyboard'),
        backgroundColor: Colors.grey[300],
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                readOnly: true,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            isQwerty
                ? _buildMridangamKeyboard(context)
                : _buildMridangamKeyboard(context),
          ],
        ),
      ),
    );
  }
}
