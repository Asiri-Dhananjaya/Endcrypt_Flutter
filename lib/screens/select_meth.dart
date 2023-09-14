import 'package:flutter/material.dart';
import 'package:endcrypt_12_4/utils/colors.dart';
import 'package:endcrypt_12_4/Widget_img/encrypt_button.dart';
import 'package:endcrypt_12_4/Widget_img/decrypt_button.dart';
import 'package:endcrypt_12_4/screens/encrypt.dart';
import 'package:endcrypt_12_4/screens/decrypt.dart';

class SelectMethodScreen extends StatefulWidget {
  const SelectMethodScreen({Key? key}) : super(key: key);

  @override
  State<SelectMethodScreen> createState() => _SelectMethodScreenState();
}

class _SelectMethodScreenState extends State<SelectMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Method"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("141E30"),
            hexStringToColor("243B55")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("141E30"),
          hexStringToColor("243B55")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        //---------------------------------------------------------------
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                encryptbutton(context, true, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => encrypt_sc()));
                }),
                const SizedBox(
                  height: 20,
                ),
                decryptbutton(context, true, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => dec_Sc()));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
