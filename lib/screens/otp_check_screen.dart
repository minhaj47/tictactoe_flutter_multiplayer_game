// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tictactoe_flutter_multiplayer_game/responsive/responsive.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/main_menu_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/utils/utils.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_button.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_text.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_text_field.dart';
import 'package:tictactoe_flutter_multiplayer_game/constant.dart';

class OTPCheck extends StatefulWidget {
  static String routeName = 'otp-check';
  const OTPCheck({super.key});

  @override
  State<OTPCheck> createState() => _OTPCheckState();
}

class _OTPCheckState extends State<OTPCheck> {
  final TextEditingController _otpController = TextEditingController();

  void otpVerify(BuildContext context, String otp) async {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final referenceNo = args['referenceNo'];
    log(referenceNo);

    final url = Uri.parse('${Constant.subscriptionApiURL}/otp/verify');
    log(Constant.appID);

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "appId": Constant.appID,
        "password": Constant.password,
        "referenceNo": referenceNo,
        "otp": otp,
      }),
    );

    // {
    //         statusCode: response.data.statusCode,
    //         version: response.data.version,
    //         subscriptionStatus:response.data.subscriptionStatus,
    //         statusDetail:response.data.statusDetail,
    //         subscriberId:response.status.subscriberId
    //     }

    final data = jsonDecode(response.body);
    String message = '';

    if (response.statusCode == 200) {
      if (data['statusCode'] == 'S1000') {
        message = 'OTP successfully Verified!';

        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, MainMenuScreen.routeName);
      } else if (data['statusCode'] == 'S1') {
        // ignore: use_build_context_synchronously
        message = "${data['statusCode']} ${data['statusDetail']}";
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      // ignore: use_build_context_synchronously
      message = "${response.statusCode} ${response.body}";
      throw Exception(message);
    }
    log(message);
    // ignore: use_build_context_synchronously
    showSnackBar(context, message);
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
                onTap: () => otpVerify(context, _otpController.text),
                text: 'VERIFY',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
