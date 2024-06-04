import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tictactoe_flutter_multiplayer_game/responsive/responsive.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/otp_check_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/utils/utils.dart';
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

  Future<void> sendOtp(String phoneNumber) async {
    final url = Uri.parse('http://192.168.173.253:3000/auth/login');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      log(response.body);
      log('OTP sent successfully');
      // ignore: use_build_context_synchronously
      showSnackBar(context, "OTP sent!");
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, "Invalid Phone Number!");
      throw Exception('Failed to send OTP');
    }

    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, OTPCheck.routeName,
        arguments: {'phoneNumber': _phoneNoController.text});
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
              onTap: () => sendOtp(_phoneNoController.text),
              text: 'Send OTP',
            ),
          ],
        ),
      ),
    );
  }
}
