import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './main.dart';

class Overview extends StatefulWidget {
  const Overview({super.key});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthChecker()),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Overview Screen'),
      ),
    );
  }
}
