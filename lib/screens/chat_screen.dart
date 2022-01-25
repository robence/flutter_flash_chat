import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flash_chat/constants.dart';

final auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static const name = '/chat';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final firestore = FirebaseFirestore.instance;

  late User loggedInUser;

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textMessage = '';
    final messageTextController = TextEditingController();

    Future<void> addMessage({required String sender, required String text}) {
      // Call the user's CollectionReference to add a new user
      return messages
          .add({
            'sender': sender, // John Doe
            'text': text, // Stokes and Sons
          })
          .then((value) => print("Messages Added"))
          .catchError((error) => print("Failed to add message: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                builder: (context, snapshot) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextMessages(),
                  );
                },
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        textMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (loggedInUser.email != null) {
                        addMessage(
                            sender: loggedInUser.email!, text: textMessage);
                      }
                      messageTextController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextMessages extends StatefulWidget {
  const TextMessages({Key? key}) : super(key: key);

  @override
  _TextMessagesState createState() => _TextMessagesState();
}

class _TextMessagesState extends State<TextMessages> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('messages').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong',
              style: Theme.of(context).textTheme.bodyText1);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading", style: Theme.of(context).textTheme.bodyText1);
        }

        return ListView(
          children:
              snapshot.data!.docs.reversed.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return MessageBubble(
              data: data,
              isMe: data['sender'] == auth.currentUser?.email,
            );
          }).toList(),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.data,
    required this.isMe,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            data['sender'],
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.only(
              topLeft: !isMe ? Radius.zero : const Radius.circular(30.0),
              topRight: isMe ? Radius.zero : const Radius.circular(30.0),
              bottomLeft: const Radius.circular(30.0),
              bottomRight: const Radius.circular(30.0),
            ),
            color: isMe ? Colors.lightBlueAccent : Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(data['text'],
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 19,
                        color: Colors.white,
                      )),
            ),
          ),
        ],
      ),
    );
  }
}
