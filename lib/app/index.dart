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
    return MaterialApp.router(
      title: "Board Vault",
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      routerConfig: appRouter,
      scrollBehavior: CustomScrollBehaviour(),
    );
  }
}
