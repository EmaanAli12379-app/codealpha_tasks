import 'dart:math';
import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../utils/quotes_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Quote currentQuote;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  void _getRandomQuote() {
    setState(() {
      int randomIndex = _random.nextInt(QuotesData.quotesList.length);
      currentQuote = QuotesData.quotesList[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8BFE7),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.deepPurpleAccent.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurpleAccent.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Text(
                      '💡 QUOTE OF THE DAY',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.deepPurple,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),

              
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 35.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.deepPurpleAccent.withValues(
                              alpha: 0.1,
                            ),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurpleAccent.withValues(
                                alpha: 0.08,
                              ),
                              blurRadius: 25,
                              spreadRadius: 2,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Icon(
                                Icons.format_quote_rounded,
                                size: 48,
                                color: Colors.deepPurple.withValues(alpha: 0.4),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              currentQuote.text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E2442),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 25),
                            Text(
                              "—  ${currentQuote.author}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF6B6579),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                      
                      const SizedBox(height: 20),

                      
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _getRandomQuote,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 4,
                            shadowColor: Colors.deepPurple.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          child: const Text(
                            "New Quote",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
