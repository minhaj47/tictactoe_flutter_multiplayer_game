import 'package:flutter/material.dart';
import 'package:tictactoe_flutter_multiplayer_game/responsive/responsive.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/otp_check_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_button.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_text.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNo = '';
  bool isAPICallProcess = false;

  final TextEditingController _phoneNoController = TextEditingController();

  void sendOTP(BuildContext context) {
    Navigator.pushNamed(context, OTPCheck.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: loginUI(size),
        // ProgressHUD(
        //   key: UniqueKey(),
        //   child: loginUI(size),
        //   inAsyncCall: isAPICallProcess,
        //   opacity: .3,
        // ),
      ),
    );
  }

  loginUI(Size size) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(10),
      child: Responsive(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.08),
            const CustomText(
              shadows: [
                Shadow(
                  blurRadius: 40,
                  color: Colors.blue,
                )
              ],
              text: 'TicTacToe',
              fontSize: 50,
            ),
            SizedBox(height: size.height * 0.09),
            const CustomText(
              shadows: [
                Shadow(
                  blurRadius: 40,
                  color: Colors.blue,
                )
              ],
              text: 'Login With a Mobile Number.',
              fontSize: 16,
            ),
            SizedBox(height: size.height * 0.01),
            const CustomText(
              shadows: [
                Shadow(
                  blurRadius: 40,
                  color: Colors.blue,
                )
              ],
              text: 'We will send you a OTP to verify.',
              fontSize: 11,
            ),
            SizedBox(height: size.height * 0.04),
            CustomTextField(
              controller: _phoneNoController,
              hintText: 'Enter your Phone Number',
            ),
            SizedBox(height: size.height * 0.02),
            CustomButton(
              onTap: () => sendOTP(context),
              text: 'Send OTP',
            ),
          ],
        ),
      ),
    );
  }
}
