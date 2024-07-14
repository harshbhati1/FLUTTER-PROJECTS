import 'package:chatapp1/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chatmessages extends StatelessWidget {
  const Chatmessages({super.key});

 
  

  @override
  Widget build(BuildContext context) {
    final authenticatedUserId = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(), builder: (ctx,snapshots){
      if (snapshots.connectionState == ConnectionState.waiting){
        return const Center(
          child:  CircularProgressIndicator(),
        );
      }

      if (!snapshots.hasData || snapshots.data!.docs.isEmpty){
        return const Center(
          child: Text('No message found'),
        );
      }

      if (snapshots.hasError){
        return const Center(
          child: Text('Something went wrong'),
        );
      
      }

      final chatdata = snapshots.data!.docs;

      return ListView.builder(padding: const EdgeInsets.only(bottom: 40,left: 13,right: 13),reverse: true,itemCount: chatdata.length,itemBuilder: (ctx,index){
        final chatmessage = chatdata[index].data();
        final nextchatmessage = index+1< chatdata.length? chatdata[index+1].data(): null;

        final currentmessageuserid = chatmessage['userId'];
        final nextmessageuserid = nextchatmessage!=null? nextchatmessage['userId'] : null;

        final nextuserissame = currentmessageuserid == nextmessageuserid;

        if (nextuserissame){
          return MessageBubble.next(message: chatmessage['text'], isMe: authenticatedUserId.uid == currentmessageuserid );
        } else{
          return MessageBubble.first(userImage: chatmessage['userImage'], username: chatmessage['username'], message: chatmessage['text'], isMe:authenticatedUserId.uid == currentmessageuserid );
        }

      }

     // Text(data[index].data()['text'])
      );

    });
  }
}