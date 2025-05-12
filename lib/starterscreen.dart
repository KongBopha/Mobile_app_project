import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_manager_app/homescreen.dart';

class Starterscreen extends StatefulWidget {
  const Starterscreen({super.key});

  @override
  State<Starterscreen> createState() => _StarterscreenState();
}

class _StarterscreenState extends State<Starterscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager UI'),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/starter.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 138, 89, 198),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,  
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child:Column(
                      children: [
                        const SizedBox(height: 100),
                        const Text(
                          'Building Better\n Workplaces',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Create a unique emotional story that\n describes better than words',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 30),
                             LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                return ElevatedButton(
                                  onPressed: () {
                                    // Navigate to the next screen  
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Homescreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 126, 83, 227),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    minimumSize: Size(constraints.maxWidth, 50), // Make it responsive
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                  child: const Text( 
                                    'Get Started',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
