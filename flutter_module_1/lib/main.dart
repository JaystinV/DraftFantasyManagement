import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/homePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:postgres/postgres.dart';
import 'loginPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // final connection = PostgreSQLConnection(
  //     'shaped-badger-13180.5xj.cockroachlabs.cloud', 26257, 'defaultdb',
  //     username: 'justinvang_jk_gmail_',
  //     password: 'pX0U096Ls1KhnSlwRV_QYQ',
  //     useSSL: true,
  //     allowClearTextPassword: true);
  // await connection.open();

  // await connection.transaction((ctx) async {
  //   await ctx.query("""
  //   INSERT INTO public.tester (a, b)
  //   VALUES 4, 5;
  // """);
  //   var result = await ctx.query("SELECT b FROM public.tester");
  // });

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomePage(
          title: 'HAHA',
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return HomePage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(title: 'Draft Fantasy Management'),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title});

  final String title;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 60,
          title: Text(widget.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.delaGothicOne(
                textStyle: const TextStyle(color: Colors.white),
                fontSize: 22,
              ))),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/welcomePage.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.only(top: 500),
                  child: ElevatedButton(
                      onPressed: () async {
                        final connection = PostgreSQLConnection(
                            'shaped-badger-13180.5xj.cockroachlabs.cloud',
                            26257,
                            'defaultdb',
                            username: 'justinvang_jk_gmail_',
                            password: 'pX0U096Ls1KhnSlwRV_QYQ',
                            useSSL: true,
                            allowClearTextPassword: true);
                        await connection.open();
                        await connection.transaction((ctx) async {
                          await ctx.query("""
                            INSERT INTO public.tester (a, b)
                            VALUES 4, 5;
                          """);
                          var result =
                              await ctx.query("SELECT b FROM public.tester");
                          print(result);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        });
                        SystemChrome.setPreferredOrientations(
                            [DeviceOrientation.portraitUp]);
                      },
                      child: Text('Login',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(color: Colors.white),
                            //fontWeight: FontWeight.bold,
                            fontSize: 45,
                          ))))
            ],
          ),
        ),
      ),
    );
  }
}
