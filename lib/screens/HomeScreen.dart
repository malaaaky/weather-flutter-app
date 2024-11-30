import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCity = 'London';
  final List<String> cities = ['London', 'Paris', 'Tokyo', 'Sydney', 'New York'];
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("lib/assets/weatherVideo.mp4") // use your video file here
      ..initialize().then((_) {
        setState(() {}); // Update the UI when the video is loaded
      })
      ..setLooping(true)
      ..play(); // Start playing the video in a loop
  }

  // @override
  // void dispose() {
  //   _controller.dispose(); // Dispose the controller when the screen is closed
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Stack(
        children: [
          // Video Background
          if (_controller.value.isInitialized)
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          // Overlay with Weather App UI
          Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to the Weather App!',
                    style: TextStyle(fontSize: 24, color: Colors.black54),
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    value: selectedCity,
                    items: cities.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value!;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/currentWeather', arguments: selectedCity);
                    },
                    child: Text('Current Weather'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forecast', arguments: selectedCity);
                      },
                      child: Text('3-Day Forecast'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Weather App')),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Welcome to the Weather App!', style: TextStyle(fontSize: 24)),
//               SizedBox(height: 20),
//               DropdownButton<String>(
//                 value: selectedCity,
//                 items: cities.map((city) {
//                   return DropdownMenuItem(
//                     value: city,
//                     child: Text(city),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCity = value!;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/currentWeather', arguments: selectedCity);
//                 },
//                 child: Text('Current Weather'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/forecast', arguments: selectedCity);
//                 },
//                 child: Text('3-Day Forecast'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
