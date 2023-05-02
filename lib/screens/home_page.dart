import 'package:flutter/material.dart';
import 'package:zoom_clone_flutter/resources/auth_methods.dart';
import 'package:zoom_clone_flutter/screens/history_meeting_page.dart';
import 'package:zoom_clone_flutter/screens/meetings_page.dart';
import 'package:zoom_clone_flutter/utils/colors.dart';
import 'package:zoom_clone_flutter/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetingPage(),
    const HistoryMeetingPage(),
    Center(
        child: const Text(
      'Contacts',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
    )),
    CustomButton(text: "Log Out", onPressed: () => AuthMethods().signOut()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Meet & Chat'),
        backgroundColor: backgroundColor,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.comment_bank,
              ),
              label: 'Meet & Chat'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.lock_clock,
              ),
              label: 'Meetings'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'Contacts'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: 'Settings'),
        ],
      ),
    );
  }
}
