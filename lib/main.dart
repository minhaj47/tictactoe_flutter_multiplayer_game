import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_flutter_multiplayer_game/provider/room_data_provider.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/create_room_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/game_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/join_room_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/login_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/main_menu_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/screens/otp_check_screen.dart';
import 'package:tictactoe_flutter_multiplayer_game/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RoomDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          OTPCheck.routeName: (context) => const OTPCheck(),
        },
        initialRoute: LoginScreen.routeName,
        home: const MainMenuScreen(),
      ),
    );
  }
}
