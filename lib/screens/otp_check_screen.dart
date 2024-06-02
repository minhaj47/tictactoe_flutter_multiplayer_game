import 'package:flutter/material.dart';
import 'package:tictactoe_flutter_multiplayer_game/responsive/responsive.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/main_menu_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_button.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_text.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_text_field.dart';

class OTPCheck extends StatefulWidget {
  static String routeName = 'otp-check';
  const OTPCheck({super.key});

  @override
  State<OTPCheck> createState() => _OTPCheckState();
}

class _OTPCheckState extends State<OTPCheck> {
  final TextEditingController _otpController = TextEditingController();

  void otpVerify(BuildContext context) {
    Navigator.pushNamed(context, MainMenuScreen.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    _otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.08),
              const CustomText(
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  )
                ],
                text: 'Enter the OTP',
                fontSize: 26,
              ),
              SizedBox(height: size.height * 0.04),
              CustomTextField(
                controller: _otpController,
                hintText: 'Enter OTP',
              ),
              SizedBox(height: size.height * 0.02),
              CustomButton(
                onTap: () => otpVerify(context),
                text: 'VERIFY',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
