import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';



class ResultScreen extends StatefulWidget {
  final String equationText;

  const ResultScreen({Key? key, required this.equationText}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Map<String, dynamic> responseMap;
  List<SavedAnswer> savedAnswers = [];
  final listViewKey = GlobalKey();
   bool isLoading = true;
  bool isResponseSuccessful = false;

  @override
 void initState() {
    super.initState();
    balanceEquation(widget.equationText); // Include this call if you're making an API call
    loadSavedAnswers(); // This was in your second initState
  }

 List<String> apiKeys = [
    'KEHLLQ-7XA5GXHERW',
    '57EP37-99YWW8H6TP',
    '6TG6WK-79YWKA2JPK',
    'H4V25U-U2599Q9H9K',
    '44KY66-A6AUHYLYYR',
    '32EPPL-ATE3377G4L',
    'EG3H2J-YELALYYTJ6',
    '5GXY55-6E9YJ9JLRX',
    '8H4LPR-WP84WG2QKL',
    '95XJY7-TV65EU2HR7',
    '6PRE7V-E6VAVWWG9L',
    '7R83J2-3J543A677L',
    'TGE3H8-WRKPH89E49',
    'H9R74W-563PV7Y2YU',
    '44QR4V-GR7YXUUV84',
    'UK22A3-66V32YH8J3',
    'H63LX2-86AG3R9H58',
    'LR9V44-V5A6TR87A9',
    'P2UWA5-QTVYU2L2TQ',
    'WE9TJW-Y57X8U82KE',
  ];

  String getRandomApiKey() {
    // Shuffle the list of API keys
    apiKeys.shuffle();
    // Return the first key from the shuffled list
    return apiKeys.first;
  }
  Future<void> balanceEquation(String equationText) async {
    final apiKey = getRandomApiKey();
    final query = equationText.replaceAll('+', 'plus'); // URL encode spaces

    try {
      final url = Uri.parse(
        'http://api.wolframalpha.com/v2/query?appid=$apiKey&input=$query&output=json&podstate=Step-by-step+solution&podstate=Step-by-step&podstate=Show+all+steps');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          responseMap = json.decode(response.body);
          isLoading = false;
          isResponseSuccessful = true;
        });
      } else {
        setState(() {
          isLoading = false;
          isResponseSuccessful = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isResponseSuccessful = false;
      });
    }
  }
  void showDownloadSuccessMessage() {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: Color(0xFF5ECA29),
      content: Center(
        child: Text(
          'Download Successfully',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      duration: Duration(seconds: 1),
    ),
  );
}
void captureAndSaveScreenshot() async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: Color(0xFF5ECA29),
      content: Center(child: Text('Download Start', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      duration: Duration(seconds: 4),
    ),
  );

  // Capture a screenshot of the current screen
  final image = await captureScreenshot();

  // Extract the result from the response
  String result = '';
  List<dynamic> pods = responseMap['queryresult']['pods'] as List<dynamic>;
  for (var pod in pods) {
    if (pod['title'] == 'Result') {
      result = pod['subpods'][0]['plaintext'];
      break;
    }
  }

  // Print the extracted result for debugging
  print('Extracted result: $result');

  // Create a SavedAnswer object with the captured image and the result as the title
  final savedAnswer = SavedAnswer(
    title: widget.equationText,
    content: 'Content', // Replace with the actual content
    image: image,
  );

  // Add the saved answer to the list
  setState(() {
    savedAnswers.add(savedAnswer);
  });

  // Save the updated list of saved answers to SharedPreferences
  saveSavedAnswers();

  showDownloadSuccessMessage();
}


  Future<Uint8List> captureScreenshot() async {
    try {
      // Capture a screenshot of the ListView.builder content
      final RenderRepaintBoundary boundary = listViewKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final Uint8List screenshotBytes = byteData!.buffer.asUint8List();
      return screenshotBytes;
    } catch (e) {
      return Uint8List(0);
    }
  }

  // Load saved answers from SharedPreferences
  Future<void> loadSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnswersJson = prefs.getStringList('savedAnswers');
    if (savedAnswersJson != null) {
      setState(() {
        savedAnswers = savedAnswersJson.map((jsonString) => SavedAnswer.fromJson(json.decode(jsonString))).toList();
      });
    }
  }

  // Save saved answers to SharedPreferences
  Future<void> saveSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnswersJson = savedAnswers.map((savedAnswer) => json.encode(savedAnswer.toJson())).toList();
    prefs.setStringList('savedAnswers', savedAnswersJson);
  }

@override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
          appBar: PreferredSize(preferredSize: const Size.fromHeight(70.0),child: 
    AppBar(
      
      backgroundColor: Colors.white,
       bottom: PreferredSize(
        preferredSize: const Size.fromHeight(8.0), // Adjust the height as needed
        child: Container(
    color: Colors.grey.shade300, // Set the desired bottom color
    height:1, // Adjust the height as needed
        ),
      ),
      leading: InkWell(
          onTap: () {
            Navigator.pop(
              context,
              
            );
          },
          child: Center(
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF5ECA29),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
         
      centerTitle: true,
     title: const Text(
          'Result',
          style: TextStyle(color: Color(0xFF252525), fontWeight: FontWeight.w500),
        ),
    actions: [
      Container(
          height: 40,
          width: 40,margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: const Color(0xFF5ECA29),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: captureAndSaveScreenshot,
            iconSize: 40, // Set the icon size to 45
            icon: Image.asset(
      'images/Logo/Black/Download.png',
             
      height: 50,
      width: 50,
       fit: BoxFit.fitWidth,
            ),
          ),
      ),
    ],
    
    ),

     ),

        body: const Center(child: CircularProgressIndicator(
          color: Color(0xFF5ECA29),
          backgroundColor: Colors.white,
        )),
      );
    } else if (isResponseSuccessful) {
      return buildSuccessScreen();
    } else {
      return const Scaffold(
        body: Center(child: Text('Failed to balance the equation')),
      );
    }
  }

  Widget buildSuccessScreen() {
    // Extract the pods from the response
    List<dynamic> pods = responseMap['queryresult']['pods'] as List<dynamic>;

    return Scaffold(
       appBar: PreferredSize(preferredSize: const Size.fromHeight(70.0),child: 
    AppBar(
      
      backgroundColor: Colors.white,
       bottom: PreferredSize(
        preferredSize: const Size.fromHeight(8.0), // Adjust the height as needed
        child: Container(
    color: Colors.grey.shade300, // Set the desired bottom color
    height:1, // Adjust the height as needed
        ),
      ),
      leading: InkWell(
          onTap: () {
            Navigator.pop(
              context,
              
            );
          },
          child: Center(
            child: Container(
              height: 40,
              width: 40,
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: const Color(0xFF5ECA29),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
         
      centerTitle: true,
     title: const Text(
          'Result',
          style: TextStyle(color: Color(0xFF252525), fontWeight: FontWeight.w500),
        ),
    actions: [
      Container(
          height: 40,
          width: 40,margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            color: const Color(0xFF5ECA29),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            onPressed: captureAndSaveScreenshot,
            iconSize: 40, // Set the icon size to 45
            icon: Image.asset(
      'images/Logo/Black/Download.png',
             
      height: 50,
      width: 50,
       fit: BoxFit.fitWidth,
            ),
          ),
      ),
    ],
    
    ),

     ),

      
      body: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(
              key: listViewKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  itemCount: pods.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var pod = pods[index];
                    return buildPod(pod); // Implement buildPod method to build each pod
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPod(dynamic pod) {
    // Implementation of pod building logic
    // Example:
     return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 0),
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F4),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              pod['title'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.white,        borderRadius: BorderRadius.circular(10.0),
),
            padding: const EdgeInsets.all(10),
            child: Container(
            // Adjust the height dynamically
              color: Colors.white,
              child: Center(
                child: Image.network(
                              pod['subpods'][0]['img']['src'],
                              fit: BoxFit.contain,
                             
                            ),
              ),
              // child: SingleChildScrollView(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
                    
              //       if (pod['subpods'][0]['img'] != null)
              //         ...pod['subpods'].map<Widget>((subpod) {
              //           if (subpod['img'] != null) {
              //             return ;
              //           } else {
              //             return SizedBox.shrink();
              //           }
              //         }).toList(),
              //     ],
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
 
  }
}



class SavedAnswer {
  final String title;
  final String content;
  final Uint8List image;

  SavedAnswer({
    required this.title,
    required this.content,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'image': image,
    };
  }

  factory SavedAnswer.fromJson(Map<String, dynamic> json) {
    return SavedAnswer(
      title: json['title'],
      content: json['content'],
      image: Uint8List.fromList(json['image'].cast<int>()),
    );
  }
}

class SavedAnswersScreen extends StatefulWidget {
  final List<SavedAnswer> savedAnswers;

  const SavedAnswersScreen({Key? key, required this.savedAnswers})
      : super(key: key);

  @override
  _SavedAnswersScreenState createState() => _SavedAnswersScreenState();
}

class _SavedAnswersScreenState extends State<SavedAnswersScreen> {
    late Future<List<SavedAnswer>> _savedAnswersFuture;
 // Change this line
   @override
  void initState() {
    super.initState();
    _savedAnswersFuture = loadSavedAnswers();
  }

  Future<List<SavedAnswer>> loadSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnswersJson = prefs.getStringList('savedAnswers');
    if (savedAnswersJson != null) {
      return savedAnswersJson.map((jsonString) => SavedAnswer.fromJson(json.decode(jsonString))).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(preferredSize: const Size.fromHeight(70.0),child: 
    AppBar(
      backgroundColor: Colors.white,
       bottom: PreferredSize(
        preferredSize: const Size.fromHeight(8.0), // Adjust the height as needed
        child: Container(
    color: Colors.grey.shade300, // Set the desired bottom color
    height:1, // Adjust the height as needed
        ),
      ),
     leading: InkWell(
          onTap: () {
            Navigator.pop(
              context,
              );
          },
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF5ECA29),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
         
      centerTitle: true,
     title: const Text(
          'Saved Answers',
          style: TextStyle(color: Color(0xFF252525), fontWeight: FontWeight.w500),
        ),
     actions: <Widget>[
           Center(
             child: Container(
                     height: 40,
                       width: 40,
                       margin: const EdgeInsets.only(right: 15),
             // Equal margin on all sides
                       decoration: BoxDecoration(
              color: const Color(0xFF5ECA29),
              borderRadius: BorderRadius.circular(10),
                       ),
                     child: IconButton(
                       // iconSize: 25.0,
                       icon: Image.asset('images/Logo/Black/Coffee.png',height: 30,width: 30,fit: BoxFit.fitWidth,),
                       onPressed: () {
              _launchLink('https://www.buymeacoffee.com/codebuildersapps');
                       },
                     ),
                   ),
           ),
    
        ],
      
    ),

     ),


    
      body: FutureBuilder<List<SavedAnswer>>(
        future: _savedAnswersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF5ECA29),
                backgroundColor: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading saved answers'),
            );
          } else if (snapshot.hasData) {
            final savedAnswers = snapshot.data;
            return savedAnswers!.isEmpty
                ? Center(
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 200,
                  ),
                  IconButton(
                    
          iconSize: 60,
                 icon: Image.asset('images/Logo/Black/docsPNG.png',fit: BoxFit.fill,
                 height: 70,
                 width: 70,
                 ),
                 onPressed: () {},
               ),
               
                  const SizedBox(height: 10),
                  const Text('Nothing saved yet!',
                      style: TextStyle(fontSize: 22, color: Colors.black54)),
                  const Text('Start solving Problems',
                      style: TextStyle(fontSize: 16, color: Color(0xFF5ECA29))),
                ],
              ),
            

                  )
                : ListView.builder(
                    itemCount: savedAnswers.length,
                    itemBuilder: (context, index) {
                      final savedAnswer = savedAnswers[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SavedAnswerDetailScreen(savedAnswer: savedAnswer),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                        margin: const EdgeInsets.only(left: 15,right: 15),
                         height: 60,
                         decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                           color: const Color(0xFFF1F4F4),
                         ),
                         
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  savedAnswer.title,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                        IconButton(
    icon: Image.asset(
      'images/Logo/Black/pdfPNG.png',
      fit: BoxFit.fill,
      height: 30,
      width: 30,
    ),
    onPressed: () async {
      // Remove the saved answer from the list
      // final updatedSavedAnswers = List<SavedAnswer>.from(await _savedAnswersFuture);
      // updatedSavedAnswers.removeAt(index);

      // // Update the _savedAnswersFuture with the modified list
      // setState(() {
      //   _savedAnswersFuture = Future.value(updatedSavedAnswers);
      // });

      // // Save the updated list to SharedPreferences
      // saveSavedAnswers(updatedSavedAnswers);
    },
  ), 
                            ],
                          ),
                        ),
                      ),
                  
                          ],
                        ),
                      );
                    },
                  );
          } else {
            return const Center(
              child: Text('No saved answers found'),
            );
          }
        },
      ),
    );
              
            
    
  }

  Future<void> saveSavedAnswers(List<SavedAnswer> savedAnswers) async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnswersJson = savedAnswers
        .map((savedAnswer) => json.encode(savedAnswer.toJson()))
        .toList();
    prefs.setStringList('savedAnswers', savedAnswersJson);
  }
    _launchLink(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }
}


class SavedAnswerDetailScreen extends StatelessWidget {
  final SavedAnswer savedAnswer;
  
  const SavedAnswerDetailScreen({Key? key, required this.savedAnswer})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: PreferredSize(preferredSize: const Size.fromHeight(70.0),child: 
    AppBar(
      backgroundColor: Colors.white,
       bottom: PreferredSize(
        preferredSize: const Size.fromHeight(8.0), // Adjust the height as needed
        child: Container(
    color: Colors.grey.shade300, // Set the desired bottom color
    height:1, // Adjust the height as needed
        ),
      ),
     leading: InkWell(
          onTap: () {
            Navigator.pop(
              context,
              );
          },
          child: Center(
            child: Container(
                margin: const EdgeInsets.only(left: 15),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF5ECA29),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
         
      centerTitle: true,
     title: const Text(
          'Saved Answers',
          style: TextStyle(color: Color(0xFF252525), fontWeight: FontWeight.w500),
        ),
     actions: <Widget>[
           Center(
             child: Container(
                     height: 40,
                       width: 40,
                       margin: const EdgeInsets.only(right: 15),
             // Equal margin on all sides
                       decoration: BoxDecoration(
              color: const Color(0xFF5ECA29),
              borderRadius: BorderRadius.circular(10),
                       ),
                     child: IconButton(
                       // iconSize: 25.0,
                       icon: Image.asset('images/Logo/Black/Coffee.png',height: 30,width: 30,fit: BoxFit.fitWidth,),
                       onPressed: () {
              _launchLink('https://www.buymeacoffee.com/codebuildersapps');
                       },
                     ),
                   ),
           ),
    
        ],
      
    ),

     ),


      
backgroundColor: Colors.white,
     body: PhotoView(
        imageProvider: MemoryImage(savedAnswer.image),
        minScale: PhotoViewComputedScale.contained * 2,
        maxScale: PhotoViewComputedScale.covered * 2,
        initialScale: PhotoViewComputedScale.covered,
        backgroundDecoration: const BoxDecoration(
          color: Colors.white, // Set your desired background color
        ),
        loadingBuilder: (BuildContext context, ImageChunkEvent? event) {
          if (event == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF5ECA29),
                backgroundColor: Colors.white,
              ),
            );
          } else {
            final progress = event.expectedTotalBytes != null
                ? event.cumulativeBytesLoaded / event.expectedTotalBytes!
                : null;
            return Center(
              child: CircularProgressIndicator(
                value: progress,
              ),
            );
          }
        },
      ),
    );
  }
     _launchLink(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }
 
}
