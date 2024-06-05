import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tictactoe_flutter_multiplayer_game/constant.dart';

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    log('inside socketClients _internal method');

    socket = IO.io(Constant.serverURL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    log('socket before connect');
    if (socket == null) log('socket is null');
    log(socket.toString());
    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    log('inside socketClients get method');
    return _instance!;
  }
}
