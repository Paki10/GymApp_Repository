import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//Ik heb dit page eigenlijk gemaakt voor de support sectie, zodat als iemand een probleem heeft dat die ons kon coontacteren, op een specifieke manier.
//Omdat flutter niet zonder een backend of mailserver niet 100% kan checken of dat een mail verzonden is of niet.
//daarom heb ik het gewoon simpel gehouden met wat vooraf informatie. Ik denk wel dat ik het in de toekomst ga uitbereiden
class SupportEmailPage extends StatefulWidget {
  final String title;
  final String defaultSubject;

  const SupportEmailPage({
    super.key,
    required this.title,
    required this.defaultSubject,
  });

  @override
  State<SupportEmailPage> createState() => _SupportEmailPageState();
}

class _SupportEmailPageState extends State<SupportEmailPage> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    subjectController.text = widget.defaultSubject;
  }

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'shah10ak@yahoo.com',
      queryParameters: {
        'subject': subjectController.text,
        'body': messageController.text,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);

      // optioneel: kleine bevestiging
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email app opened'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: messageController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Message',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _sendEmail,
              child: const Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }
}
