import 'package:drifttest/db/app_database/app_database.dart';
import 'package:drifttest/internet/network_service.dart';
import 'package:drifttest/pages/auth/base_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://kessvesugiwxnzgqgqig.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtlc3N2ZXN1Z2l3eG56Z3FncWlnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY4ODE1NzgsImV4cCI6MjA3MjQ1NzU3OH0.o6-tdjdirgMUKDtAR1W9NGWtDMh2C9e-3g9fbDpm0Os',
  );
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (_) => AppDatabase(),
          dispose: (_, AppDatabase db) => db.close(),
        ),
        ChangeNotifierProvider(
          create: (context) => NetworkService(context),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

AppDatabase returnDb(BuildContext context) {
  return Provider.of<AppDatabase>(context, listen: false);
}

NetworkService returnNetwork(
  BuildContext context, {
  bool listen = false,
}) {
  return Provider.of<NetworkService>(
    context,
    listen: listen,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
        ),
      ),
      home: const BasePage(),
    );
  }
}
