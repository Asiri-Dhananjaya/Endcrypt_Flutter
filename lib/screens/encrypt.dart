import 'package:clipboard/clipboard.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:endcrypt_12_4/utils/colors.dart';
import 'package:endcrypt_12_4/Widget_img/encrypt_button.dart';
import 'package:endcrypt_12_4/Widget_img/Paste_button.dart';
import 'package:endcrypt_12_4/Widget_img/clear_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:endcrypt_12_4/screens/login.dart';
class encrypt_sc extends StatefulWidget {
  @override
  State<encrypt_sc> createState() => _encrypt_scState();
  CollectionReference user = FirebaseFirestore.instance.collection('users');

}

var word = "";
String decryptedText = "";

class _encrypt_scState extends State<encrypt_sc> {
  final TextEditingController _editTextController = TextEditingController();

  var plainText = "";
  var encryptedText = "";
  var mailAdd = mailaddress().mailtxt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encrypt"),
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
                20, MediaQuery.of(context).size.height * 0.05, 20, 0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: TextField(
                    //scrollController: _scrollController,
                    controller: _editTextController,
                    autofocus: false,
                    keyboardType: TextInputType.multiline,
                    maxLines: 15,
                    onChanged: (s) => {},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter Text Here...',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                //**************************************************************
                encryptbutton(context, true, () {
                  final cipher = _editTextController.text;
                  final k = Key.fromUtf8('1234567891011123');
                  final iv = IV.fromLength(16);

                  final encrypter = Encrypter(AES(k));

                  final encrypted = encrypter.encrypt(cipher, iv: iv);

                  word = encrypted.base64;

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Done !"),
                        content: Text(
                          "Encrypted Text is :-\n\n$word",
                          style: const TextStyle(fontSize: 17),
                        ),
                        scrollable: true,
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              FlutterClipboard.copy(word)
                                  .then((value) => print('copied'));

                              Map<String,String> dataToSave={
                                'Encrypted' : _editTextController.text,
                                'User ID'   :mailAdd

                              };
                              FirebaseFirestore.instance.collection('users').add(dataToSave);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              backgroundColor: Colors.black87,
                            ),
                            child: const Text(
                              "Copy",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
                pastebutton(context, true, () {
                  FlutterClipboard.paste().then((value) {
                    setState(() {
                      _editTextController.text = value;
                    });
                  });
                }),
                clearbutton(context, true, () {
                  _editTextController.clear();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class variablepass {
  static String word_2 = decryptedText;
}
