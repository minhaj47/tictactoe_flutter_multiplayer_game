import 'package:flutter/material.dart';
import 'package:tictactoe_flutter_multiplayer_game/resources/socket_methods.dart';
import 'package:tictactoe_flutter_multiplayer_game/responsive/responsive.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_button.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_text.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
    _nameController.dispose();
    _phoneNoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Responsive(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                  shadows: [
                    Shadow(
                      blurRadius: 40,
                      color: Colors.blue,
                    )
                  ],
                  text: 'JOIN ROOM',
                  fontSize: 60,
                ),
                SizedBox(height: size.height * 0.08),
                CustomTextField(
                  controller: _nameController,
                  hintText: 'Enter your nickname',
                ),
                SizedBox(height: size.height * 0.02),
                CustomTextField(
                  controller: _gameIdController,
                  hintText: 'Enter your gameId',
                ),
                // SizedBox(height: size.height * 0.02),
                // CustomTextField(
                //   controller: _phoneNoController,
                //   hintText: 'Enter your Phone No.',
                // ),
                SizedBox(height: size.height * 0.04),
                CustomButton(
                  onTap: () => _socketMethods.joinRoom(
                    _nameController.text,
                    _phoneNoController.text,
                    _gameIdController.text,
                  ),
                  text: 'JOIN',
                ),
              ],
            )),
      ),
    );
  }
}
