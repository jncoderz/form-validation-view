import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isVisibleObsecure = false;

  void _submittedForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Form submitted sccessfully"),
        ),
      );
    }
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Enter name";
    } else if (RegExp(r"^[a-zA-Z]+$").hasMatch(value)) {
      return "Please enter a valid name without numbers or special characters";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Please enter your email address";
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(value)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  String? validatePassword(String? value, String? text) {
    if (value!.isEmpty) {
      return "Please enter your password";
    } else if (value.length < 6) {
      return "Password should be at least 6 characters long";
    } else if (!RegExp(r"^[a-zA-Z0-9]+$").hasMatch(value)) {
      return "Password should only contain letters and numbers";
    }
    return null;
  }

  String? validateConfirmPassword(String? value, String? text) {
    if (value!.isEmpty) {
      return "Please confirm your password";
    } else if (value != text) {
      return "Passwords do not match";
    }
    return validatePassword(value, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/images/jnlogo.png"),
                  height: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create \n New Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                            height: 1),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) => validateName(value),
                        controller: _nameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person), hintText: "Name"),
                      ),
                      TextFormField(
                        validator: (value) => validateEmail(value),
                        controller: _emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email), hintText: "Email"),
                      ),
                   
                      TextFormField(
                        validator: (value) =>
                            validatePassword(value, _passwordController.text),
                        controller: _passwordController,
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: isVisibleObsecure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisibleObsecure = !isVisibleObsecure;
                                  });
                                },
                                icon: isVisibleObsecure
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility)),
                            prefixIcon: Icon(Icons.password),
                            hintText: "Password"),
                      ),
                    
                      TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: isVisibleObsecure,
                        validator: (value) => validateConfirmPassword(
                            value, _passwordController.text),
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            hintText: "Confirm Password"),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            minimumSize: Size(400, 50)),
                        onPressed: () {
                          _submittedForm();
                        },
                        child: Text(
                          "Create",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
