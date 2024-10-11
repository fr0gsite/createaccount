import 'package:createaccount/config.dart';
import 'package:createaccount/datatypes/globalstatus.dart';
import 'package:createaccount/l10n/l10n.dart';
import 'package:createaccount/widget/creationprocess/creationprocess.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

// DOTO: deactivate https://fonts.gstatic.com/s/roboto/v20/KFOmCnqEu92Fr1Me5WZLCzYlKw.ttf
// using local instead

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalStatus>(
            create: (context) => GlobalStatus()),
      ],
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "fr0gsite Account",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppConfig.colorPrimary,
            secondary: AppConfig.colorSecondary),
        useMaterial3: true,
      ),
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: const MyHomePage(title: 'Fr0g Account'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController backgroundcontroller;

  @override
  void initState() {
    super.initState();
    backgroundcontroller = AnimationController(vsync: this);
    backgroundcontroller.duration = const Duration(seconds: 20);
    backgroundcontroller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Container(color: const Color.fromARGB(255, 59, 104, 8)),

          //background with ic_launcher.png wipping around

          RotationTransition(
              turns: Tween(begin: -0.05, end: 0.05).animate(
                CurvedAnimation(
                    parent: backgroundcontroller, curve: Curves.easeInOut),
              ),
              child: Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                      "assets/ic_launcher.png",
                    ),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                  Text("Fr0g.site",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.1,
                      )),
                ],
              )),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          const CreationProcess(),
        ],
      ),
    );
  }
}
