import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app_ikfram/screens/personal_page.dart';
import 'package:equatable/equatable.dart';
import 'users.dart';
import 'package:dating_app_ikfram/components/current_userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Usermatch extends Equatable {
  final int id;
  final int userId;
  final Profile matchedUser;

  const Usermatch(
      {required this.id, required this.userId, required this.matchedUser});

  @override
  // TODO: implement props
  List<Object?> get props => [id, userId, matchedUser];

  static void addUser(user) {
    matches.add(user);
  }

  static List<Profile> matches = [];
  static List<String> ids=[];


  static void checkUserMatch() async {
    var collection = FirebaseFirestore.instance.collection('users');
    final User? user = auth.currentUser;
    var querySnapshot = await collection
        .get();
    for (var snapshot in querySnapshot.docs) {

      ids=List.from(snapshot.get('likeduserid'));
      
      if (Current_user_data.likedUserIds.contains(snapshot.id)&& ids.contains(user!.uid)) {
        if(!matches.contains(Profile(id: snapshot.id, name: snapshot.get('name'), age: snapshot.get('age'), image_0: snapshot.get('image_0'), bio: snapshot.get('bio'), interests: ['dogs'], image_1: snapshot.get('image_1'),image_2: snapshot.get('image_2'),image_3: snapshot.get('image_3'),image_4: snapshot.get('image_4')))) {
          matches.add(new Profile(id: snapshot.id,
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
}