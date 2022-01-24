import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/constants.dart';
import 'package:flutter_flash_chat/widgets/screen_buttons.dart';

class LoginScreen extends StatefulWidget {
  static const name = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                  hintStyle: Theme.of(context).textTheme.bodyText1),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
                hintStyle: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            LoginButton(
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
