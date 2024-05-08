import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_api/homescreen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            SizedBox(height: 10,),
            _inputField("Username", _usernameController, false),
            SizedBox(height: 10,),
            _inputField("Password", _passwordController, true),
            SizedBox(height: 10,),
            ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == 'user' && password == 'password') {
      // await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
    }
  }
}

Widget _inputField(
    String label, TextEditingController inputController, bool isPassword) {
  return TextFormField(
    controller: inputController,
    obscureText: isPassword,
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
  );
}

Widget _button(VoidCallback action) {
  return ElevatedButton(onPressed: action, child: Text("Login"));
}
