import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mortgage_calculator_provider_app/mortgage_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MortgageProvider(),
      child: const MyApp(),
    ),
  );
}

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Mortgage Calculator',
    home: const MyHomePage(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mortgage Calculator',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mortgage Calculator'),
      ),
      body: const Center(
        child: Text('Please enter your mortgage details:'),
      ),
    );
  }
}