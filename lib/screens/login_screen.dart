import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final errorMessage = useState<String?>(null);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'), // Updated to use AssetImage
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage(
                  'assets/images/logo.png', // Updated to use AssetImage
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Sign in to continue',
                style: TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'NAME',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'PASSWORD',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              if (errorMessage.value != null) ...[
                Text(
                  errorMessage.value!,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                const SizedBox(height: 8),
              ],
              TextButton(
                onPressed: () => context.go('/forgot-password'),
                child: const Text('Forgot Password?'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text == '7410' && passwordController.text == '7410') {
                    ref.read(authStateProvider.notifier).login(nameController.text);
                    context.go('/dashboard');
                  } else {
                    errorMessage.value = 'Incorrect username or password';
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Log in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
