import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'message.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Message> _messages = <Message>[];
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Голосовой помошник')),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _getItem(_messages[index]),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: _textController,
                    decoration:
                        const InputDecoration(hintText: 'Отправить сообщение'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _senderMessage(_textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _getItem(Message message) {
    return Container(
      color: message.isSend ? Colors.tealAccent : Colors.limeAccent,
      margin: message.isSend
          ? const EdgeInsets.fromLTRB(80, 8, 4, 4)
          : const EdgeInsets.fromLTRB(4, 8, 80, 4),
      child: message.isSend
          ? _getMyListTile(message)
          : _getAssistentListTile(message),
    );
  }

  ListTile _getMyListTile(Message message) {
    return ListTile(
      leading: Icon(Icons.face),
      title: Text(message.text,
          textAlign: TextAlign.left, style: const TextStyle(fontSize: 18)),
      subtitle: Text(message.date, textAlign: TextAlign.left),
    );
  }

  ListTile _getAssistentListTile(Message message) {
    return ListTile(
        trailing: Icon(Icons.face),
        title: Text(message.text,
            textAlign: TextAlign.right, style: const TextStyle(fontSize: 18)),
        subtitle: Text(message.date, textAlign: TextAlign.right));
  }

  void _senderMessage(String question) {
    String answer = 'Ммм';
    _textController.clear();
    setState(() {
      _messages.insert(
          0,
          Message(
              text: question,
              isSend: true,
              date: DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())));
      _messages.insert(
          0,
          Message(
              text: answer,
              isSend: false,
              date: DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now())));
    });
  }
}
