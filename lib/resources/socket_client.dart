import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    log('inside socketClients _internal method');

    socket = IO.io('http://192.168.173.253:3000', <String, dynamic>{
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
