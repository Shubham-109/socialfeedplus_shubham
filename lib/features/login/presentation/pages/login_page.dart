import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../routes/app_router.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.feeds);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.redAccent, content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.purpleAccent));
          }

          return SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                height: size.height,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1F1C2C), Color.fromARGB(255, 0, 0, 0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Social',
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                      ),
                      const SizedBox(height: 10),
                      const Text('Connect. Share. Inspire.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 60),

                      TextField(
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline, color: Colors.white70),
                          labelText: 'Username',
                          labelStyle: const TextStyle(color: Colors.white70),

                          filled: true,
                          fillColor: Colors.white.withOpacity(0.08),
                        ),
                      ),
                      const SizedBox(height: 25),

                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.white70),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white70),

                          filled: true,
                          fillColor: Colors.white.withOpacity(0.08),
                        ),
                      ),

                      const SizedBox(height: 50),

                      GestureDetector(
                        onTap: () {
                          context.read<LoginBloc>().add(LoginButtonPressed(_usernameController.text.trim(), _passwordController.text.trim()));
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [BoxShadow(color: Colors.purpleAccent.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 0.8),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
