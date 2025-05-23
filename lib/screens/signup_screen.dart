// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpScreen({super.key});

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
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('images/insta2.png'),
                ),
                SizedBox(height: 30),
                _buildTextField(
                  label: 'Username',
                  hint: 'Only letters, numbers, and _ are allowed',
                  icon: Icons.person,
                  controller: controller.usernameController,
                  isPassword: false,
                  onToggleVisibility: null,
                  isVisible: false,
                ),
                Obx(() => !controller.isUsernameValid.value &&
                        controller.hasStartedTypingUsername.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          controller.usernameErrorMessage.value,
                          style: TextStyle(color: Colors.redAccent, fontSize: 12),
                        ),
                      )
                    : SizedBox.shrink()),
                SizedBox(height: 20),

                // Email field
                _buildTextField(
                  label: 'Email',
                  hint: 'Enter a valid email address',
                  icon: Icons.email,
                  controller: controller.emailController,
                  isPassword: false,
                  onToggleVisibility: null,
                  isVisible: false,
                ),
                Obx(() => !controller.isEmailValid.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          controller.emailErrorMessage.value,
                          style: TextStyle(color: Colors.redAccent, fontSize: 12),
                        ),
                      )
                    : SizedBox.shrink()),
                SizedBox(height: 20),

                Obx(() => _buildTextField(
                      label: 'Password',
                      hint:
                          'At least 6 characters with letters, numbers, or special characters',
                      icon: Icons.lock,
                      controller: controller.passwordController,
                      isPassword: true,
                      onToggleVisibility: controller.togglePasswordVisibility,
                      isVisible: controller.isPasswordVisible.value,
                    )),
                SizedBox(height: 20),
                Obx(() => _buildTextField(
                      label: 'Confirm Password',
                      hint: 'Re-enter password',
                      icon: Icons.lock_outline,
                      controller: controller.confirmPasswordController,
                      isPassword: true,
                      onToggleVisibility: controller.toggleConfirmPasswordVisibility,
                      isVisible: controller.isConfirmPasswordVisible.value,
                    )),
                Obx(() => !controller.doPasswordsMatch.value &&
                        controller.confirmPasswordController.text.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'Passwords do not match!',
                          style: TextStyle(color: Colors.redAccent, fontSize: 12),
                        ),
                      )
                    : SizedBox.shrink()),
                SizedBox(height: 30),
                Obx(() => AnimatedOpacity(
                      opacity: controller.isButtonEnabled.value ? 1.0 : 0.5,
                      duration: Duration(milliseconds: 300),
                      child: ElevatedButton(
                        onPressed: controller.isButtonEnabled.value
                            ? () {
                                controller.signUp();
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
                    )),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () => Get.back(),
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
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required bool isPassword,
    required VoidCallback? onToggleVisibility,
    required bool isVisible,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !isVisible : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          prefixIcon: Icon(icon, color: Colors.teal),
          labelText: label,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.teal,
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}
