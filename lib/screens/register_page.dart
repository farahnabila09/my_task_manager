import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {
  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final auth = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future register() async {
    try {
      await auth.register(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Registration Successful',
            ),
          ),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content:
                Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(
      BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF6F1F6),

      body: Center(
        child:
            SingleChildScrollView(
          padding:
              const EdgeInsets.all(
                  25),
          child: Container(
            width: 420,
            padding:
                const EdgeInsets.all(
                    35),
            decoration:
                BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                      30),
              boxShadow: [
                BoxShadow(
                  color: Colors
                      .grey
                      .shade300,
                  blurRadius: 20,
                  offset:
                      const Offset(
                    0,
                    10,
                  ),
                ),
              ],
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor:
                      Colors
                          .deepPurple,
                  child: Icon(
                    Icons.person_add,
                    size: 50,
                    color:
                        Colors.white,
                  ),
                ),

                const SizedBox(
                    height: 20),

                Text(
                  'Create Account',
                  style:
                      GoogleFonts
                          .poppins(
                    fontSize: 28,
                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),

                const SizedBox(
                    height: 8),

                Text(
                  'Register to start managing your tasks',
                  textAlign:
                      TextAlign.center,
                  style:
                      GoogleFonts
                          .poppins(
                    color:
                        Colors.grey,
                  ),
                ),

                const SizedBox(
                    height: 35),

                TextField(
                  controller:
                      emailController,
                  keyboardType:
                      TextInputType
                          .emailAddress,
                  decoration:
                      InputDecoration(
                    labelText:
                        'Email',
                    prefixIcon:
                        const Icon(
                      Icons.email,
                    ),
                    filled: true,
                    fillColor:
                        Colors.grey
                            .shade100,
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                              20),
                      borderSide:
                          BorderSide
                              .none,
                    ),
                  ),
                ),

                const SizedBox(
                    height: 20),

                TextField(
                  controller:
                      passwordController,
                  obscureText:
                      true,
                  decoration:
                      InputDecoration(
                    labelText:
                        'Password',
                    prefixIcon:
                        const Icon(
                      Icons.lock,
                    ),
                    filled: true,
                    fillColor:
                        Colors.grey
                            .shade100,
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                              20),
                      borderSide:
                          BorderSide
                              .none,
                    ),
                  ),
                ),

                const SizedBox(
                    height: 30),

                SizedBox(
                  width:
                      double.infinity,
                  height: 55,
                  child:
                      ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors
                              .deepPurple,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                                20),
                      ),
                    ),
                    onPressed:
                        register,
                    child: Text(
                      'Register',
                      style:
                          GoogleFonts
                              .poppins(
                        color:
                            Colors
                                .white,
                        fontSize:
                            16,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                    height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context);
                  },
                  child: Text(
                    'Already have an account? Login',
                    style:
                        GoogleFonts
                            .poppins(
                      color:
                          Colors
                              .deepPurple,
                      fontWeight:
                          FontWeight
                              .w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}