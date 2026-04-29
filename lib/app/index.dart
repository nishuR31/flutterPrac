import "package:boardvault/shared/scrollBehaviour.dart";
import "package:flutter/material.dart";
import "/routes/index.dart";

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: true,
//       title: 'BoardVault | Your SBC buddy',

//       theme: ThemeData(
//         useMaterial3: true,
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87),
//       ),
//       // home: const Scaffold(body: Center(child: Text('BoardVault App'))),
//     );
//   }
// }

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final lightScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF0F4C81),
      brightness: Brightness.light,
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF7CC7FF),
      brightness: Brightness.dark,
    );

    return MaterialApp.router(
      title: "Board Vault",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightScheme,
        scaffoldBackgroundColor: lightScheme.surface,
        cardColor: lightScheme.surfaceContainerHighest,
        dividerColor: lightScheme.outlineVariant,
        textTheme: Typography.blackMountainView.apply(
          bodyColor: lightScheme.onSurface,
          displayColor: lightScheme.onSurface,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkScheme,
        scaffoldBackgroundColor: darkScheme.surface,
        cardColor: darkScheme.surfaceContainerHighest,
        dividerColor: darkScheme.outlineVariant,
        textTheme: Typography.whiteMountainView.apply(
          bodyColor: darkScheme.onSurface,
          displayColor: darkScheme.onSurface,
        ),
      ),
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
      scrollBehavior: CustomScrollBehaviour(),
    );
  }
}
