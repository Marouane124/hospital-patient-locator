import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

class PatientInfo {
  final String id;
  final String username;
  final List<String> roles;

  PatientInfo({
    required this.id,
    required this.username,
    required this.roles,
  });

  factory PatientInfo.fromJson(Map<String, dynamic> json) {
    return PatientInfo(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      roles: (json['roles'] as List<dynamic>?)?.map((role) => 
        (role['name'] ?? '').toString()
      ).toList() ?? [],
    );
  }
}

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool isCameraActive = false;
  bool isProcessing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras![0], 
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420
    );
    await _controller!.initialize();
  }

  void _startCamera() {
    setState(() {
      isCameraActive = true;
    });
    
    Duration processingDelay = Duration(milliseconds: 500);
    DateTime lastProcessingTime = DateTime.now();
    
    _controller!.startImageStream((CameraImage image) async {
      final currentTime = DateTime.now();
      if (!isProcessing && currentTime.difference(lastProcessingTime) > processingDelay) {
        isProcessing = true;
        lastProcessingTime = currentTime;
        await _detectQRCode(image);
        isProcessing = false;
      }
    });
  }

  void _stopCamera() {
    setState(() {
      isCameraActive = false;
    });
    _controller!.stopImageStream();
  }

  Future<void> _detectQRCode(CameraImage image) async {
    try {
      final allBytes = BytesBuilder();
      allBytes.add(image.planes[0].bytes);
      
      final bytes = allBytes.takeBytes();
      final base64Image = base64Encode(bytes);
      
      final response = await http.post(
        Uri.parse('http://192.168.100.99:5002/scan'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'image': 'data:image/jpeg;base64,$base64Image',
          'width': image.width,
          'height': image.height,
          'format': 'yuv420'
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success'] == true && 
            result['results'] != null && 
            result['results'].isNotEmpty &&
            result['results'][0]['user'] != null) {
          final userInfo = PatientInfo.fromJson(result['results'][0]['user']);
          print('Raw user data: ${result['results'][0]['user']}');
          print('Room number: ${result['results'][0]['qr_data']}');
          print('User id: ${userInfo.id}');
          print('Username: ${userInfo.username}');
          print('Roles: ${userInfo.roles}');
        }
      }
    } catch (e, stackTrace) {
      print('Error detecting QR code: $e');
      print('Stack trace: $stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera QR Code Scanner')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isCameraActive)
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: CameraPreview(_controller!),
              ),
            ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: isCameraActive ? _stopCamera : _startCamera,
            child: Text(isCameraActive ? 'Stop Camera' : 'Start Camera'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
} 