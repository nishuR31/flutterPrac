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
            const SizedBox(height: 12),
            _FaqItem(
              question: 'Do I need to register?',
              answer:
                  'Absolutely no, the service is open and free to use, no need to register for anything',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _FaqItem(
              question: 'Does it steal my data anonymously?',
              answer:
                  'No, this app is build securely to just display data and not to steal any user data.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _FaqItem(
              question: 'What tech stack its using?',
              answer:
                  'It uses Flutter for the frontend, Material3 for UI , Node with Fastify for backend services, Prisma ORM with Postgres Database and Redis for caching.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _FaqItem(
              question: 'What is an SBC vs a microcontroller?',
              answer:
                  'A Single Board Computer (SBC) like Raspberry Pi runs a full OS and is suited for desktop-like tasks. Microcontrollers like Arduino are lightweight, run a single program, and are ideal for real-time hardware control.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _FaqItem(
              question: 'Which popular SBCs are covered?',
              answer:
                  'Common SBCs you will find here include Raspberry Pi, Banana Pi, and BeagleBone. Each entry has a short description and key pins to help you get started.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _FaqItem(
              question: 'Do I need special tools to work with these boards?',
              answer:
                  'Basic tools: a USB cable, power supply, jumper wires, and a breadboard. For SBCs you may need a microSD card with an OS image. For microcontrollers you need a simple programmer or USB interface.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 24),

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
