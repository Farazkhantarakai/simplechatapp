import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class TakeImage extends StatefulWidget {
  const TakeImage({Key? key, required this.saveImage}) : super(key: key);

  final Function saveImage;

  @override
  State<TakeImage> createState() => _TakeImageState();
}

class _TakeImageState extends State<TakeImage> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 70,
            backgroundColor: Colors.purple,
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: _image != null ? Image.file(_image!) : null,
            )),
        TextButton.icon(
            onPressed: () async {
              XFile? pickedImage =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              setState(() {
                _image = File(pickedImage!.path);
                widget.saveImage(_image);
              });
            },
            icon: const Icon(Icons.camera),
            label: const Text('Add Image')),
      ],
    );
  }
}
