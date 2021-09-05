part of gundart;

class _Message {
  final String id;
  final String command;
  final Map args;
  final DateTime date;

  _Message({
    required this.id,
    required this.command,
    required this.args,
    DateTime? date,
  }) : this.date = date ?? DateTime.now();

  Map<String, dynamic> get json {
    return {
      'id': id,
      'command': command,
      'args': args,
      'date': date.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return json.toString();
  }

  @override
  bool operator ==(dynamic other) {
    if (other is _Message) return other.date.compareTo(date) == 0;
    return false;
  }

  @override
  int get hashCode {
    return date.millisecondsSinceEpoch;
  }

  factory _Message.fromMap(dynamic data) {
    return _Message(
      id: data['id'],
      command: data['command'],
      args: data['args'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
    );
  }
}
