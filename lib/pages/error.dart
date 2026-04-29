import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Error extends StatelessWidget {
  const Error({super.key, this.route});

  final String? route;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 64, color: colorScheme.primary),
              const SizedBox(height: 16),
              Text(
                'Invalid route',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                route == null
                    ? 'The page you requested does not exist.'
                    : 'No page found for: $route',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => context.push('/'),
                    icon: Icon(Icons.arrow_right_outlined),
                    label: const Text('Go home'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => context.pop(context),
                    icon: Icon(Icons.arrow_left_outlined),
                    label: const Text('Go Back'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
