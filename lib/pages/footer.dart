import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Footer extends StatelessWidget {
  const Footer({required this.scrollController, super.key});

  final ScrollController scrollController;

  void scrollToTop() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        const SizedBox(height: 12),
        Divider(color: colorScheme.outlineVariant),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Link(link: "/health", text: "Health", colorScheme: colorScheme),
            const SizedBox(width: 16),
            _Link(link: "/privacy", text: "Privacy", colorScheme: colorScheme),
            const SizedBox(width: 16),
            _Link(link: "/terms", text: "Terms", colorScheme: colorScheme),
            const SizedBox(width: 16),
            _Link(link: "/faqs", text: "FAQs", colorScheme: colorScheme),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: scrollToTop,
              child: Icon(Icons.arrow_upward, color: colorScheme.primary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "© 2026 Board Vault - All rights reserved",
          style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _Link extends StatelessWidget {
  const _Link({
    required this.link,
    required this.text,
    required this.colorScheme,
    super.key,
  });

  final String link;
  final String text;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(link);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 13, color: colorScheme.primary),
      ),
    );
  }
}
