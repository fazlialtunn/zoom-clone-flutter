import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone_flutter/resources/auth_methods.dart';
import 'package:zoom_clone_flutter/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone_flutter/utils/colors.dart';
import 'package:zoom_clone_flutter/widgets/meeting_option.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final AuthMethods _authMethods = AuthMethods();

  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  bool isMicMuted = true;
  bool isVideoMuted = true;
  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController.text,
      isAudioMuted: isMicMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text,
    );
  }

  onMicMuted(bool value) {
    setState(() {
      isMicMuted = value;
    });
  }

  onVideoMuted(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: 'Room ID',
                  contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0)),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Join",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MeetingOption(
            text: 'Mute my microphone',
            isMute: isMicMuted,
            onChange: onMicMuted,
          ),
          const SizedBox(
            height: 10,
          ),
          MeetingOption(
            text: 'Turn off my video',
            isMute: isVideoMuted,
            onChange: onVideoMuted,
          ),
        ],
      ),
    );
  }
}
