import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_app/global/global.dart';
import 'package:seller_app/mainScreens/home_screen.dart';
import 'package:seller_app/widgets/error_dialog.dart';
import 'package:seller_app/widgets/progress_bar.dart';
import 'package:firebase_storage/firebase_storage.dart' as StorageRef;

class MenusUploadScreen extends StatefulWidget {
  const MenusUploadScreen({Key? key}) : super(key: key);

  @override
  State<MenusUploadScreen> createState() => _MenusUploadScreenState();
}

class _MenusUploadScreenState extends State<MenusUploadScreen> {
  
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool uploading = false;
  String uniqueIdName=DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          "Add New Menu",
          style: TextStyle(fontSize: 30, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const HomeScreen()));
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.cyan,
            Colors.amber,
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shop_two,
                color: Colors.white,
                size: 200.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                onPressed: () {
                  takeImage(context);
                },
                child: const Text(
                  "Add New Menu",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeImage(mContext) async {
    return showDialog(
      context: mContext,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "Select Image",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.cyan,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          children: [
            const Divider(height: 10, color: Colors.grey, thickness: 2),
            SimpleDialogOption(
              onPressed: captureImageWithCamera,
              child: const Text(
                "Camera",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 10, color: Colors.grey, thickness: 2),
            SimpleDialogOption(
              onPressed: pickImageFromGallery,
              child: const Text(
                "Gallery",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(height: 10, color: Colors.grey, thickness: 2),
            SimpleDialogOption(
              child: const Text(
                "Cancel",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  menusUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.cyan,
              Colors.amber,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ),
        title: const Text(
          "Uploading New Menu",
          style: TextStyle(fontSize: 20, fontFamily: "Lobster"),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
           clearMenusUploadForm();
          },
        ),
        actions: [
          TextButton(
            onPressed: uploading ? null : ()=> validateUploadForm(),
            child: const Text(
              "+",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                
              ),
            ),
            
          ),
        ],
      ),
      body:ListView(
       
        children: [
           uploading == true ? LinearProgress() : const Text(""),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                          File(imageXFile!.path)
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const Divider(height: 10, color: Colors.cyan, thickness: 2),
           
           ListTile(
            leading:  const Icon(Icons.perm_device_information, color: Colors.cyan,),
            title: Container(
              width: 250,
               child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: shortInfoController,
                decoration: const InputDecoration(
                  hintText: "menu info",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Divider(height: 10, color: Colors.cyan, thickness: 2),

          ListTile(
            leading:  const Icon(Icons.title, color: Colors.cyan,),
            title: Container(
              width: 250,
               child: TextField(
                style: const TextStyle(color: Colors.black),
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Menu Title",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Divider(height: 10, color: Colors.cyan, thickness: 2),

        ],
      ) ,
  
     
    );
  }

  clearMenusUploadForm()
  {
    setState(() {
    shortInfoController.clear();
    titleController.clear();
    imageXFile=null;
    });
  }

  validateUploadForm() async
  {
    if(imageXFile != null)
    {
      if(shortInfoController.text.isNotEmpty && titleController.text.isNotEmpty)
      {
        setState(() {
          uploading = true;
        });
          //uplload image
        
        String downloadURL = await uploadImage(File(imageXFile!.path));
          //save info to firebase

          saveInfo(downloadURL);
      }
      else
      {
        showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please fill both, title and info fields for menu.",
              
            );
          });
      }
    }
    else
    {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please select an image for menu.",
            );
          });
    }
  }

   saveInfo(String downloadUrl)
  {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");

    ref.doc(uniqueIdName).set({
      "menuID": uniqueIdName,
      "sellerUID": sharedPreferences!.getString("uid"),
      "menuInfo": shortInfoController.text.toString(),
      "menuTitle": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    });

    clearMenusUploadForm();

    setState(() {
      uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });
  }

  uploadImage(mImageFile) async
  {
    StorageRef.Reference reference =StorageRef.FirebaseStorage.instance.ref().child("menus");
    StorageRef.UploadTask uploadTask = reference.child(uniqueIdName+".jpg").putFile(mImageFile);
    StorageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() 
    {

    });
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
    
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : menusUploadFormScreen();
  }
}
