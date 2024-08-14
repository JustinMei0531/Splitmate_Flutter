import "dart:async";
import "package:animate_do/animate_do.dart";
import "package:flutter/material.dart";
import "utils/validation_utils.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  // This list contains images that shown on the login page
  final List<String> images = [
    "./assets/images/login_image01.png",
    "./assets/images/login_image02.png",
    "./assets/images/login_image03.png",
    "./assets/images/login_image04.png",
  ];

  int activationIndex = 0;

  Timer? timer; // Set timer as a member to avoid memory leak

  void startTimer() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        activationIndex = (activationIndex + 1) % images.length;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              FadeInUp(
                  child: Container(
                height: 350,
                child: Stack(
                  children: images.asMap().entries.map((e) {
                    return Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 1),
                        opacity: activationIndex == e.key ? 1 : 0,
                        child: Image.asset(
                          e.value,
                          height: 400,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )),
              const SizedBox(
                height: 40,
              ),
              // Username Input field (actually we use email to login)
              FadeInUp(
                delay: const Duration(microseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: TextField(
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Email",
                      hintText: "Your email",
                      hintStyle: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14.0),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon: const Icon(Icons.person,
                          color: Colors.black, size: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 40),
              FadeInUp(
                delay: const Duration(microseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: "Password",
                      hintText: "Password",
                      hintStyle: const TextStyle(
                          color: Colors.lightBlue, fontSize: 14),
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      prefixIcon:
                          const Icon(Icons.key, color: Colors.black, size: 18),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10)),
                      floatingLabelStyle:
                          const TextStyle(color: Colors.black, fontSize: 18)),
                ),
              ),

              FadeInUp(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              FadeInUp(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("/");
                  },
                  height: 45,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.black,
                  child: const Text("Login",
                      style: TextStyle(color: Colors.white)),
                ),
              ),

              const SizedBox(height: 30),

              FadeInUp(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 1500),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Apply to be tanent",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 46386