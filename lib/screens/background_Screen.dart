import 'package:flutter/material.dart';
import 'package:flutter_blue_plus_example/screens/scan_screen.dart';

class BackgroundImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.only(top:240.0, left: 40,),
              child: Image(image: AssetImage('assets/images/render_studio_light.png'),),
            ),
          ),
          // Bottom sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(64), // Set border radius for rounded edges
              child: Container(
                color: Color.fromRGBO(30, 30, 30, .48), // Change background color of the container
                height: 60, // Set height of the container
                padding: EdgeInsets.symmetric(horizontal: 20), // Add padding to the container
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40.0),
                        child: Image.asset(
                          'assets/images/branding.png', // Path to your image asset
                          height: 80, // Set the height of the image
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:90.0, right: 90.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.withOpacity(.2), // Change background color of the ElevatedButton
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15), // Set border radius to 0 for less rounding
                            ),
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Adjust padding
                 
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ScanScreen()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600, // Set text to bold
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
