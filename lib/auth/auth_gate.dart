/*
AUTH GATE -- This Will Continuously Listen For Auth State Change.
-----------------------------------------------------------------

Unauthenticated -> Login Page.
Authenticated -> Profile/ Home Page.
* */

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_learn/view/notes_page.dart';

import '../view/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        /*Listen to the auth State changes*/
        stream: Supabase.instance.client.auth.onAuthStateChange,

        /*Build Appropriate Pages Based On Auth State*/
        builder: (context, snapShot) {
          final session = snapShot.hasData ? snapShot.data!.session : null;
          /*Loading*/
          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (session != null) {
            return const NotePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
