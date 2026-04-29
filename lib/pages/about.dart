import 'package:flutter/material.dart';
import './footer.dart';

class About extends StatefulWidget {
  const About({super.key});

  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
    // TODO: implement build
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
        backgroundColor: Color(0x000000),
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Icon(
              Icons.info_outline_rounded,
              size: 56,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              "Board Vault",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "A simple app for learning about single board computers and microcontrollers.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "What this app does",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Board Vault keeps things simple. It gives you board pictures, pin diagrams, and short descriptions so you can learn faster without too much clutter.",
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            _AboutRow(
              icon: Icons.image_rounded,
              text: "Pictures to help you identify each board.",
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _AboutRow(
              icon: Icons.alt_route_rounded,
              text: "Pin diagrams to make wiring easier to understand.",
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 12),
            _AboutRow(
              icon: Icons.description_rounded,
              text: "Short descriptions that are easy to read.",
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 24),
            Divider(color: colorScheme.outlineVariant),
            const SizedBox(height: 12),
            Text(
              "Built for learners, makers, and anyone who wants a quick overview of SBC hardware.",
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

class _AboutRow extends StatelessWidget {
  const _AboutRow({
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
