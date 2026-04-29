import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './footer.dart';

class Health extends StatefulWidget {
  const Health({super.key});

  @override
  State<Health> createState() => _HealthState();
}

class _HealthState extends State<Health> {
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

  static const String _backendBaseUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'http://localhost:3000',
  );

  String _status = 'Tap the button to ping the backend.';
  bool _loading = false;
  bool _down = true;

  Future<void> _pingBackend() async {
    setState(() {
      _loading = true;
      _status = 'Pinging backend...';
    });

    try {
      final uri = Uri.parse('$_backendBaseUrl/health');
      final response = await http.get(uri);
      final ok = response.statusCode >= 200 && response.statusCode < 300;

      setState(() {
        _down = !ok;
        _status = 'Status: ${response.statusCode}\n${response.body}';
        _loading = false;
      });
    } catch (error) {
      setState(() {
        _status = 'Ping failed: $error';
        _loading = false;
        _down = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health | Uptime'),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12),
            Icon(
              _down ? Icons.cloud_off_outlined : Icons.cloud_outlined,
              size: 56,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Text(
              'Backend Ping',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This page pings from the environment and checks the health route.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.cloud_sharp, size: 56, color: colorScheme.primary),
                SizedBox(width: 20),
                Expanded(
                  child: Text(
                    "Backend is currently ${_down ? "Down" : "Up"}",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _pingBackend,
              child: Text(_loading ? 'Pinging...' : 'Ping health route'),
            ),
            const SizedBox(height: 20),
            Text(
              _status,
              style: TextStyle(
                fontSize: 14,
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
