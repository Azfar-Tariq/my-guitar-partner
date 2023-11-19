import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_guitar_partner/utils/constant.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // email controller
  final _emailController = TextEditingController();

  // password controller
  final _passwordController = TextEditingController();
  String _passwordValidationMessage = 'Minimum length: 8';

  // confirm password controller
  final _confirmPasswordController = TextEditingController();
  String _passwordMatchValidationMessage = 'Password do not match';

  // hide/show password
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // loading
  bool _isLoading = false;

  // functions
  Future<bool> createUser({
    required final String email,
    required final String password,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
      );
      if (response.user != null && response.session != null) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<void> signUp() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        try {
          setState(() {
            _isLoading = true;
          });
          final userValue = await createUser(
            email: _emailController.text,
            password: _passwordController.text,
          );
          if (mounted) {
            if (userValue) {
              Navigator.pushReplacementNamed(
                context,
                '/home',
              );
            } else {
              Fluttertoast.showToast(
                msg: 'Something went wrong',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 12.0,
              );
            }
          }
        } catch (error) {
          Fluttertoast.showToast(
            msg: error.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 12.0,
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Password does not match',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Please enter all the details',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Instagram Profile Image.png',
                    height: 100,
                    width: 100,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  const Text(
                    "Hello There!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // email text field
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'Email',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // password field
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      onChanged: (password) {
                        setState(() {
                          _passwordValidationMessage = password.length >= 8
                              ? 'Valid Password'
                              : 'Minimum length: 8';
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepPurple[400],
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        helperText: _passwordValidationMessage,
                        helperStyle: TextStyle(
                          color: _passwordValidationMessage.contains('Valid')
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // confirm password field
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      obscureText: _obscureConfirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _confirmPasswordController,
                      onChanged: (confirmPassword) {
                        setState(() {
                          _passwordMatchValidationMessage =
                              confirmPassword == _passwordController.text
                                  ? 'Password Matched'
                                  : 'Password do not match';
                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outline,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        labelText: 'Confirm Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          child: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepPurple[400],
                          ),
                        ),
                        contentPadding: const EdgeInsets.all(12.0),
                        helperText: _passwordMatchValidationMessage,
                        helperStyle: TextStyle(
                          color: _passwordMatchValidationMessage
                                  .contains('Matched')
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // sign up button
                  _isLoading
                      ? Container(
                          height: 30,
                          width: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              await signUp();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(
                                20.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: const Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                  const SizedBox(
                    height: 25,
                  ),

                  // sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a member',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signin');
                        },
                        child: Text(
                          ' Login Now',
                          style: TextStyle(
                            color: Colors.deepPurple[400],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
