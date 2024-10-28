import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './overview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL', fallback: ''),
    anonKey: dotenv.get('SUPABASE_ANON_KEY', fallback: ''),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthChecker(), // Check if user is already signed in
    );
  }
}

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});

  @override
  AuthCheckerState createState() => AuthCheckerState();
}

class AuthCheckerState extends State<AuthChecker> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (kDebugMode) {
      print(session);
    }
    if (session != null) {
      // schedule the navigation to happen after the build is complete
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Overview()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Builder(
              builder: (BuildContext context) {
                return SupaEmailAuth(
                  redirectTo: kIsWeb ? null : 'io.mydomain.myapp://callback',
                  onSignInComplete: (response) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Overview()),
                      );
                    });
                  },
                  onSignUpComplete: (response) {},
                  metadataFields: [
                    MetaDataField(
                      prefixIcon: const Icon(Icons.person),
                      label: 'Username',
                      key: 'username',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter something';
                        }
                        return null;
                      },
                    ),
                  ],
                );
              },
            ),

            // // Other Auth options, see complete HOW-TOS documentions :)
            // SupaMagicAuth(
            //   redirectUrl: kIsWeb ? null : 'io.mydomain.myapp://callback',
            //   onSuccess: (Session response) {},
            //   onError: (error) {},
            // ),
            // SupaPhoneAuth(
            //   authAction: SupaAuthAction.signUp,
            //   onSuccess: (AuthResponse response) {},
            // ),
            // SupaSocialsAuth(
            //   socialProviders: [
            //     OAuthProvider.apple,
            //     OAuthProvider.google,
            //   ],
            //   colored: true,
            //   redirectUrl: kIsWeb ? null : 'io.mydomain.myapp://callback',
            //   onSuccess: (Session response) {},
            //   onError: (error) {},
            // )
          ],
        ),
      ),
    );
  }
}
