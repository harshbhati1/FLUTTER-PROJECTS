import 'dart:io';


import 'package:favourite_places1/models/place.dart';
import 'package:favourite_places1/provider/user_places.dart';
import 'package:favourite_places1/widgets/image_input.dart';
import 'package:favourite_places1/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredTitle = _titleController.text;

    // if (enteredTitle.isEmpty || _selectedImage == null || _selectedLocation == null) {
    //   return;
    // }

     if (enteredTitle.isEmpty || _selectedImage == null || _selectedLocation == null) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle,_selectedImage!,_selectedLocation!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),

            imageInput(onPicked: (image){_selectedImage = image;}),
            const SizedBox(height: 16),

            locationinput(addlocation: (location){_selectedLocation = location;},),

            const SizedBox(height: 16),
            
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}