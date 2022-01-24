import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/constants.dart';
import 'package:flutter_flash_chat/screens/chat_screen.dart';
import 'package:flutter_flash_chat/widgets/screen_buttons.dart';

class RegistrationScreen extends StatefulWidget {
  static const name = '/register';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final auth = FirebaseAuth.instance;
  var email = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: kHeroLogo,
              transitionOnUserGestures: true,
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 24.0,
            ),
            RegisterButton(
              onPressed: () async {
                try {
                  final UserCredential? user =
                      await auth.createUserWithEmailAndPassword(
                          email: email, password: password);

                  if (user != null) {
                    Navigator.pushNamed(context, ChatScreen.name);
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
