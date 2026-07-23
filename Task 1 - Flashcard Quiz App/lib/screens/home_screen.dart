import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../widgets/flashcard_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Flashcard> _flashcards = [
    const Flashcard(
      question: "What is state management in Flutter?",
      answer:
          "It manages the state of the app and handles data flow across widgets.",
    ),
    const Flashcard(
      question: "What is OOP?",
      answer: "Object-Oriented Programming based on objects and classes.",
    ),
    const Flashcard(
      question: "What is Flutter?",
      answer:
          "Google's UI Toolkit for building beautiful cross-platform apps from a single codebase.",
    ),
    const Flashcard(
      question:
          "What is the difference between Stateless and Stateful widgets?",
      answer:
          "Stateless widgets cannot change their state during runtime, while Stateful widgets can dynamically update their UI.",
    ),
    const Flashcard(
      question: "What is Data Structures and Algorithms (DSA)?",
      answer:
          "DSA is about finding efficient ways to store, organize, and process data to solve programming problems.",
    ),
    const Flashcard(
      question: "What is a Database Management System (DBMS)?",
      answer:
          "DBMS is software used to store, retrieve, manage, and execute queries on data efficiently.",
    ),
    const Flashcard(
      question: "What is the purpose of pubspec.yaml file in Flutter?",
      answer:
          "It manages the app's assets (images, fonts) and external dependencies/packages.",
    ),
    const Flashcard(
      question: "What is an abstract class in OOP?",
      answer:
          "A blueprint class that cannot be instantiated directly and forces subclasses to implement its abstract methods.",
    ),
    const Flashcard(
      question: "What does the 'setState' method do?",
      answer:
          "It notifies the Flutter framework that the internal state has changed, triggering a redraw of the UI.",
    ),
    const Flashcard(
      question: "What is Python?",
      answer:
          "A high-level, interpreted programming language known for its simplicity and great use in AI, scripting, and web backend.",
    ),
  ];

  int _currentIndex = 0;
  bool _showAnswer = false;

  void _flipCard() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  void _nextCard() {
    if (_currentIndex < _flashcards.length - 1) {
      setState(() {
        _showAnswer = false;
        _currentIndex++;
      });
    }
  }

  void _prevCard() {
    if (_currentIndex > 0) {
      setState(() {
        _showAnswer = false;
        _currentIndex--;
      });
    }
  }

  // --- 1. CREATE FUNCTION ---
  void _showCreateDialog() {
    final questionController = TextEditingController();
    final answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Create New Flashcard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: 'Answer'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (questionController.text.isNotEmpty &&
                  answerController.text.isNotEmpty) {
                setState(() {
                  _flashcards.add(
                    Flashcard(
                      question: questionController.text,
                      answer: answerController.text,
                    ),
                  );

                  _currentIndex = _flashcards.length - 1;
                  _showAnswer = false;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // --- 2. EDIT FUNCTION ---
  void _showEditDialog() {
    if (_flashcards.isEmpty) return;

    final currentCard = _flashcards[_currentIndex];
    final questionController = TextEditingController(
      text: currentCard.question,
    );
    final answerController = TextEditingController(text: currentCard.answer);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Edit Flashcard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: 'Answer'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (questionController.text.isNotEmpty &&
                  answerController.text.isNotEmpty) {
                setState(() {
                  _flashcards[_currentIndex] = Flashcard(
                    question: questionController.text,
                    answer: answerController.text,
                  );
                  _showAnswer = false;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  // --- 3. DELETE FUNCTION ---
  void _deleteCurrentCard() {
    if (_flashcards.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text('Are you sure you want to delete this flashcard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _flashcards.removeAt(_currentIndex);

                if (_currentIndex >= _flashcards.length &&
                    _flashcards.isNotEmpty) {
                  _currentIndex = _flashcards.length - 1;
                }
                _showAnswer = false;
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasCards = _flashcards.isNotEmpty;
    final currentCardNumber = hasCards ? _currentIndex + 1 : 0;
    final totalCards = _flashcards.length;
    final progress = totalCards > 0 ? currentCardNumber / totalCards : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFE8E5F4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Top Action Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  Text(
                    'Flashcard Quiz',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        color: theme.colorScheme.primary,
                        onPressed: hasCards ? _showEditDialog : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded),
                        color: Colors.redAccent,
                        onPressed: hasCards ? _deleteCurrentCard : null,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Card Progress Tracker
              Text(
                hasCards
                    ? 'Card $currentCardNumber of $totalCards'
                    : 'No Cards Available',
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),

              // Custom Progress Bar
              Center(
                child: SizedBox(
                  width: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white.withOpacity(0.5),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                      minHeight: 6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Central Flashcard Widget
              Expanded(
                child: hasCards
                    ? FlashcardWidget(
                        flashcard: _flashcards[_currentIndex],
                        showAnswer: _showAnswer,
                        onFlip: _flipCard,
                      )
                    : const Center(
                        child: Text(
                          'Tap + Create to add your first flashcard!',
                          style: TextStyle(color: Colors.black45, fontSize: 16),
                        ),
                      ),
              ),
              const SizedBox(height: 30),

              // Bottom Navigation Controls
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _currentIndex > 0 && hasCards
                              ? _prevCard
                              : null,
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 16,
                          ),
                          label: const Text('Prev'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: theme.colorScheme.primary.withOpacity(0.3),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(width: 120),
                        ElevatedButton.icon(
                          onPressed:
                              _currentIndex < _flashcards.length - 1 && hasCards
                              ? _nextCard
                              : null,
                          icon: const Text('Next'),
                          label: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black87,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Create Button connected to _showCreateDialog
                    Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton.extended(
                        onPressed: _showCreateDialog,
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Create',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
