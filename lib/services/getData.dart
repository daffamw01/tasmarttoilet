import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class GetData {
  static Stream getUsersPetugas() async* {
    final user = FirebaseAuth.instance.currentUser!;

    final databaseReference = FirebaseDatabase.instance.ref();
    final userRef = databaseReference.child("users").child(user.uid);
    final dataSnapshot = await userRef.once();

    yield dataSnapshot.snapshot.value;
  }

  static Stream getUsers({required String position}) async* {
    final databaseReference = FirebaseDatabase.instance.ref();
    final userRef = databaseReference.child("users");
    final snapshot = await userRef.get();
    // print('dataSnapshot :');
    // print(snapshot);

    final map = snapshot.value as Map<dynamic, dynamic>;
    var data = [];
    for (var value in map.values) {
      if (value['position'] == position) {
        data.add(value);
      }
    }
    ;
    yield data;
  }
}
