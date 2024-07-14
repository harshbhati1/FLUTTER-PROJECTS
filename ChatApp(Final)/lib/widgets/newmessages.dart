import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Newmessages extends StatefulWidget {
  const Newmessages({super.key});

  @override
  State<Newmessages> createState() => _NewmessagesState();
}

class _NewmessagesState extends State<Newmessages> {
  final TextEditingController message = TextEditingController();

  @override
  void dispose() {
    message.dispose();
    super.dispose();
  }

  void _submit() async {
    if (message.text.trim().isEmpty) {
      return;
    }

    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;
    final userdata = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    await FirebaseFirestore.instance.collection('chat').add({
      'text': message.text,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userdata.data()!['username'],
      'userImage': userdata.data()!['image_url'],
    });

    message.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: message,
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              decoration: const InputDecoration(
                labelText: 'Send a message....',
              ),
            ),
          ),
          IconButton(
            onPressed: _submit,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
