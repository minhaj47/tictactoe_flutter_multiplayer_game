import 'package:flutter/material.dart';
import 'package:tictactoe_flutter_multiplayer_game/responsive/responsive.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/create_room_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/join_room_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => createRoom(context),
              text: "CREATE ROOM",
            ),
            const SizedBox(height: 20),
            CustomButton(onTap: () => joinRoom(context), text: "JOIN ROOM"),
          ],
        ),
      ),
    );
  }
}
