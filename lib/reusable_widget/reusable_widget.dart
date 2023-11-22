import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/background.jpg',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

Color RandomPastelColor() {
  final random = Random();
  // Buat warna dengan komponen merah, hijau, dan biru yang acak dalam rentang pastel (misalnya, 150-255)
  final red = 150 + random.nextInt(106); // 150-255
  final green = 150 + random.nextInt(106);
  final blue = 150 + random.nextInt(106);

  return Color.fromARGB(255, red, green, blue);
}

Container judulDialog(BuildContext context, String title) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    alignment: Alignment.center,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Color(0XFF00799F),
    ),
    child: Text(
      title,
      style: const TextStyle(
          color: Colors.white,
          fontFamily: 'SansPro',
          fontSize: 20,
          fontWeight: FontWeight.bold),
    ),
  );
}

Container judulmonitoring(BuildContext context, String title) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 40,
    decoration: BoxDecoration(
      color: const Color(0xFF003452),
      borderRadius: BorderRadius.circular(30),
    ),
    alignment: Alignment.center,
    child: Text(
      title,
      style: const TextStyle(
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
          offset: const Offset(2, 3),
        ),
      ],
    ),
    child: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 25),
          child: Text(
            content,
            style: const TextStyle(
              fontFamily: 'SansPro',
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.41,
          height: 28,
          decoration: const BoxDecoration(
            color: Color(0XFF084B72),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
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

Container accountbox(
    BuildContext context, String title, Color warna1, Color warna2, Icon logo) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.42,
    height: MediaQuery.of(context).size.width * 0.42,
    decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(15)),
    child: Center(
      child: Column(
        // alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              //LINGKARAN LUAR
              width: MediaQuery.of(context).size.width * 0.21,
              height: MediaQuery.of(context).size.width * 0.21,
              decoration: BoxDecoration(
                // color: Color(0XFF084B72),
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    warna1,
                    warna2,
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: logo,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'SansPro',
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
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
          offset: const Offset(2, 3),
        ),
      ],
    ),
    child: Stack(
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 25),
          child: Text(
            content,
            style: const TextStyle(
              fontFamily: 'SansPro',
              fontSize: 30,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.435,
          height: 28,
          decoration: const BoxDecoration(
            color: Color(0XFF084B72),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
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

  const pickphoto(
      {super.key, required this.onImageSelected, required this.initialImage});

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
          backgroundColor: const Color(0XFFFFFFFF),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(
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

// class CalendarPicker {
//   DateTime _selectedDate = DateTime.now();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }
// }

class CalendarPicker extends StatefulWidget {
  const CalendarPicker({super.key});

  @override
  State<CalendarPicker> createState() => _CalendarPickerState();
}

class _CalendarPickerState extends State<CalendarPicker> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
