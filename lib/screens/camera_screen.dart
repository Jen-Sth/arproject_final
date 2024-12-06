/*1st correct
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller; // Make it nullable
  Future<void>? _initializeControllerFuture; // Make it nullable
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    // Initialize the camera
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      // Get a list of the available cameras on the device.
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        // Select the first camera (usually the back camera).
        _controller = CameraController(
          cameras![0],
          ResolutionPreset.high,
        );

        // Initialize the controller. This returns a Future.
        _initializeControllerFuture = _controller!.initialize();
        setState(() {}); // Update the state to reflect the initialization
      } else {
        // Handle the case where no cameras are available
        print("No cameras available");
      }
    } catch (e) {
      // Handle any errors that occur during initialization
      print("Error initializing camera: $e");
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller!);
          } else if (snapshot.hasError) {
            // If there was an error, display it.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}*/


/*2nd correct
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller; // Make it nullable
  Future<void>? _initializeControllerFuture; // Make it nullable
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    // Initialize the camera
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      // Get a list of the available cameras on the device.
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        // Select the first camera (usually the back camera).
        _controller = CameraController(
          cameras![0],
          ResolutionPreset.high,
        );

        // Initialize the controller. This returns a Future.
        _initializeControllerFuture = _controller!.initialize();
        setState(() {}); // Update the state to reflect the initialization
      } else {
        // Handle the case where no cameras are available
        print("No cameras available");
      }
    } catch (e) {
      // Handle any errors that occur during initialization
      print("Error initializing camera: $e");
    }
  }

  Future<void> _takePicture() async {
    try {
      // Ensure that the camera is initialized
      await _initializeControllerFuture;

      // Construct a file path to store the image
      final image = await _controller!.takePicture();

      // You can use the image.path to display or save the image
      print('Picture saved to: ${image.path}');
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: [
                CameraPreview(_controller!),
                Positioned(
                  bottom: 20,
                  left: MediaQuery.of(context).size.width / 2 - 30,
                  child: FloatingActionButton(
                    onPressed: _takePicture,
                    child: Icon(Icons.camera),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            // If there was an error, display it.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller; // Make it nullable
  Future<void>? _initializeControllerFuture; // Make it nullable
  List<CameraDescription>? cameras;
  bool _isTakingPicture = false; // State variable for black screen overlay

  @override
  void initState() {
    super.initState();
    // Initialize the camera
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    try {
      // Get a list of the available cameras on the device.
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        // Select the first camera (usually the back camera).
        _controller = CameraController(
          cameras![0],
          ResolutionPreset.high,
        );

        // Initialize the controller. This returns a Future.
        _initializeControllerFuture = _controller!.initialize();
        setState(() {}); // Update the state to reflect the initialization
      } else {
        // Handle the case where no cameras are available
        print("No cameras available");
      }
    } catch (e) {
      // Handle any errors that occur during initialization
      print("Error initializing camera: $e");
    }
  }

  Future<void> _takePicture() async {
    try {
      // Ensure that the camera is initialized
      await _initializeControllerFuture;

      // Set the state to show the black overlay
      setState(() {
        _isTakingPicture = true;
      });

      // Construct a file path to store the image
      final image = await _controller!.takePicture();

      // You can use the image.path to display or save the image
      print('Picture saved to: ${image.path}');

      // Delay for a moment to show the black screen effect
      await Future.delayed(Duration(seconds: 1));

      // Reset the state to hide the black overlay
      setState(() {
        _isTakingPicture = false;
      });
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              children: [
                CameraPreview(_controller!),
                if (_isTakingPicture) // Show black overlay if taking picture
                  Container(
                    color: Colors.black,
                    child: Center(child: CircularProgressIndicator()), // Optional loading indicator
                  ),
                Positioned(
                  bottom: 20,
                  left: MediaQuery.of(context).size.width / 2 - 30,
                  child: FloatingActionButton(
                    onPressed: _takePicture,
                    child: Icon(Icons.camera),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            // If there was an error, display it.
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}