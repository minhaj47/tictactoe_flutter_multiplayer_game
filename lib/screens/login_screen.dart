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
import 'package:tictactoe_flutter_multiplayer_game/constant.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = 'login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAPICallProcess = false;

  final TextEditingController _phoneNoController = TextEditingController();

  void sendOtp(String phoneNumber) async {
    log('inside sendOTP');
    final url = Uri.parse('${Constant.subscriptionApiURL}/otp/request');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "appId": Constant.appID,
        "password": Constant.password,
        "mobile": phoneNumber
      }),
    );

    // {
    //          statusCode: response.data.statusCode,
    //         statusDetail: response.data.statusDetail,
    //         referenceNo: response.data.referenceNo,
    //         version: response.data.version,
    // }

    final data = jsonDecode(response.body);
    String message = '';

    if (response.statusCode == 200) {
      if (data['statusCode'] == 'S1000') {
        message = 'OTP sent successfully';
        Navigator.pushNamed(
          // ignore: use_build_context_synchronously
          context,
          OTPCheck.routeName,
          arguments: {'referenceNo': data['referenceNo']},
        );
      } else {
        // ignore: use_build_context_synchronously
        message = "${data['statusCode']} ${data['statusDetail']}";
      }
    } else {
      // ignore: use_build_context_synchronously
      message = response.statusCode.toString() + response.body.toString();
      throw Exception(message);
    }
    log(message);
    // ignore: use_build_context_synchronously
    showSnackBar(context, message);
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
