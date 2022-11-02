import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_ikfram/screens/settings_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dating_app_ikfram/screens/personal_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Current_user_data {
  static late String showme;
  static late String bio;
  static late String username;
  static late String image_0; // geen array mogelijk ivm firebase
  static late String image_1;
  static late String image_2;
  static late String image_3;
  static late String image_4;

  static List<String> disLikedUserIds=[];
  static List<String> likedUserIds=[];

  static void getCurrentUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    var collection =
    FirebaseFirestore.instance.collection('users').doc(user!.uid);
    var querySnapshot = await collection.get();
    disLikedUserIds= List.from(querySnapshot.get('dislikeduserid'));            // lijst van alle disliked users
    likedUserIds=List.from((querySnapshot.get('likeduserid')));                 // lijst van alle likedusers
    bio = querySnapshot.get('bio');                                           // opahlen bio
    // SettingsPageState.initItem2= querySnapshot.get('showme');                   // ophalen wie je wilt zien
    SettingsPageState.Showme=prefs.getString('showme');                // ophalen wie je wilt zien
    username = querySnapshot.get('name');                                       // ophalen gebruikersnaam
    image_0= querySnapshot.get('image_0');                                      // ophalen eerste afbeelding
    image_1= querySnapshot.get('image_1');
    image_2= querySnapshot.get('image_2');
    image_3= querySnapshot.get('image_3');
    image_4= querySnapshot.get('image_4');
    if(PersonalPageState.images.isEmpty) {                                  // voor als je meerder keren naar profile gaat, dan hoef komen er niet oneindig fotos in die list.
      PersonalPageState.images.add(image_0);
      PersonalPageState.images.add(image_1);
      PersonalPageState.images.add(image_2);
      PersonalPageState.images.add(image_3);
      PersonalPageState.images.add(image_4);
    }
  }
}
