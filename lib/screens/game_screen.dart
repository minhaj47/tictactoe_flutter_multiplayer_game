import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe_flutter_multiplayer_game/provider/room_data_provider.dart';
import 'package:tictactoe_flutter_multiplayer_game/resources/socket_methods.dart';
import 'package:tictactoe_flutter_multiplayer_game/views/scoreboard.dart';
import 'package:tictactoe_flutter_multiplayer_game/views/tictactoe_board.dart';
import 'package:tictactoe_flutter_multiplayer_game/views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    log(Provider.of<RoomDataProvider>(context).player1.nickname.toString());
    log(Provider.of<RoomDataProvider>(context).player2.nickname.toString());

    return Scaffold(
      body: roomDataProvider.roomData['isJoin']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Scoreboard(),
                  const TicTacToeBoard(),
                  Text(
                      '${roomDataProvider.roomData['turn']['nickname']}\'s turn'),
                ],
              ),
            ),
    );
  }
}
