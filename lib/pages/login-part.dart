import 'package:bcwallet/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  double? deviceHeight, deviceWidth;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  FirebaseServices? firebaseServices;

  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
    firebaseServices = GetIt.instance.get<FirebaseServices>();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth! * 0.05,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logoDisplay(),
                loginForm(),
                loginButton(),
                registerPageLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget logoDisplay() {
    return const Text(
      "BC Wallet",
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget loginForm() {
    return SizedBox(
      height: deviceHeight! * 0.20,
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            emailTextField(),
            passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Email...."),
      onSaved: (value) {
        setState(() {
          email = value;
        });
      },
      validator: (value) {
        bool result = value!.contains(
          RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"),
        );
        return result ? null : "Please enter a valid email";
      },
    );
  }

  Widget passwordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: const InputDecoration(hintText: "Password..."),
      onSaved: (value) {
        setState(() {
          password = value;
        });
      },
      validator: (value) => value!.length >= 8
          ? null
          : "Please enter a password greater than 8 characters",
    );
  }

  Widget loginButton() {
    return MaterialButton(
      onPressed: loginUser,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minWidth: deviceHeight! * 0.7,
      height: deviceHeight! * 0.08,
      color: Colors.blue,
      child: const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget registerPageLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "register"),
      child: const Text(
        "Don't have an account? Register Here",
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 139, 1),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void loginUser() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      bool result =
          await firebaseServices!.loginUser(email: email!, password: password!);
      if (result) {
        Navigator.popAndPushNamed(context, 'homepage');
      }
    }
  }
}
