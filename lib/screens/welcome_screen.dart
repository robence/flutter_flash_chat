import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/constants.dart';
import 'package:flutter_flash_chat/screens/login_screen.dart';
import 'package:flutter_flash_chat/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const name = '/';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  goToLogin() {
    Navigator.pushNamed(context, LoginScreen.name);
  }

  goToRegister() {
    Navigator.pushNamed(context, RegistrationScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Row(
                  children: [
                    Hero(
                      tag: heroLogo,
                      transitionOnUserGestures: true,
                      child: SizedBox(
                        child: Image.asset('images/logo.png'),
                        height: animation.value * 100,
                      ),
                    ),
                    Text(
                      'Flash Chat',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: goToLogin,
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: goToRegister,
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
