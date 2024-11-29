import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/views/audio_screen/audio_view.dart';

class CameraView extends StatefulWidget {
  final bool multiple;

  const CameraView({
    super.key,
    this.multiple = false,
  });

  @override
  CameraViewState createState() => CameraViewState();
}

class CameraViewState extends State<CameraView> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  Timer? _recordingTimer;
  String? recordedAudioPath;
  Timer? _pictureTimer;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _startPictureCapture();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      final firstCamera = cameras.first;

      _controller = CameraController(firstCamera, ResolutionPreset.max,
          enableAudio: false);

      _initializeControllerFuture = _controller!.initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
      }).catchError((e) {
        debugPrint("Error initializing camera: $e");
      });
    } else {
      debugPrint("No cameras available");
    }
  }

  void _startPictureCapture() {
    Future.delayed(const Duration(seconds: 2), () {
      _takePicture();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _recordingTimer?.cancel();
    _pictureTimer?.cancel();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_initializeControllerFuture != null) {
      await _initializeControllerFuture;
      try {
        final XFile image = await _controller!.takePicture();

        final uploadedData = await ApiService().uploadImage(File(image.path));

        if (uploadedData != null) {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AudioSymbolView(
                  audioPath: uploadedData,
                ),
              ),
            );
          }
        } else {
          if (mounted) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Failed to upload image'),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          Navigator.pop(context);
          debugPrint('Error capturing or uploading image: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error capturing or uploading image: $e'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.black,
          appBar: _buildAppBar(),
          body: _buildBody(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: const SizedBox.shrink(),
      forceMaterialTransparency: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            _controller != null) {
          return _buildCameraPreview(context);
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Camera initialization failed: ${snapshot.error}",
              style: const TextStyle(color: Colors.white),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
      },
    );
  }

  Widget _buildCameraPreview(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: size.height,
          width: size.width,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: size.width,
              child: CameraPreview(_controller!),
            ),
          ),
        ),
      ],
    );
  }
}
