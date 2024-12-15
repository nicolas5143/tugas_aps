import 'package:flutter/material.dart';
import 'package:tugas_aps/util.dart';

class HalamanLogin extends StatelessWidget {
  const HalamanLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Log In',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 33),
              const UserTextField(text: 'Email'),
              const SizedBox(height: 16),
              const UserTextField(text: 'Password'),
              const SizedBox(height: 54),
              ElevatedButton(
                onPressed: () => {
                  Navigator.pushNamed(context, '/navigator')
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF5DB075)),
                ),
                child: const Text('Submit', style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
