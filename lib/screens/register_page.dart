import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            TextField(
              controller:
                  emailController,
              decoration:
                  const InputDecoration(
                labelText: 'Email',
                border:
                    OutlineInputBorder(),
              ),
            ),
            const SizedBox(
                height: 20),
            TextField(
              controller:
                  passwordController,
              obscureText: true,
              decoration:
                  const InputDecoration(
                labelText:
                    'Password',
                border:
                    OutlineInputBorder(),
              ),
            ),
            const SizedBox(
                height: 20),
            SizedBox(
              width:
                  double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await auth
                        .register(
                      emailController
                          .text
                          .trim(),
                      passwordController
                          .text
                          .trim(),
                    );

                    if (mounted) {
                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Registration Successful',
                          ),
                        ),
                      );

                      Navigator.pop(
                          context);
                    }
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(
                        SnackBar(
                          content:
                              Text(
                            e.toString(),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'Register',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}