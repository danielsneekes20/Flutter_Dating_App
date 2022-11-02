import 'package:dating_app_ikfram/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dating_app_ikfram/constants.dart';
import 'package:dating_app_ikfram/components/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:dating_app_ikfram/components/current_userdata.dart';

class PersonalPage extends StatefulWidget {
  static const String routeName = '/personal';

  @override
  PersonalPageState createState() => PersonalPageState();

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => PersonalPage(),
    );
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
var collection = FirebaseFirestore.instance.collection('users');
final User? user = auth.currentUser;

class PersonalPageState extends State<PersonalPage> {
  late String bio;
  static List images = [];

  int b = 0;
  late String
      localImage; // voor als er een nieuwe foto wordt geupload, wordt de oude foto(bijv: images[3] vervangen voor de localimage
  late String foto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            appBar: CustomAppbar(title: 'Couply'),
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(images[0]))),
                  ),
                  Text(Current_user_data.username, style: kProfUi),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Enter your bio',
                          style: kProfUi.copyWith(fontSize: 25),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            initialValue: Current_user_data.bio,
                            maxLength: 100,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                fillColor: Color(white),
                                counterText: "",
                                focusedBorder: InputBorder.none),
                            // keyboardType: TextInputType.text,
                            maxLines: 3,
                            expands: false,
                            maxLengthEnforcement: MaxLengthEnforcement.none,
                            onChanged: (value) {
                              bio = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Enter your Location',
                          style: kProfUi.copyWith(fontSize: 25),
                        ),
                        TextFormField(
                          initialValue: "Amsterdam",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Pictures',
                          style: kProfUi.copyWith(fontSize: 25),
                        ),
                        SizedBox(
                          height: 125,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      ImagePicker _picker = ImagePicker();
                                      final firebase_storage.FirebaseStorage
                                          storage = firebase_storage
                                              .FirebaseStorage.instance;
                                      final XFile? _image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      if (_image == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "No images selected")));
                                      }
                                      if (_image != null) {
                                        Future<void> uploadImage(
                                            XFile _image) async {
                                          try {
                                            await storage
                                                .ref('user_1/${_image.path}')
                                                .putFile(
                                                  File(_image.path),
                                                );
                                            localImage = await storage
                                                .ref('user_1/${_image.path}')
                                                .getDownloadURL();

                                            final FirebaseAuth auth =
                                                FirebaseAuth.instance;
                                            var collection = FirebaseFirestore
                                                .instance
                                                .collection('users');
                                            final User? user = auth.currentUser;
                                            await collection
                                                .doc(user!.uid)
                                                .update({
                                                  'image_0':
                                                      localImage // image_1
                                                }) // <-- Document ID
                                                .then((_) => print('Added'))
                                                .catchError((error) => print(
                                                    'Add failed: $error'));
                                            setState(() {
                                              images[0] = localImage;
                                            });
                                          } catch (_) {}
                                        }

                                        uploadImage(_image);
                                      }
                                    },
                                    child: Container(
                                        height: 125,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                // image:NetworkImage(user.images[index])
                                                image:
                                                    NetworkImage(images[0])))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      ImagePicker _picker = ImagePicker();
                                      final firebase_storage.FirebaseStorage
                                          storage = firebase_storage
                                              .FirebaseStorage.instance;
                                      final XFile? _image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      if (_image == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "No images selected")));
                                      }
                                      if (_image != null) {
                                        Future<void> uploadImage(
                                            XFile _image) async {
                                          try {
                                            await storage
                                                .ref('user_1/${_image.path}')
                                                .putFile(
                                                  File(_image.path),
                                                );
                                            localImage = await storage
                                                .ref('user_1/${_image.path}')
                                                .getDownloadURL();

                                            final FirebaseAuth auth =
                                                FirebaseAuth.instance;
                                            var collection = FirebaseFirestore
                                                .instance
                                                .collection('users');
                                            final User? user = auth.currentUser;
                                            collection
                                                .doc(user!.uid)
                                                .update({
                                                  'image_1': localImage
                                                }) // <-- Document ID
                                                .then((_) => print('Added'))
                                                .catchError((error) => print(
                                                    'Add failed: $error'));
                                            setState(() {
                                              images[1] = localImage;
                                            });
                                          } catch (_) {}
                                          setState(() {});
                                        }
                                        uploadImage(_image);
                                      }
                                    },
                                    child: Container(
                                        height: 125,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                // image:NetworkImage(user.images[index])
                                                image:
                                                    NetworkImage(images[1])))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      ImagePicker _picker = ImagePicker();
                                      final firebase_storage.FirebaseStorage
                                          storage = firebase_storage
                                              .FirebaseStorage.instance;
                                      final XFile? _image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      if (_image == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "No images selected")));
                                      }
                                      if (_image != null) {
                                        Future<void> uploadImage(
                                            XFile _image) async {
                                          try {
                                            await storage
                                                .ref('user_1/${_image.path}')
                                                .putFile(
                                                  File(_image.path),
                                                );
                                            print("change");
                                            localImage = await storage
                                                .ref('user_1/${_image.path}')
                                                .getDownloadURL();

                                            final FirebaseAuth auth =
                                                FirebaseAuth.instance;
                                            var collection = FirebaseFirestore
                                                .instance
                                                .collection('users');
                                            final User? user = auth.currentUser;
                                            collection
                                                .doc(user!.uid)
                                                .update({
                                                  'image_2': localImage
                                                }) // <-- Document ID
                                                .then((_) => print('Added'))
                                                .catchError((error) => print(
                                                    'Add failed: $error'));
                                            setState(() {
                                              images[2] = localImage;
                                            });
                                          } catch (_) {}
                                          setState(() {});
                                        }

                                        uploadImage(_image);
                                      }
                                    },
                                    child: Container(
                                        height: 125,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                // image:NetworkImage(user.images[index])
                                                image:
                                                    NetworkImage(images[2])))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      ImagePicker _picker = ImagePicker();
                                      final firebase_storage.FirebaseStorage
                                          storage = firebase_storage
                                              .FirebaseStorage.instance;
                                      final XFile? _image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      if (_image == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "No images selected")));
                                      }
                                      if (_image != null) {
                                        Future<void> uploadImage(
                                            XFile _image) async {
                                          try {
                                            await storage
                                                .ref('user_1/${_image.path}')
                                                .putFile(
                                                  File(_image.path),
                                                );
                                            print("change");
                                            print(b);
                                            localImage = await storage
                                                .ref('user_1/${_image.path}')
                                                .getDownloadURL();

                                            final FirebaseAuth auth =
                                                FirebaseAuth.instance;
                                            var collection = FirebaseFirestore
                                                .instance
                                                .collection('users');
                                            final User? user = auth.currentUser;
                                            collection
                                                .doc(user!.uid)
                                                .update({
                                                  'image_3': localImage
                                                }) // <-- Document ID
                                                .then((_) => print('Added'))
                                                .catchError((error) => print(
                                                    'Add failed: $error'));
                                            setState(() {
                                              images[3] = localImage;
                                            });
                                          } catch (_) {}
                                          setState(() {});
                                        }

                                        uploadImage(_image);
                                      }
                                    },
                                    child: Container(
                                        height: 125,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                // image:NetworkImage(user.images[index])
                                                image:
                                                    NetworkImage(images[3])))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onLongPress: () async {
                                      ImagePicker _picker = ImagePicker();
                                      final firebase_storage.FirebaseStorage
                                          storage = firebase_storage
                                              .FirebaseStorage.instance;
                                      final XFile? _image =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      if (_image == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "No images selected")));
                                      }
                                      if (_image != null) {
                                        Future<void> uploadImage(
                                            XFile _image) async {
                                          try {
                                            await storage
                                                .ref('user_1/${_image.path}')
                                                .putFile(
                                                  File(_image.path),
                                                );
                                            print("change");
                                            localImage = await storage
                                                .ref('user_1/${_image.path}')
                                                .getDownloadURL();

                                            final FirebaseAuth auth =
                                                FirebaseAuth.instance;
                                            var collection = FirebaseFirestore
                                                .instance
                                                .collection('users');
                                            final User? user = auth.currentUser;
                                            collection
                                                .doc(user!.uid)
                                                .update({
                                                  'image_4': localImage
                                                }) // <-- Document ID
                                                .then((_) => print('Added'))
                                                .catchError((error) => print(
                                                    'Add failed: $error'));
                                            setState(() {
                                              images[4] = localImage;
                                            });
                                          } catch (_) {}
                                          setState(() {});
                                        }

                                        uploadImage(_image);
                                      }
                                    },
                                    child: Container(
                                        height: 125,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                // image:NetworkImage(user.images[index])
                                                image:
                                                    NetworkImage(images[4])))),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                  RoundedButton(
                      title: 'apply',
                      colour: Color(roze),
                      onPressed: () async {
                        try {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          var collection =
                              FirebaseFirestore.instance.collection('users');
                          final User? user = auth.currentUser;
                          print(user);
                          collection
                              .doc(user!.uid)
                              .update({'bio': bio}) // <-- Document ID
                              .then((_) => print('Added'))
                              .catchError(
                                  (error) => print('Add failed: $error'));
                          setState(() {
                            Current_user_data.bio = bio;
                          });
                        } catch (e) {
                          print(e);
                        }
                      })
                ],
              ),
            )));
  }
}
