import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardWidget extends StatelessWidget {
  final Flashcard flashcard;
  final bool showAnswer;
  final VoidCallback onFlip;

  const FlashcardWidget({
    super.key,
    required this.flashcard,
    required this.showAnswer,
    required this.onFlip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SizedBox(
        width: 450,
        height: 280,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(
                  alpha: showAnswer ? 0.12 : 0.06,
                ),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Card(
            elevation: 0,
            color: showAnswer ? const Color(0xFFFBF7FF) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(
                color: showAnswer
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. Top Status Badge
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: showAnswer
                          ? theme.colorScheme.primary
                          : theme.colorScheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      showAnswer ? 'ANSWER' : 'QUESTION',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: showAnswer
                            ? Colors.white
                            : theme.colorScheme.primary,
                      ),
                    ),
                  ),

                  // 2. Central Question/Answer Text
                  Expanded(
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                        child: Text(
                          showAnswer ? flashcard.answer : flashcard.question,
                          key: ValueKey<bool>(showAnswer),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 3. Proper Solid "Show Answer" Button
                  SizedBox(
                    width: 180,
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: onFlip,
                      icon: Icon(
                        showAnswer
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 18,
                      ),
                      label: Text(
                        showAnswer ? 'Hide Answer' : 'Show Answer',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          fontSize: 14,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showAnswer
                            ? theme.colorScheme.primary.withValues(alpha: 0.1)
                            : theme.colorScheme.primary,
                        foregroundColor: showAnswer
                            ? theme.colorScheme.primary
                            : Colors.white,
                        elevation: showAnswer ? 0 : 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
