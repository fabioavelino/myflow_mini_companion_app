import 'dart:io';
import 'dart:convert';

void main() async {
  final server = await HttpServer.bind('localhost', 8080);
  print('Server running on http://localhost:8080');

  await for (HttpRequest request in server) {
    if (request.method == 'POST' && request.uri.path == '/training') {
      print('Route /training reached');
      
      final content = await utf8.decoder.bind(request).join();
      print('POST content: $content');
      
      request.response
        ..statusCode = HttpStatus.ok
        ..write('Request received')
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Not found')
        ..close();
    }
  }
}
