import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class userImagePicker extends StatefulWidget {
  const userImagePicker({super.key, required this.onPickImage});
  final void Function(File pickedImage) onPickImage;

  @override
  State<userImagePicker> createState() => _userImagePickerState();
}

class _userImagePickerState extends State<userImagePicker> {
  File? _imagePickedFile;
  void _pickImage() async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 10, maxWidth: 150);

    if (pickedImage == null){
      return;
    } 
    setState(() {
      _imagePickedFile = File(pickedImage.path);
    });

    widget.onPickImage(_imagePickedFile!);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _imagePickedFile !=null ? FileImage(_imagePickedFile!):null  ,
        ),
       TextButton.icon(onPressed: _pickImage, icon: const Icon(Icons.image),
       label: Text("Add Image", style: TextStyle(
        color:  Theme.of(context).colorScheme.primary
       ),))
      ],
    );
  }
}