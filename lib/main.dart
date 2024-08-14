import "package:flutter/material.dart";
import "./ui/login/login_page.dart";
import "./ui/splash_screen/splash_screen.dart";
import "package:get/get.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "SplitMate",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),

      // Register app routers
      initialRoute: "/splash",

      getPages: <GetPage<dynamic>>[
        GetPage(name: "/splash", page: () => const SplashScreen()),
        GetPage(name: "/login", page: () => LoginPage()),
      ],
    );
  }
}

void main(List<String> args) {
  runApp(const App());
}
