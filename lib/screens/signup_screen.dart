import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isButtonEnabled = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isUsernameValid = true;
  bool _isPasswordValid = true;
  bool _doPasswordsMatch = true;
  bool _hasStartedTypingUsername = false;
  String _usernameErrorMessage = '';

  final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
  final RegExp _passwordRegex = RegExp(r'^[a-zA-Z0-9!@#\$&*~]+$');

  void _checkFields() {
    setState(() {
      if (_hasStartedTypingUsername) {
        if (_usernameController.text.isEmpty ||
            _usernameRegex.hasMatch(_usernameController.text)) {
          _isUsernameValid = true;
          _usernameErrorMessage = '';
        } else {
          _isUsernameValid = false;
          _usernameErrorMessage = ' Special characters are not allowed!';
        }
      }

      _isPasswordValid = _passwordController.text.length >= 6 &&
          _passwordRegex.hasMatch(_passwordController.text);

      _doPasswordsMatch =
          _passwordController.text == _confirmPasswordController.text;

      _isButtonEnabled =
          _isUsernameValid && _isPasswordValid && _doPasswordsMatch;
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
    _confirmPasswordController.addListener(_checkFields);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 17, 19, 18),
              const Color.fromARGB(255, 12, 12, 12)
            ],
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
                    backgroundImage: AssetImage('images/insta2.png'),
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
                    isConfirmField: false,
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    'Confirm Password',
                    _confirmPasswordController,
                    true,
                    'Re-enter password',
                    Icons.lock_outline,
                    isConfirmField: true,
                  ),
                  if (!_doPasswordsMatch && _confirmPasswordController.text.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        ' Passwords do not match!',
                        style: TextStyle(color: Colors.redAccent, fontSize: 12),
                      ),
                    ),
                  SizedBox(height: 30),
                  AnimatedOpacity(
                    opacity: _isButtonEnabled ? 1.0 : 0.5,
                    duration: Duration(milliseconds: 300),
                    child: ElevatedButton(
                      onPressed: _isButtonEnabled
                          ? () {
                              // Sign up logic or redirect here
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Account created!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                        elevation: 5,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Colors.white70),
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
      bool isPassword, String hintText, IconData icon,
      {bool isConfirmField = false}) {
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
        obscureText: isPassword
            ? isConfirmField
                ? !_isConfirmPasswordVisible
                : !_isPasswordVisible
            : false,
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
                    isConfirmField
                        ? (_isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off)
                        : (_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                    color: Colors.teal,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isConfirmField) {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      } else {
                        _isPasswordVisible = !_isPasswordVisible;
                      }
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
