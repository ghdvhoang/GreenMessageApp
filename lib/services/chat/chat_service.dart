import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {

  // get instance of chat service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // get user streams
  Stream<List<Map<String, dynamic>>> getUserStreams() {
    return _firestore.collection('Users').snapshots().map((snapshot){
          return snapshot.docs.map((doc) {
            // go through each individual user
            final user = doc.data();

            return user;
        }).toList();     
    });
  }
  // send message function

  // receive message function
}
