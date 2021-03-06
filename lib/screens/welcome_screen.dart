import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/constants.dart';
import 'package:flutter_flash_chat/screens/login_screen.dart';
import 'package:flutter_flash_chat/screens/registration_screen.dart';
import 'package:flutter_flash_chat/widgets/screen_buttons.dart';

class WelcomeScreen extends StatefulWidget {
  static const name = '/';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, widget) {
        return Scaffold(
          backgroundColor: animation.value,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Hero(
                      tag: kHeroLogo,
                      transitionOnUserGestures: true,
                      child: SizedBox(
                        child: Image.asset('images/logo.png'),
                        height: 60.0,
                      ),
                    ),
                    AnimatedTextKit(
                      totalRepeatCount: 4,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Flash Chat',
                          textStyle:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                          speed: const Duration(milliseconds: 200),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48.0,
                ),
                LoginButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, LoginScreen.name),
                ),
                RegisterButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, RegistrationScreen.name),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
