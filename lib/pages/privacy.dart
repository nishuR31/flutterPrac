import 'package:flutter/material.dart';
import './footer.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
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
              Icons.privacy_tip_outlined,
              size: 56,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'Privacy Policy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This page explains the basics of how Board Vault handles your data.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'What we collect',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            _PolicyRow(
              icon: Icons.person_outline_rounded,
              text:
                  'We do not ask for personal account details inside the app.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _PolicyRow(
              icon: Icons.storage_outlined,
              text:
                  'We only use the data stored in our database only to show the required board information and app content.',
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _PolicyRow(
              icon: Icons.settings_outlined,
              text:
                  'Any local app settings stay on your device unless a feature says otherwise.',
              colorScheme: colorScheme,
            ),

            const SizedBox(height: 12),
            _PolicyRow(
              text:
                  'We use stored content only to power the app: board descriptions, images, and metadata. We do not sell or share user-identifying data. Server logs may contain IPs for short-term troubleshooting and security.',

              colorScheme: colorScheme,
              icon: Icons.perm_media_outlined,
            ),
            const SizedBox(height: 12),
            _PolicyRow(
              colorScheme: colorScheme,
              icon: Icons.storage_sharp,
              text:
                  'We retain content required for the service. Access to servers is limited and standard security practices (updates, firewalls) are used. If you believe we hold data about you that should be removed, contact the maintainers.',
            ),
            const SizedBox(height: 24),

            Footer(scrollController: scrollController),
          ],
        ),
      ),
    );
  }
}

class _PolicyRow extends StatelessWidget {
  const _PolicyRow({
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
