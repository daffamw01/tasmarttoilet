import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Container judulmonitoring(BuildContext context, String title) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 40,
    decoration: BoxDecoration(
      color: Color(0xFF003452),
      borderRadius: BorderRadius.circular(30),
    ),
    alignment: Alignment.center,
    child: Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontFamily: 'SansPro',
        color: Colors.white,
      ),
    ),
  );
}

Container monitoringbox1(BuildContext context, String title, String content) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.41,
    height: 75,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(2, 3),
        ),
      ],
    ),
    child: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 25),
          child: Text(
            content,
            style: TextStyle(
              fontFamily: 'SansPro',
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.41,
          height: 28,
          decoration: BoxDecoration(
            color: Color(0XFF084B72),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'SansPro',
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        // Container(
        //   width: 160,
        //   height: 28,
        //   decoration: BoxDecoration(
        //     color: Color(0XFF084B72),
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(20.0),
        //       topRight: Radius.circular(20.0),
        //     ),
        //   ),
        //   alignment: Alignment.center,
        //   child: Text(
        //     'Suhu Ruang',
        //     style: TextStyle(
        //       fontFamily: 'SansPro',
        //       fontSize: 14,
        //       color: Colors.white,
        //     ),
        //   ),
        // )
      ],
    ),
  );
}

Container monitoringbox2(BuildContext context, String title, String content) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.435,
    height: 75,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 3,
          offset: Offset(2, 3),
        ),
      ],
    ),
    child: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 25),
          child: Text(
            content,
            style: TextStyle(
              fontFamily: 'SansPro',
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.435,
          height: 28,
          decoration: BoxDecoration(
            color: Color(0XFF084B72),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'SansPro',
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}

class pickphoto extends StatefulWidget {
  final Function(File?) onImageSelected;
  final AssetImage initialImage;
  // const pickphoto({super.key});

  pickphoto({required this.onImageSelected, required this.initialImage});

  @override
  State<pickphoto> createState() => _pickphotoState();
}

class _pickphotoState extends State<pickphoto> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        widget.onImageSelected(_imageFile!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Color(0XFFFFFFFF),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _imageFile != null
                        ? FileImage(_imageFile!) as ImageProvider
                        : widget.initialImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _pickImage();
                },
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// Future ProfileDialog(BuildContext context, String title, String content) {
  
  
// }