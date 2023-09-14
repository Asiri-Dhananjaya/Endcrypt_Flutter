import 'package:endcrypt_12_4/screens/select_meth.dart';
import 'package:endcrypt_12_4/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:endcrypt_12_4/Widget_img/logo_widget.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  static var mailID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("141E30"),
          hexStringToColor("243B55")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),

        //------------------------------------------------------------

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/Logo.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter User Name", Icons.person_outline,
                    false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Enter Password", Icons.lock, true, _passwordController),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                   mailID = _emailTextController.text;
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordController.text,
                  )
                      .then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectMethodScreen()));
                  }).onError((error, stackTrace) {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                            title: const Text("Oops!"),
                            content: Text(error.toString())));
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Don't have account? Please contact\nthe administration section for create new account.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
class mailaddress {
  var mailtxt = _loginScreenState.mailID;


}
