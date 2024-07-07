import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:equationbalancer2/resuls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';

class Element {
  final String name;
  final String symbol;
  final Color color;

  Element(this.name, this.symbol, this.color);
}

List<Element> periodicElements = [
  Element('Hydrogen', 'H', const Color(0xFFF85C4C)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('Helium', 'He', const Color(0xFFB384FF)),
  // Element('Lithium', 'Li', Colors.red),
  // Element('Beryllium', 'Be', Colors.green),
  // Element('Boron', 'B', Colors.purple),
  // Element('Carbon', 'C', Colors.black),
  // Element('Nitrogen', 'N', Colors.blue),
  // Element('Oxygen', 'O', Colors.red),
  // Element('Fluorine', 'F', Colors.green),
  // Element('Neon', 'Ne', Colors.yellow),
  // Add more elements here...
];

List<Element> periodicElements2 = [
  Element('lithium', 'Li', const Color(0xFFEB72B9)),
  Element('beryllium', 'Be', const Color(0xFF0EEFBF)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('Boron', 'B', const Color(0xFFF3821F)),
  Element('Carbon', 'C', const Color(0xFFF85C4C)),
  Element('Nitrogen', 'N', const Color(0xFFF85C4C)),
  Element('Oxygen', 'O', const Color(0xFFF85C4C)),
  Element('flurine', 'F', const Color(0xFFDCCE98)),
  Element('neon', 'Ne', const Color(0xFFB384FF)),
];

List<Element> periodicElements3 = [
  Element('sodium', 'Na', const Color(0xFFEB72B9)),
  Element('magnesium', 'Mg', const Color(0xFF0EEFBF)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('aluminium', 'Al', const Color(0xFFCDEB8B)),
  Element('silicon', 'Si', const Color(0xFFF3821F)),
  Element('phosphuros', 'P', const Color(0xFFF85C4C)),
  Element('sulfer', 'S', const Color(0xFFF85C4C)),
  Element('chlorine', 'Cl', const Color(0xFFDCCE98)),
  Element('argone', 'Ar', const Color(0xFFB384FF)),
];

List<Element> periodicElements4 = [
  Element('potassium', 'K', const Color(0xFFEB72B9)),
  Element('calcium', 'Ca', const Color(0xFF0EEFBF)),
  Element('Scandium', 'Sc', const Color(0xFFFDBD33)),
  Element('titanium', 'Ti', const Color(0xFFFDBD33)),
  Element('vanadium', 'V', const Color(0xFFFDBD33)),
  Element('chromium', 'Cr', const Color(0xFFFDBD33)),
  Element('manganese', 'Mn', const Color(0xFFFDBD33)),
  Element('iron', 'Fe', const Color(0xFFFDBD33)),
  Element('cobalt', 'Co', const Color(0xFFFDBD33)),
  Element('nickel', 'Ni', const Color(0xFFFDBD33)),
  Element('copper', 'Cu', const Color(0xFFFDBD33)),
  Element('Zinc', 'Zn', const Color(0xFFFDBD33)),
  Element('gallium', 'Ga', const Color(0xFFCDEB8B)),
  Element('germinium', 'Ge', const Color(0xFFF3821F)),
  Element('arsenic', 'As', const Color(0xFFF3821F)),
  Element('selenium', 'Se', const Color(0xFFF85C4C)),
  Element('bromine', 'Br', const Color(0xFFDCCE98)),
  Element('krypton', 'Kr', const Color(0xFFB384FF)),
];

List<Element> periodicElements5 = [
  Element('rubdium', 'Rb', const Color(0xFFEB72B9)),
  Element('strontium', 'Sr', const Color(0xFF0EEFBF)),
  Element('yttrium', 'Y', const Color(0xFFFDBD33)),
  Element('zirconium', 'Zr', const Color(0xFFFDBD33)),
  Element('niobium', 'Nb', const Color(0xFFFDBD33)),
  Element('molybdeum', 'Mo', const Color(0xFFFDBD33)),
  Element('manganese', 'Tc', const Color(0xFFFDBD33)),
  Element('iron', 'Ru', const Color(0xFFFDBD33)),
  Element('cobalt', 'Rh', const Color(0xFFFDBD33)),
  Element('nickel', 'Pd', const Color(0xFFFDBD33)),
  Element('copper', 'Ag', const Color(0xFFFDBD33)),
  Element('Zinc', 'Cd', const Color(0xFFFDBD33)),
  Element('gallium', 'In', const Color(0xFFCDEB8B)),
  Element('germinium', 'Sn', const Color(0xFFCDEB8B)),
  Element('arsenic', 'Sb', const Color(0xFFF3821F)),
  Element('selenium', 'Te', const Color(0xFFF3821F)),
  Element('bromine', 'I', const Color(0xFFDCCE98)),
  Element('krypton', 'Xe', const Color(0xFFB384FF)),
];

List<Element> periodicElements6 = [
  Element('rubdium', 'Cs', const Color(0xFFEB72B9)),
  Element('strontium', 'Ba', const Color(0xFF0EEFBF)),
  Element('yttrium', '', Colors.white),
  Element('zirconium', 'Hf', const Color(0xFFFDBD33)),
  Element('niobium', 'Ta', const Color(0xFFFDBD33)),
  Element('molybdeum', 'W', const Color(0xFFFDBD33)),
  Element('manganese', 'Re', const Color(0xFFFDBD33)),
  Element('iron', 'Os', const Color(0xFFFDBD33)),
  Element('cobalt', 'Ir', const Color(0xFFFDBD33)),
  Element('nickel', 'Pt', const Color(0xFFFDBD33)),
  Element('copper', 'Au', const Color(0xFFFDBD33)),
  Element('Zinc', 'Hg', const Color(0xFFFDBD33)),
  Element('gallium', 'Tl', const Color(0xFFCDEB8B)),
  Element('germinium', 'Pb', const Color(0xFFCDEB8B)),
  Element('arsenic', 'Bi', const Color(0xFFCDEB8B)),
  Element('selenium', 'Po', const Color(0xFFF3821F)),
  Element('bromine', 'At', const Color(0xFFDCCE98)),
  Element('krypton', 'Rn', const Color(0xFFB384FF)),
];

List<Element> periodicElements7 = [
  Element('rubdium', 'Fr', const Color(0xFFEB72B9)),
  Element('strontium', 'Ra', const Color(0xFF0EEFBF)),
  Element('yttrium', '', Colors.white),
  Element('zirconium', 'Rf', const Color(0xFFFDBD33)),
  Element('niobium', 'Db', const Color(0xFFFDBD33)),
  Element('molybdeum', 'Sg', const Color(0xFFFDBD33)),
  Element('manganese', 'Bh', const Color(0xFFFDBD33)),
  Element('iron', 'Hs', const Color(0xFFFDBD33)),
  Element('cobalt', 'Mt', const Color(0xFFFDBD33)),
  Element('nickel', 'Ds', const Color(0xFFFDBD33)),
  Element('copper', 'Rg', const Color(0xFFFDBD33)),
  Element('Zinc', 'Cn', const Color(0xFFFDBD33)),
  Element('gallium', 'Nh', const Color(0xFF83F36B)),
  Element('germinium', 'Fl', const Color(0xFF83F36B)),
  Element('arsenic', 'Mc', const Color(0xFF83F36B)),
  Element('selenium', 'Lv', const Color(0xFF83F36B)),
  Element('bromine', 'Ts', const Color(0xFF83F36B)),
  Element('krypton', 'Og', const Color(0xFF83F36B)),
];

List<Element> periodicElements8 = [
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('yttrium', 'La', const Color(0xFF33C9FE)),
  Element('rubdium', 'Ce', const Color(0xFF33C9FE)),
  Element('strontium', 'Pr', const Color(0xFF33C9FE)),
  Element('yttrium', 'Nd', const Color(0xFF33C9FE)),
  Element('zirconium', 'pm', const Color(0xFF33C9FE)),
  Element('niobium', 'Sm', const Color(0xFF33C9FE)),
  Element('molybdeum', 'Eu', const Color(0xFF33C9FE)),
  Element('manganese', 'Gd', const Color(0xFF33C9FE)),
  Element('iron', 'Tb', const Color(0xFF33C9FE)),
  Element('cobalt', 'Dy', const Color(0xFF33C9FE)),
  Element('copper', 'Ho', const Color(0xFF33C9FE)),
  Element('Zinc', 'Er', const Color(0xFF33C9FE)),
  Element('germinium', 'Tm', const Color(0xFF33C9FE)),
  Element('arsenic', 'Yb', const Color(0xFF33C9FE)),
  Element('selenium', 'Lu', const Color(0xFF33C9FE)),
];

List<Element> periodicElements9 = [
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('', '', const Color(0xFFF1F4F4)),
  Element('yttrium', 'Ac', const Color(0xFF33C9FE)),
  Element('rubdium', 'Th', const Color(0xFF33C9FE)),
  Element('strontium', 'Pa', const Color(0xFF33C9FE)),
  Element('yttrium', 'U', const Color(0xFF33C9FE)),
  Element('zirconium', 'Np', const Color(0xFF33C9FE)),
  Element('molybdeum', 'Pu', const Color(0xFF33C9FE)),
  Element('manganese', 'Am', const Color(0xFF33C9FE)),
  Element('iron', 'Cm', const Color(0xFF33C9FE)),
  Element('cobalt', 'Bk', const Color(0xFF33C9FE)),
  Element('copper', 'Cf', const Color(0xFF33C9FE)),
  Element('Zinc', 'Es', const Color(0xFF33C9FE)),
  Element('gallium', 'Fm', const Color(0xFF33C9FE)),
  Element('germinium', 'Md', const Color(0xFF33C9FE)),
  Element('arsenic', 'No', const Color(0xFF33C9FE)),
  Element('selenium', 'Lr', const Color(0xFF33C9FE)),
];

class EquationBalancerScreen extends StatefulWidget {
  const EquationBalancerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EquationBalancerScreenState createState() => _EquationBalancerScreenState();
}

class _EquationBalancerScreenState extends State<EquationBalancerScreen> {
  final TextEditingController _equationController = TextEditingController();
  String? _balancedEquation;
  bool _showPeriodicTable = false;
  List<String> exampleEquations = [
    'H2 + O2 = H2O',
    'CH4 + O2 = CO2 + 2H2O',
    'C5H12O6 + O2 = CO2 + H2O',
  ];
  int _currentExampleIndex = 0;

 Future<bool> _isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

 Future<void> _balanceEquation() async {
  final equation = _equationController.text.trim();

  if (!await _isInternetAvailable()) {
    _showSnackbar('No Internet');
    return;
  }
  if (equation.isEmpty) {
    _showSnackbar('Equation field is empty');
    return;
  }

  // Navigate to ResultScreen immediately
  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ResultScreen(equationText: equation),
    ),
  );
}
  void _loadExampleEquation() {
    if (_currentExampleIndex < exampleEquations.length) {
      setState(() {
        _equationController.text = exampleEquations[_currentExampleIndex];
        _currentExampleIndex++;
      });
    } else {
      // If all examples have been shown, reset the index to 0
      setState(() {
        _currentExampleIndex = 0;
        _equationController.text = exampleEquations[_currentExampleIndex];
        _currentExampleIndex++;
      });
    }
  }

  @override
  void dispose() {
    _equationController.dispose();
    super.dispose();
  }

  void _togglePeriodicTable() {
    setState(() {
      _showPeriodicTable = !_showPeriodicTable;
    });
  }


  String responseText = "";

  // List of your API keys
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

  bool _isLoading = false; // Track loading state

  Future<void> balanceEquation(String  equationText) async {
    final apiKey = getRandomApiKey();
    final query = _equationController.text.replaceAll('+','plus'); // Ensure spaces are URL encoded

    setState(() {
      _isLoading = true; // Show the loading indicator
    });

    try {
      final url = Uri.parse(
          'http://api.wolframalpha.com/v2/query?appid=$apiKey&input=$query&output=json&podstate=Step-by-step+solution&podstate=Step-by-step&podstate=Show+all+steps');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        // Print the result to the debug console

        // Check if the response is true or false (you may need to modify this logic based on your API response structure)
        final success = result['queryresult']['success'] ?? false;

        if (success) {
          // If the equation is correct, navigate to the ResultScreen
         
        } else {
          // If the equation is incorrect, show a snackbar message
          _showSnackbar('Equation is not correct');
        }
      } else {
        
        _showSnackbar('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
     // Print the error to the debug console
      _showSnackbar('An error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false; // Hide the loading indicator
      });
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(message,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 4),
    ));
  }

  List<SavedAnswer> savedAnswers = [];
  final listViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    loadSavedAnswers();
  }

  void captureAndSaveScreenshot() async {
    // Capture a screenshot of the current screen
    final image = await captureScreenshot();

    // Create a SavedAnswer object with the captured image and relevant information
    final savedAnswer = SavedAnswer(
      title: 'Title', // Replace with the actual title
      content: 'Content', // Replace with the actual content
      image: image,
    );

    // Add the saved answer to the list
    setState(() {
      savedAnswers.add(savedAnswer);
    });

    // Save the updated list of saved answers to SharedPreferences
    saveSavedAnswers();
  }

  Future<Uint8List> captureScreenshot() async {
    try {
      // Capture a screenshot of the ListView.builder content
      final RenderRepaintBoundary boundary = listViewKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
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
        savedAnswers = savedAnswersJson
            .map((jsonString) => SavedAnswer.fromJson(json.decode(jsonString)))
            .toList();
      });
    }
  }

  // Save saved answers to SharedPreferences
  Future<void> saveSavedAnswers() async {
    final prefs = await SharedPreferences.getInstance();
    final savedAnswersJson = savedAnswers
        .map((savedAnswer) => json.encode(savedAnswer.toJson()))
        .toList();
    prefs.setStringList('savedAnswers', savedAnswersJson);
  }

  void _shareAppLink() {
    // Replace 'Your App Link' with the actual link you want to share.
    Share.share(
        'https://play.google.com/store/apps/details?id=chemistry.chemical.equationbalancer.solver.withsteps');
  }

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String equationText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
     appBar: PreferredSize(preferredSize: const Size.fromHeight(70.0),child: 
    AppBar(
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1), // Adjust the height as needed
        child: Container(
    color: Colors.grey.shade300, // Set the desired bottom color
    height:1, // Adjust the height as needed
        ),
      ),
      leading: Builder(
    builder: (BuildContext context) {
      return Center(
        child: Container(
          height: 40,
          width: 40,
          margin: const EdgeInsets.only(left: 15),
           // Equal margin on all sides
          decoration: BoxDecoration(
            
            color: const Color(0xFF5ECA29),
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            // iconSize: 25.0,
            icon: Image.asset('images/Logo/Black/Hamburger.png',height: 30,width: 30,fit: BoxFit.fitWidth,),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      );
    },
      ),
      centerTitle: true,
      title: SizedBox(
    height: 50,
    width: 120,
    child: Image.asset('images/Logo/Black/PNG.png'),
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
          icon: Image.asset('images/Logo/Black/Coffee.png',height: 40,width: 40,fit: BoxFit.fitWidth,),
          onPressed: () {
            _launchLink('https://www.buymeacoffee.com/codebuildersapps');
          },
        ),
      ),
    
    ),
      ],
    ),

     ),



      drawer: Drawer(
        child: ListView(
          children: <Widget>[
           Container(
  height: 150,
  decoration: const BoxDecoration(
    color: Color(0xFF252525),
  ),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        const SizedBox(
          height: 20,
        ),
         Row(
           children: [
            const SizedBox(
              width: 5,
            ),
             SizedBox(
              width: 110,
              child: Image.asset(
                'images/Logo/Black/blackPNG.png',
                fit: BoxFit.cover, // Adjust the image's fit
              ),
                   ),
           ],
         ),
         const SizedBox(
          height: 5,
         ),
        const Row(
          children: [
           
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'The essential app for every chemistry student, '
                      'providing accurate & efficient calculations,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      maxLines: 2, // Limit text to 2 lines
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),

            const SizedBox(
              height: 10,
            ),
            ListTile(
                leading: SizedBox(
                  height: 30, 
                  width: 30,
                  child: Image.asset('images/Logo/Black/Coffee2.png')), // Replace with your image path
                title: const Text('Buy us a coffee',
                style: TextStyle(color: Color(0xFF252525),fontWeight: FontWeight.bold,fontSize: 14),),
                onTap:  () {
                 _launchLink(
                     'https://www.buymeacoffee.com/codebuildersapps');
               
                },
              ),
               const SizedBox(
              height: 10,
            ),
            ListTile(
                leading: SizedBox(
                   height: 30, 
                  width: 30,
                  child: Image.asset('images/Logo/Black/Saved.png')), // Replace with your image path
                title: const Text('Saved Answers',style: TextStyle(color: Color(0xFF252525),fontWeight: FontWeight.bold,fontSize: 14),),
               onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) =>
                           SavedAnswersScreen(savedAnswers: savedAnswers),
                     ),
                   );
                 },
              ),
               const SizedBox(
              height: 10,
            ),
            ListTile(
                leading: SizedBox(
                   height: 30, 
                  width: 30,
                  child: Image.asset('images/Logo/Black/Rate.png')), // Replace with your image path
                title: const Text('Rate Us',style: TextStyle(color: Color(0xFF252525),fontWeight: FontWeight.bold,fontSize: 14),),
                onTap:  () {
                 _launchLink(
                     'https://play.google.com/store/apps/details?id=chemistry.chemical.equationbalancer.solver.withsteps&hl=en&gl=US');
               
                },
              ),
               const SizedBox(
              height: 10,
            ),
            ListTile(
                leading: SizedBox(
                  height: 30, 
                  width: 30,
                  child: Image.asset('images/Logo/Black/Share.png')), // Replace with your image path
                title: const Text('Share Us',style: TextStyle(color: Color(0xFF252525),fontWeight: FontWeight.bold,fontSize: 14),),
                onTap: () {
                     // Open the share options.
                     _shareAppLink();
                   },
              ),
              
              const SizedBox(
              height: 10,
            ),
            ListTile(
                leading: SizedBox(
                  height: 30, 
                  width: 30,
                  child: Image.asset('images/Logo/Black/Privacy.png')), // Replace with your image path
                title: const Text('Privacy',style: TextStyle(color: Color(0xFF252525),fontWeight: FontWeight.bold,fontSize: 14),),
                onTap:  () {
                 _launchLink(
                     'https://codebuildersapp.blogspot.com/2023/01/equation-balancer-app-privacy-policy.html');
              
                },
              ),
              
           
          
          ],
        ),
      ),
      
     body: Stack(
  children: [
    Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F4F4),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Enter Equation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF252525),
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFF252525),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextButton(
                        onPressed: _loadExampleEquation,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                        child: const Center(
                          child: Text(
                            'Examples',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                     
                    ),
                    child: TextField(
                       cursorColor: const Color(0xFF5ECA29),
                      controller: _equationController,
                      enabled: !_showPeriodicTable,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Input the Equation',
                        hintStyle: const TextStyle(fontSize: 12),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Clear the text field
                            _equationController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    Text(
                      'Equation Preview',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF252525),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: TextField(
                     cursorColor: const Color(0xFF5ECA29),
                    controller: _equationController,
                    readOnly: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: '',
                      hintStyle: const TextStyle(fontWeight: FontWeight.w900),
                      labelStyle: GoogleFonts.ptSerif(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
         
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  height: 50,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: _togglePeriodicTable,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: const Color(0xFF252525),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Periodic Table',
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50,
                  width: 120,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
    onPressed: () {
        _balanceEquation();
    },
    style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: const Color(0xFF5ECA29),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    ),
    child: const Text(
        'Balance',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
    ),
),

                ),
                
              ),
        
            ],
          ),
          _showPeriodicTable ? _buildPeriodicTable() : Container(),
          if (_balancedEquation != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Balanced Equation: $_balancedEquation',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    ),
    if (_isLoading)
      const Center(
        child: CircularProgressIndicator(
          color:  Colors.white,
          backgroundColor: Color(0xFF5ECA29),
        ),
      ),
  ],
),
);

    
  }

  
  
  Widget _buildPeriodicTable() {
    const double cellWidth = 35; // Width of each cell
    const double cellHeight = 35; // Height of each cell
    final ScrollController scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        color: const Color(0xFFF1F4F4),
        child: RawScrollbar(
          controller: scrollController, // Provide the ScrollController here
          thumbColor: const Color(0xFF5ECA29),
          radius: const Radius.circular(5),
          thickness: 10,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: periodicElements
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                // Add the symbol of the clicked element to the text field
                                final currentText = _equationController.text;
                                final symbolToAdd = element.symbol;
                                final newText = currentText.isEmpty
                                    ? symbolToAdd
                                    : '$currentText$symbolToAdd';
                                _equationController.text = newText;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                width: cellWidth, // Set the width of the cell
                                height: cellHeight, // Set the height of the cell
                                decoration: BoxDecoration(
                                  color: element.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    element.symbol,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: periodicElements2
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                // Add the symbol of the clicked element to the text field
                                final currentText = _equationController.text;
                                final symbolToAdd = element.symbol;
                                final newText = currentText.isEmpty
                                    ? symbolToAdd
                                    : '$currentText$symbolToAdd';
                                _equationController.text = newText;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                width: cellWidth, // Set the width of the cell
                                height: cellHeight, // Set the height of the cell
                                decoration: BoxDecoration(
                                  color: element.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    element.symbol,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: periodicElements3
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                // Add the symbol of the clicked element to the text field
                                final currentText = _equationController.text;
                                final symbolToAdd = element.symbol;
                                final newText = currentText.isEmpty
                                    ? symbolToAdd
                                    : '$currentText$symbolToAdd';
                                _equationController.text = newText;
                              },
                              child: Container(
                                                               margin: const EdgeInsets.symmetric(horizontal: 1),
              
                                width: cellWidth, // Set the width of the cell
                                height: cellHeight, // Set the height of the cell
                                decoration: BoxDecoration(
                                  color: element.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    element.symbol,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: periodicElements4
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                // Add the symbol of the clicked element to the text field
                                final currentText = _equationController.text;
                                final symbolToAdd = element.symbol;
                                final newText = currentText.isEmpty
                                    ? symbolToAdd
                                    : '$currentText$symbolToAdd';
                                _equationController.text = newText;
                              },
                              child: Container(
                                                               margin: const EdgeInsets.symmetric(horizontal: 1),
              
                                width: cellWidth, // Set the width of the cell
                                height: cellHeight, // Set the height of the cell
                                decoration: BoxDecoration(
                                  color: element.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    element.symbol,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: periodicElements5
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                // Add the symbol of the clicked element to the text field
                                final currentText = _equationController.text;
                                final symbolToAdd = element.symbol;
                                final newText = currentText.isEmpty
                                    ? symbolToAdd
                                    : '$currentText$symbolToAdd';
                                _equationController.text = newText;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                width: cellWidth, // Set the width of the cell
                                height: cellHeight, // Set the height of the cell
                                decoration: BoxDecoration(
                                  color: element.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    element.symbol,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: periodicElements6
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                // Add the symbol of the clicked element to the text field
                                final currentText = _equationController.text;
                                final symbolToAdd = element.symbol;
                                final newText = currentText.isEmpty
                                    ? symbolToAdd
                                    : '$currentText$symbolToAdd';
                                _equationController.text = newText;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                width: cellWidth, // Set the width of the cell
                                height: cellHeight, // Set the height of the cell
                                decoration: BoxDecoration(
                                  color: element.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    element.symbol,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: periodicElements7
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                // Add the symbol of the clicked element to the text field
                                final currentText = _equationController.text;
                                final symbolToAdd = element.symbol;
                                final newText = currentText.isEmpty
                                    ? symbolToAdd
                                    : '$currentText$symbolToAdd';
                                _equationController.text = newText;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                width: cellWidth, // Set the width of the cell
                                height: cellHeight, // Set the height of the cell
                                decoration: BoxDecoration(
                                  color: element.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    element.symbol,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: periodicElements8
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                // Add the symbol of the clicked element to the text field
                                final currentText = _equationController.text;
                                final symbolToAdd = element.symbol;
                                final newText = currentText.isEmpty
                                    ? symbolToAdd
                                    : '$currentText$symbolToAdd';
                                _equationController.text = newText;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                width: cellWidth, // Set the width of the cell
                                height: cellHeight, // Set the height of the cell
                                decoration: BoxDecoration(
                                  color: element.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    element.symbol,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    child: Row(
                      children: periodicElements9
                          .map(
                            (element) => GestureDetector(
                              onTap: () {
                                // Add the symbol of the clicked element to the text field
                                final currentText = _equationController.text;
                                final symbolToAdd = element.symbol;
                                final newText = currentText.isEmpty
                                    ? symbolToAdd
                                    : '$currentText$symbolToAdd';
                                _equationController.text = newText;
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 1),
                                width: cellWidth, // Set the width of the cell
                                height: cellHeight, // Set the height of the cell
                                decoration: BoxDecoration(
                                  color: element.color,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    element.symbol,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to launch the link
  _launchLink(String url) async {
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    // ignore: empty_catches
    } catch (e) {
    }
  }

}
