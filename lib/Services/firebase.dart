import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future<void> addBooth(data, String id) async {
    return await FirebaseFirestore.instance
        .collection("booths")
        .doc(id)
        .set(data);
  }

  getBooth() async {
    return FirebaseFirestore.instance.collection("booths").snapshots();
  }

  deleteBooth(String id) async {
    return FirebaseFirestore.instance.collection("booths").doc(id).delete();
  }
}
