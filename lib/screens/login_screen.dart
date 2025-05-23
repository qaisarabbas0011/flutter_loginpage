import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_screen_controller.dart';
import 'signup_screen.dart';
import 'forget_passwordscreen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/insta2.png'),
                ),
                SizedBox(height: 30),

                Obx(() => _buildTextField(
                      label: 'Email',
                      controller: controller.usernameController,
                      isPassword: false,
                      hintText: 'Enter your email',
                      icon: Icons.email,
                      errorText: controller.isUsernameValid.value
                          ? null
                          : controller.usernameErrorMessage.value,
                    )),

                SizedBox(height: 20),

                Obx(() => _buildTextField(
                      label: 'Password',
                      controller: controller.passwordController,
                      isPassword: true,
                      hintText: 'Enter your password',
                      icon: Icons.lock,
                      obscureText: !controller.isPasswordVisible.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.teal,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    )),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.to(() => ForgotPasswordScreen()),
                    child: Text('Forgot Password?',
                        style: TextStyle(color: Colors.white70)),
                  ),
                ),

                SizedBox(height: 10),

                Obx(() => AnimatedOpacity(
                      opacity: controller.isButtonEnabled.value ? 1.0 : 0.5,
                      duration: Duration(milliseconds: 300),
                      child: ElevatedButton(
                        onPressed: controller.isButtonEnabled.value
                            ? controller.loginWithFirebase
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.teal,
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text('Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    )),

                SizedBox(height: 20),

                TextButton(
                  onPressed: () => Get.to(() => SignUpScreen()),
                  child: Text("Don't have an account? Sign Up",
                      style: TextStyle(color: Colors.white70)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isPassword,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    String? errorText,
  }) {
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
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Icon(icon, color: Colors.teal),
          labelText: label,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          errorText: errorText,
        ),
      ),
    );
  }
}
