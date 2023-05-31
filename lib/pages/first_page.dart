import 'package:flutter/material.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mongodb_1/main.dart';

import 'facebook_page.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SignInButton(
            Buttons.Google,
            onPressed: () {},
          ),
          // with custom text
          SignInButton(
            Buttons.Google,
            text: "Sign up with Google",
            onPressed: () {},
          ),
          SignInButton(
            Buttons.Facebook,
            mini: false,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              );
            },
          ),
          // For self-build buttons.
          SignInButtonBuilder(
            text: 'Sign in with Email',
            icon: Icons.email,
            onPressed: () {},
            backgroundColor: Colors.blueGrey[700]!,
          ),
          // For mini buttons.
          SignInButton(
            Buttons.Facebook,
            mini: true,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
