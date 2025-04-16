// FILE: invite_friends_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({super.key});

  void _launchURL(BuildContext context, String url, String label) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open $label')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Friends'),
        backgroundColor: const Color(0xFF25AAAC),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              "Share with friends via:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _socialIcon(
                  context,
                  icon: Icons.camera_alt,
                  label: "Instagram",
                  url: "https://www.instagram.com/your_username",
                ),
                _socialIcon(
                  context,
                  icon: Icons.facebook,
                  label: "Facebook",
                  url: "https://www.facebook.com/your_page",
                ),
                _socialIcon(
                  context,
                  icon: Icons.chat,
                  label: "LINE",
                  url: "https://line.me/ti/p/your_line_id",
                ),
                _socialIcon(
                  context,
                  icon: Icons.videogame_asset,
                  label: "Discord",
                  url: "https://discord.gg/your_invite_link",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(BuildContext context, {
    required IconData icon,
    required String label,
    required String url,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () => _launchURL(context, url, label),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF25AAAC),
            radius: 28,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
