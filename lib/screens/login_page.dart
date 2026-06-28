import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import 'register_page.dart';
import 'task_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {
  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final auth = AuthService();

  Future login() async {
    try {
      await auth.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const TaskPage(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF6F1F6),

      body: Center(
        child:
            SingleChildScrollView(
          padding:
              const EdgeInsets.all(
            25,
          ),
          child: Container(
            width: 420,
            padding:
                const EdgeInsets.all(
              35,
            ),
            decoration:
                BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                30,
              ),
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
                    Icons.task_alt,
                    size: 50,
                    color:
                        Colors.white,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Text(
                  'My Task Manager',
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
                  height: 8,
                ),

                Text(
                  'Manage your daily tasks easily',
                  style:
                      GoogleFonts
                          .poppins(
                    color:
                        Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 35,
                ),

                TextField(
                  controller:
                      emailController,
                  decoration:
                      InputDecoration(
                    labelText:
                        'Email',
                    prefixIcon:
                        const Icon(
                      Icons.email,
                    ),
                    filled:
                        true,
                    fillColor:
                        Colors
                            .grey
                            .shade100,
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                      borderSide:
                          BorderSide
                              .none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

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
                    filled:
                        true,
                    fillColor:
                        Colors
                            .grey
                            .shade100,
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                      borderSide:
                          BorderSide
                              .none,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

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
                          20,
                        ),
                      ),
                    ),
                    onPressed:
                        login,
                    child: Text(
                      'Login',
                      style:
                          GoogleFonts.poppins(
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
                  height: 25,
                ),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style:
                          GoogleFonts.poppins(),
                    ),
                    TextButton(
                      onPressed:
                          () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    const RegisterPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Register',
                        style:
                            GoogleFonts.poppins(
                          color:
                              Colors
                                  .deepPurple,
                          fontWeight:
                              FontWeight.bold,
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
    );
  }
}