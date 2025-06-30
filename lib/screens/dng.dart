import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class FormGridScreen extends StatelessWidget {
  const FormGridScreen({super.key});

  static const List<String> fieldHints = [
    'Department',
    'Link',
    'Project',
    'Folder',
    'Type',
    'Location',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E8EC),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Top section: form fields + description
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side
                    Expanded(
                    flex: 2,
                    child: FormFieldsWithButton(fieldHints: fieldHints),
                    ),
                  const SizedBox(width: 40),
                  // Right side: description
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Description", style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 8),
                        Container(
                          height: 180,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: TextField(
                            maxLines: null,
                            expands: true,
                            decoration: const InputDecoration.collapsed(hintText: ''),
                            onSubmitted: (value) {
                              developer.log('Description submitted: $value');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            //  Doc - ID
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Doc - ID", style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 480,
                    height: 54,
                    child: _buildInputField(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({String? hintText}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[400],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

// FormFieldsWithButton widget
class FormFieldsWithButton extends StatelessWidget {
  final List<String> fieldHints;

  const FormFieldsWithButton({required this.fieldHints});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 3.5,
            ),
            itemCount: fieldHints.length,
            itemBuilder: (context, index) {
              return TextField(
                decoration: InputDecoration(
                  hintText: fieldHints[index],
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              developer.log('Submit button pressed');
            },
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
