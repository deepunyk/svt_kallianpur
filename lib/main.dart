import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svt_kallianpur/screens/about_screen.dart';
import 'package:svt_kallianpur/screens/circular_screen.dart';
import 'package:svt_kallianpur/screens/deities_detail_screen.dart';
import 'package:svt_kallianpur/screens/event_screen.dart';
import 'package:svt_kallianpur/screens/feed_screen.dart';
import 'package:svt_kallianpur/screens/gallery_detail_screen.dart';
import 'package:svt_kallianpur/screens/gallery_display_image_screen.dart';
import 'package:svt_kallianpur/screens/gallery_screen.dart';
import 'package:svt_kallianpur/screens/home_screen.dart';
import 'package:svt_kallianpur/screens/pdf_view_screen.dart';
import 'package:svt_kallianpur/screens/seva_screen.dart';
import 'package:svt_kallianpur/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff650D01),
        accentColor: Color(0xffECB840),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: SplashScreen(),
      routes: {
        SplashScreen.routeName: (ctx) => SplashScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        AboutScreen.routeName: (ctx) => AboutScreen(),
        FeedScreen.routeName: (ctx) => FeedScreen(),
        SevaScreen.routeName: (ctx) => SevaScreen(),
        GalleryScreen.routeName: (ctx) => GalleryScreen(),
        GalleryDetailScreen.routeName: (ctx) => GalleryDetailScreen(),
        GalleryDisplayImageScreen.routeName: (ctx) => GalleryDisplayImageScreen(),
        DeitiesDetailScreen.routeName: (ctx) => DeitiesDetailScreen(),
        EventScreen.routeName: (ctx) => EventScreen(),
        CircularScreen.routeName :(ctx) => CircularScreen(),
        PDFViewScreen.routeName :(ctx)=> PDFViewScreen(),
      },
    );
  }
}
