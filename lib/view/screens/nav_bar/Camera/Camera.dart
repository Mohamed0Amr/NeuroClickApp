import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> with WidgetsBindingObserver {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    loadCamera();
    loadModel();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    cameraController?.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      loadCamera();
    }
  }

  Future<void> loadCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      print('No cameras available');
      return;
    }

    final frontCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    await cameraController!.initialize();

    if (!mounted) {
      return;
    }
    setState(() {
      cameraController!.startImageStream((imageStream) {
        if (!isProcessing) {
          cameraImage = imageStream;
          runModel();
        }
      });
    });
  }

  Future<void> runModel() async {
    if (cameraImage != null && !isProcessing) {
      setState(() {
        isProcessing = true;
      });

      var predictions;
      try {
        predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) => plane.bytes).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true,
        );
      } catch (e) {
        print('Error running model: $e');
        if (mounted) {
          setState(() {
            isProcessing = false;
          });
        }
        return;
      }

      if (predictions != null && predictions.isNotEmpty && mounted) {
        setState(() {
          output = predictions.first['label'];
        });
      }

      if (mounted) {
        setState(() {
          isProcessing = false;
        });
      }
    }
  }

  Future<void> loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model/model.tflite",
        labels: "assets/model/labels.txt",
      );
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(50),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: cameraController == null || !cameraController!.value.isInitialized
                  ? Center(child: CircularProgressIndicator())
                  : AspectRatio(
                aspectRatio: cameraController!.value.aspectRatio,
                child: CameraPreview(cameraController!),
              ),
            ),
          ),
          Text(
            output,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
