library gundart;

import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:convert';

part 'interfaces/message.dart';
part 'interfaces/gun_options.dart';
part 'interfaces/gun_chain_reference.dart';

class Gun {
  static final _isReday = Completer();
  static List<String> _ids = ['-1'];
  static Future<Process>? _futureProsess;
  static Process? _prosess;
  static Stream<_Message>? _stdoutStream;
  static StreamSubscription<_Message>? _stdoutStreamSub;

  static void _init() {
    if (_futureProsess != null) return;
    _futureProsess = Process.start(
      'cd ../ && cd node && ts-node index.ts',
      [],
      runInShell: true,
    );
    _futureProsess?.then((value) {
      _prosess = value;
      final strStream = _prosess!.stdout.map((event) => utf8.decode(event));
      _stdoutStream = strStream
          .map((event) => json.decode(event))
          .where((event) => event is Map)
          .map((event) => _Message.fromMap(event))
          .asBroadcastStream();
      _stdoutStreamSub = _stdoutStream!.listen(_outlistener);
      strStream
          .firstWhere((data) => data.contains(
              'BEWARE: BETA VERSION OF NEW GUN! NOT ALL FEATURES FINISHED!'))
          .then((value) => _isReday.complete());
    });
  }

  static void _outlistener(_Message event) {
    print(event.json);
  }

  static void kill() {
    _stdoutStreamSub?.cancel();
  }

  // static Future<_Message> _waitFor(bool test(_Message event),
  //     {_Message orElse()?}) {
  //   return _stdoutStream!.firstWhere(test, orElse: orElse);
  // }

  static Future<Gun> getInstance({
    // options?: string | IGunConstructorOptions | string[]
    String? url,
    List<String>? urls,
    GunConstructorOptions? options,
  }) async {
    _init();
    final id = (num.parse(_ids.last) + 1).toString();
    await _isReday.future;
    // _prosess!.stdin.writeln('init $id');
    await _send(id, 'init', args: {options: url ?? urls ?? options?.json});
    return Gun._(id);
  }

  final String id;

  Gun._(this.id);

  // void _send(dynamic data) async {
  //   _prosess!.stdin.writeln(json.encode(data));
  // }

  static Future<void> _send(
    String id,
    String command, {
    Map<dynamic, dynamic>? args,
  }) async {
    final m = _Message(id: id, command: command, args: args ?? {});
    _prosess!.stdin.writeln(json.encode(m.json));
    // _send(m.json);
    await _stdoutStream!.firstWhere((event) => event == m);
    // await _waitFor();
  }

  Future<void> _fromatedSend(String command,
      {Map<dynamic, dynamic>? args}) async {
    return _send(id, command, args: args);
  }

  void close() {
    _fromatedSend('close');
  }
}
