import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone_flutter/resources/firestore_methods.dart';

class HistoryMeetingPage extends StatelessWidget {
  const HistoryMeetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              "Room Name:${(snapshot.data! as dynamic).docs[index]['meetingName']} ",
            ),
            subtitle: Text(
              "Joined on:${DateFormat.yMMMd().format((snapshot.data! as dynamic).docs[index]['createdAt'].toDate())}",
            ),
          ),
        );
      },
      stream: FirestoreMethods().meetingsHistory,
    );
  }
}
