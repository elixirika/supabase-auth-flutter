import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SupaEmailAuth(
                redirectTo: kIsWeb ? null : 'io.mydomain.myapp://callback',
                onSignInComplete: (response) {},
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
              ),
              // SupaMagicAuth(
              //   redirectUrl: kIsWeb ? null : 'io.mydomain.myapp://callback',
              //   onSuccess: (Session response) {},
              //   onError: (error) {},
              // ),
              // SupaResetPassword(
              //   accessToken: supabase.auth.currentSession?.accessToken,
              //   onSuccess: (UserResponse response) {},
              //   onError: (error) {},
              // ),
              // SupaPhoneAuth(
              //   authAction: SupaAuthAction.signUp,
              //   onSuccess: (AuthResponse response) {},
              // ),
              SupaSocialsAuth(
                socialProviders: [
                  OAuthProvider.apple,
                  OAuthProvider.google,
                ],
                colored: true,
                redirectUrl: kIsWeb ? null : 'io.mydomain.myapp://callback',
                onSuccess: (Session response) {},
                onError: (error) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
