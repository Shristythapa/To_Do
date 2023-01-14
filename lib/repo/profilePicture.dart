   import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


FirebaseFirestore db = FirebaseFirestore.instance;


   

  File? image;
  String? imageUrl;
  String? imagePath;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage(ImageSource source) async {
    var selected = await _picker.pickImage(source: source, imageQuality: 100);

      if (selected != null) {//if the 
        imageUrl = null;
        print("image selected");
        image = File(selected.path);
        String dt = DateTime.now().millisecondsSinceEpoch.toString();
        Reference storageRef = FirebaseStorage.instance.ref();
        if(imagePath !=null){
          storageRef.child(imagePath!).delete();
        }
        storageRef.child("products").child("$dt.jpg").putFile(File(selected.path)).then((photo) async {
          photo.ref.getDownloadURL().then((url) {
           
              imageUrl = url;
              imagePath = photo.ref.fullPath;
            
          });
        });

      } else {
        print('No image selected.');
      }

  }

