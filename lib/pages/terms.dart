import 'package:flutter/material.dart';
import './footer.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
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
        title: const Text('Terms or Use and Services'),
        centerTitle: true,
        backgroundColor: Color(0x000000),
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Icon(Icons.rule_outlined, size: 56, color: colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              'Terms of Use',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'These simple terms explain how to use Board Vault responsibly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Basic rules',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            _TermRow(
              icon: Icons.check_circle_outline_rounded,
              text:
                  'Use the app for learning, reference, and personal projects guides.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _TermRow(
              icon: Icons.share_outlined,
              text:
                  'Do not misuse the content or try to republish it without permission.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _TermRow(
              icon: Icons.warning_amber_outlined,
              text:
                  'Content is provided as-is, so always double-check wiring and hardware details in their official documentations.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 24),
            Divider(color: colorScheme.outlineVariant),
            const SizedBox(height: 12),
            Text(
              'If the app changes, these terms can be updated too.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Footer(scrollController: scrollController),
          ],
        ),
      ),
    );
  }
}

class _TermRow extends StatelessWidget {
  const _TermRow({
    required this.icon,
    required this.text,
    required this.colorScheme,
  });

  final IconData icon;
  final String text;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
