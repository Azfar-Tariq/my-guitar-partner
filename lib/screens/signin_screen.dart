import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_guitar_partner/utils/constant.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // email controller
  final _emailController = TextEditingController();

  // password controller
  final _passwordController = TextEditingController();

  // show/hide password
  bool _obscurePassword = true;

  // loading
  bool _isLoading = false;

  // functions
  // signin
  Future<String?> loadUser({
    required final String email,
    required final String password,
  }) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    return user?.id;
  }

  Future<void> signIn() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      try {
        setState(() {
          _isLoading = true;
        });

        dynamic signInValue = await loadUser(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (mounted) {
          if (signInValue != null) {
            Navigator.pushReplacementNamed(
              context,
              '/home',
            );
          }
        }
      } catch (error) {
        Fluttertoast.showToast(
          msg: 'Invalid Credentials',
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
        msg: 'Please enter both email and password',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }
  }

  // github
  Future signInWithGitHub({required BuildContext context}) async {
    try {
      final response = await client.auth.signInWithOAuth(
        Provider.github,
      );
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  Future loginWithGitHub({
    required BuildContext context,
  }) async {
    try {
      await signInWithGitHub(context: context);
    } catch (error) {
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                    height: 50,
                  ),

                  const Text(
                    "Hello Again!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text(
                    "Welcome Back, you've been missed",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // email text field
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                        contentPadding: EdgeInsets.all(12.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),
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
                      textInputAction: TextInputAction.done,
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
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
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/forgot',
                            );
                          },
                          child: Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Colors.deepPurple[400],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // sign in button
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
                              await signIn();
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
                                  'Sign In',
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        SocialLoginButton(
                          buttonType: SocialLoginButtonType.google,
                          onPressed: () {},
                        ),
                        SocialLoginButton(
                          buttonType: SocialLoginButtonType.facebook,
                          onPressed: () {},
                        ),
                        SocialLoginButton(
                          buttonType: SocialLoginButtonType.twitter,
                          onPressed: () {},
                        ),
                        SocialLoginButton(
                          buttonType: SocialLoginButtonType.github,
                          onPressed: () {
                            loginWithGitHub(context: context);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          ' Register Now',
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
