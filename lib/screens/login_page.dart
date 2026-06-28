import 'package:flutter/material.dart';
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
        title: const Text('Login'),
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
                    await auth.login(
                      emailController
                          .text
                          .trim(),
                      passwordController
                          .text
                          .trim(),
                    );

                    if (mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const TaskPage(),
                        ),
                      );
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
                child:
                    const Text(
                  'Login',
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const RegisterPage(),
                  ),
                );
              },
              child:
                  const Text(
                'Create Account',
              ),
            ),
          ],
        ),
      ),
    );
  }
}