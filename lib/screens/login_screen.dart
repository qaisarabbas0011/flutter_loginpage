import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'forget_passwordscreen.dart';
import '../controllers/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginScreenController(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF111312), Color(0xFF0C0C0C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer<LoginScreenController>(
                  builder: (context, controller, child) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('images/insta2.png'),
                      ),
                      SizedBox(height: 30),
                      _buildTextField(
                        context: context,
                        label: 'Username',
                        controller: controller.usernameController,
                        isPassword: false,
                        hintText: 'Only letters, numbers, and _ are allowed',
                        icon: Icons.person,
                      ),
                      if (!controller.isUsernameValid &&
                          controller.hasStartedTypingUsername)
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            controller.usernameErrorMessage,
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 12),
                          ),
                        ),
                      SizedBox(height: 20),
                      _buildTextField(
                        context: context,
                        label: 'Password',
                        controller: controller.passwordController,
                        isPassword: true,
                        hintText:
                            'At least 6 characters with letters or symbols',
                        icon: Icons.lock,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: Text('Forgot Password?',
                              style: TextStyle(color: Colors.white70)),
                        ),
                      ),
                      SizedBox(height: 10),
                      AnimatedOpacity(
                        opacity: controller.isButtonEnabled ? 1.0 : 0.5,
                        duration: Duration(milliseconds: 300),
                        child: ElevatedButton(
                          onPressed: controller.isButtonEnabled
                              ? () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HomeScreen()));
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.teal,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text('Login',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text("Don't have an account? Sign Up",
                            style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required bool isPassword,
    required String hintText,
    required IconData icon,
  }) {
    final provider = Provider.of<LoginScreenController>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !provider.isPasswordVisible : false,
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
                    provider.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.teal,
                  ),
                  onPressed: () => provider.togglePasswordVisibility(),
                )
              : null,
        ),
      ),
    );
  }
}
