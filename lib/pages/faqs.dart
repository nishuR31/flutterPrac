import 'package:flutter/material.dart';
import './footer.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Icon(
              Icons.help_outline_rounded,
              size: 56,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'Frequently Asked Questions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'A few quick answers for the most common questions.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            _FaqItem(
              question: 'What is Board Vault?',
              answer:
                  'Board Vault is a simple learning app for board pictures, descriptions, and basic reference info regarding SBCs , Micro Controllers',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _FaqItem(
              question: 'Why is the layout so simple?',
              answer:
                  'The app is intentionally kept clean so the important board details stay easy to scan. Actually it\'s simple cause I am not too fluent with Flutter',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _FaqItem(
              question: 'Does the app need internet?',
              answer:
                  'Only features that load data from a backend like boards data or specific board data or remote source need a network connection.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 24),
            Divider(color: colorScheme.outlineVariant),

            Footer(scrollController: scrollController),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  const _FaqItem({
    required this.question,
    required this.answer,
    required this.colorScheme,
  });

  final String question;
  final String answer;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.question_mark_rounded, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                answer,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
