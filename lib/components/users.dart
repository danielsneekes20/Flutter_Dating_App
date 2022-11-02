import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_ikfram/components/models.dart';
import 'package:dating_app_ikfram/screens/persona_page.dart';
import 'package:dating_app_ikfram/screens/personal_page.dart';
import 'package:equatable/equatable.dart';
export 'package:dating_app_ikfram/components/users.dart';
import 'package:dating_app_ikfram/screens/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dating_app_ikfram/components/current_userdata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends Equatable {
  final String id;
  final String name;
  final String age;
  final String image_0;
  final String image_1;
  final String image_2;
  final String image_3;
  final String image_4;
  final String bio;
  final List<String> interests;

  Profile(
      { required this.id,
        required this.name,
        required this.age,
        required this.image_0,
        required this.image_1,
        required this.image_2,
        required this.image_3,
        required this.image_4,
        required this.bio,
        required this.interests
      }
      );

  @override
  List<Object?> get props => [id, name, age, image_0, bio,image_1,image_2,image_3,image_4];
  static void removeUser(user) {
    users.remove(user);
  }

  static void disliked(dislikedUserId){
    void rememberdislikeduserid()async {
      try {
        final FirebaseAuth auth =
            FirebaseAuth.instance;
        var collection = FirebaseFirestore.instance
            .collection('users');
        final User? user = auth.currentUser;
        await collection
            .doc(user!.uid)
            .update({
          'dislikeduserid': FieldValue.arrayUnion([dislikedUserId])})
            .then((_) => print('Added'))
            .catchError((error) =>
            print('Add failed: $error'));

      }catch (_) {}
    }
    rememberdislikeduserid();
}
  static void liked(likedUserId){
    void rememberlikeduserid()async {
      try {
        final FirebaseAuth auth =
            FirebaseAuth.instance;
        var collection = FirebaseFirestore.instance
            .collection('users');
        final User? user = auth.currentUser;
        await collection
            .doc(user!.uid)
            .update({
          'likeduserid': FieldValue.arrayUnion([likedUserId])})
            .then((_) => print('Added'))
            .catchError((error) =>
            print('Add failed: $error'));

      }catch (_) {}
    }
    rememberlikeduserid();
  }


  static void lijstgen() async{
    final prefs = await SharedPreferences.getInstance();
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshot = await collection
        .get();
    final User? user = auth.currentUser;

    for (var snapshot in querySnapshot.docs) {
      if(prefs.getString('showme')==snapshot.get('gender')|| prefs.getString('showme')=='Everybody'.toString()) {
      // if(SettingsPageState.initItem2.toString()==snapshot.get('gender')|| SettingsPageState.initItem2=='Everybody'.toString()) {
        if (user!.email != snapshot.get('email') &&
            !Current_user_data.disLikedUserIds.contains(snapshot.id) &&
            !Current_user_data.likedUserIds.contains(snapshot.id)) {
          users.add(new Profile(id: snapshot.id,
              name: snapshot.get('name'),
              age: snapshot.get('age'),
              image_0: snapshot.get('image_0'),
              bio: snapshot.get('bio'),
              interests: ['dogs'],
              image_1: snapshot.get('image_1'),
              image_2: snapshot.get('image_2'),
              image_3: snapshot.get('image_3'),
              image_4: snapshot.get('image_4')));
        }
      }
    }
  }
  static void checkempty(){
    const String startImage= 'https:firebasestorage.googleapis.com/v0/b/couply-4b5c9.appspot.com/o/user_1%2Fdata%2Fuser%2F0%2Fcom.example.dating_app_ikfram%2Fcache%2Fimage_picker1544023718157329846.jpg?alt=media&token=e096a6ed-be91-4bc1-be69-9d469433f996';
    if(Profile.users.isEmpty){
      Profile.users.add(Profile(id: "66", name: "Wait for new people", age: "", image_0:startImage, bio: "start", interests: ['dogs'],image_1:startImage, image_2:startImage, image_3: startImage, image_4: startImage));
    }
}
  static List<Profile> users = [
  ];
}
