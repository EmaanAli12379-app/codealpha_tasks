import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/workout_model.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();

  bool _isSaving = false;

  Future<void> _saveWorkout() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaving = true;
      });

      try {
        final newWorkout = Workout(
          title: _titleController.text.trim(),
          durationMinutes: int.tryParse(_durationController.text.trim()) ?? 0,
          calories: int.tryParse(_caloriesController.text.trim()) ?? 0,
          steps: int.tryParse(_stepsController.text.trim()) ?? 0,
          date: DateTime.now().toString().split(' ')[0],
        );

        await DBHelper.insertWorkout(newWorkout);

        if (mounted) {
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $e')));
        }
      } finally {
        if (mounted) {
          setState(() {
            _isSaving = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121824),
      appBar: AppBar(
        title: const Text(
          'Log Workout',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildCustomTextField(
                controller: _titleController,
                label: 'Exercise Type',
                hint: 'e.g., Running, Gym, Swimming',
                icon: Icons.fitness_center_rounded,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildCustomTextField(
                controller: _durationController,
                label: 'Duration',
                hint: 'e.g., 45',
                suffix: 'mins',
                icon: Icons.timer_rounded,
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildCustomTextField(
                controller: _caloriesController,
                label: 'Calories Burned',
                hint: 'e.g., 300',
                suffix: 'kcal',
                icon: Icons.local_fire_department_rounded,
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              _buildCustomTextField(
                controller: _stepsController,
                label: 'Steps (Optional)',
                hint: 'e.g., 5000',
                suffix: 'steps',
                icon: Icons.directions_walk_rounded,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 32),
              // FIXED: Center-aligned, sleek fixed-width button
              Center(
                child: SizedBox(
                  width: 220,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveWorkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00E676),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Color(0xFF121824),
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'Save Activity',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF121824),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? suffix,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2638),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withAlpha(13)),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          prefixIcon: Icon(icon, color: const Color(0xFF00E5FF)),
          suffixText: suffix,
          suffixStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF00E676),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xFF1E2638),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}
