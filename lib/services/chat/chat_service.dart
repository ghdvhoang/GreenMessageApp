import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_message_app/models/message.dart';

class ChatService {
  // get instance of chat service
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get user streams
  Stream<List<Map<String, dynamic>>> getUserStreams() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  // send message function
  Future<void> sendMessage(String receiverID, String message) async {
    // get current user
    final String currentUserID = _auth.currentUser!.uid;
    final String currentEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();
    // create a new message
    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentEmail,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );
    //construc chatroom ID for 2 users
    List<String> ids = [currentUserID, receiverID];
    ids.sort(); // sort to ensure consistent order
    String chatRoomID = ids.join('_');
    // store message in firestore
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get messages between 2 users
  Stream<QuerySnapshot> getMessages(String userID, String otherUserID) {
    // construct chatroom ID
    List<String> ids = [userID, otherUserID];
    ids.sort(); // sort to ensure consistent order
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}