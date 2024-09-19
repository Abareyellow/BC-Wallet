import 'package:bcwallet/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  double? deviceWidth, deviceHeight;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  String? name, email, password;
  FirebaseServices? firebaseServices;

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
                titleDisplay(),
                registerForm(),
                registerButton(),
                loginLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleDisplay() {
    return const Text(
      "Registation for BC Wallet",
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget registerForm() {
    return SizedBox(
      height: deviceHeight! * 0.30,
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            nameTextForm(),
            emailTextForm(),
            passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget nameTextForm() {
    return TextFormField(
      decoration: const InputDecoration(
          hintText: "Enter Full Name (First and Last Names)..."),
      onSaved: (value) => {
        setState(() {
          name = value;
        }),
      },
      validator: (value) => value!.length > 1 ? null : "Please enter a name!!",
    );
  }

  Widget emailTextForm() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Enter your email..."),
      onSaved: (value) => {
        setState(() {
          email = value;
        }),
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
      decoration: const InputDecoration(hintText: "Enter a password..."),
      onSaved: (value) => {
        setState(() {
          password = value;
        }),
      },
      validator: (value) => value!.length >= 8
          ? null
          : "Please enter a password greater than 8 characters",
    );
  }

  Widget registerButton() {
    return MaterialButton(
      onPressed: registerUser,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minWidth: deviceHeight! * 0.60,
      height: deviceHeight! * 0.075,
      color: Colors.blue,
      child: const Text(
        "Register",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget loginLink() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, "login"),
      child: const Text(
        "Have a Account? Login Here",
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 139, 1),
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void registerUser() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      bool result = await firebaseServices!
          .registerUser(name: name!, email: email!, password: password!);
      if (result) {
        Navigator.pop(context);
      }
    }
  }
}
