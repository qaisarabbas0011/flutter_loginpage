import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isPasswordVisible = false;
  bool _isUsernameValid = true;
  bool _isPasswordValid = true;
  String _usernameErrorMessage = '';
  bool _hasStartedTypingUsername = false;

  final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
  final RegExp _passwordRegex = RegExp(r'^[a-zA-Z0-9!@#\$&*~]+$');

  void _checkFields() {
    setState(() {
      if (_hasStartedTypingUsername) {
        if (_usernameController.text.isEmpty || _usernameRegex.hasMatch(_usernameController.text)) {
          _isUsernameValid = true;
          _usernameErrorMessage = '';
        } else {
          _isUsernameValid = false;
          _usernameErrorMessage = ' Special characters are not allowed!';
        }
      }

      _isPasswordValid = _passwordController.text.length >= 6 &&
          _passwordRegex.hasMatch(_passwordController.text);

      _isButtonEnabled = _isUsernameValid && _isPasswordValid;
    });
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      if (!_hasStartedTypingUsername && _usernameController.text.isNotEmpty) {
        _hasStartedTypingUsername = true;
      }
      _checkFields();
    });
    _passwordController.addListener(_checkFields);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.indigo.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/pics.jpg'),
                  ),
                  SizedBox(height: 30),
                  _buildTextField(
                    'Username',
                    _usernameController,
                    false,
                    'Only letters, numbers, and _ are allowed',
                    Icons.person,
                  ),
                  if (!_isUsernameValid && _hasStartedTypingUsername)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        _usernameErrorMessage,
                        style: TextStyle(color: Colors.redAccent, fontSize: 12),
                      ),
                    ),
                  SizedBox(height: 20),
                  _buildTextField(
                    'Password',
                    _passwordController,
                    true,
                    'At least 6 characters with letters, numbers, or special characters',
                    Icons.lock,
                  ),
                  SizedBox(height: 30),
                  AnimatedOpacity(
                    opacity: _isButtonEnabled ? 1.0 : 0.5,
                    duration: Duration(milliseconds: 300),
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                        elevation: 5,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      bool isPassword, String hintText, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !_isPasswordVisible : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Icon(icon, color: Colors.teal),
          labelText: label,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.teal,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
