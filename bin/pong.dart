library pong;

import 'package:start/start.dart';
import 'package:args/args.dart';

/**
 * Starts the pong server.
 */
void startPongServer(port) {
  var memory = {};

  start(host: "0.0.0.0", port: port).then((app) {
    app.get("/pong/:length").listen((req) {
      int len = int.parse(req.param('length'));
      final answer = memory[len] != null ? memory[len] : memory[len] = "p".padRight(len - 2, "o") + "ng";
      req.response.status(200);
      req.response.send(answer);
    });

    print("Pong-Server is up and running, listening on port $port");

  });  
}

/**
 * Entrypoint to start the pong answer server without docker.
 */
void main(args) {
  
  // Command line options for the ping server
  final options = new ArgParser();
  options.addOption('port', abbr: 'p', defaultsTo: '8080', help: 'port number');
  final flags = options.parse(args);
  
  final port = int.parse(options.parse(args)['port']); // get the port number for the pong server

  startPongServer(port);
}