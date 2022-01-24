import 'package:flutter/material.dart';

class ScreenButton extends StatelessWidget {
  final String text;
  final Color color;
  final void Function() onPressed;

  const ScreenButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(text),
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final void Function() onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenButton(
      color: Colors.lightBlueAccent,
      text: 'Log In',
      onPressed: onPressed,
    );
  }
}

class RegisterButton extends StatelessWidget {
  final void Function() onPressed;
  const RegisterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenButton(
      color: Colors.blueAccent,
      text: 'Register',
      onPressed: onPressed,
    );
  }
}
