import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/app_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  File? _image;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    print('image ${_image?.path}');

    final screenSize = MediaQuery.of(context).size;

    return AppScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width / 1.8,
        padding: const EdgeInsets.only(bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 'image',
              onPressed: _getImageFromGallery,
              child: const Icon(Icons.image),
            ),
            FloatingActionButton(
              heroTag: 'camera',
              onPressed: _getImageFromCamera,
              child: const Icon(Icons.camera),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: screenSize.height / 1.8,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: _image == null
                        ? Image.asset(
                            'assets/images/nobody.png',
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: Text('This is a test'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    // カメラから写真を取得する部分
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    print('camera image: ${pickedFile?.path}');
    setState(() {
      if (pickedFile != null) {
        // 写真取得後に_imageを更新して表示している
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _getImageFromGallery() async {
    // カメラから写真を取得する部分
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    print('picked image: ${pickedFile?.path}');
    setState(() {
      if (pickedFile != null) {
        // 写真取得後に_imageを更新して表示している
        _image = File(pickedFile.path);
      }
    });
  }
}
