import 'package:flutter/material.dart';
import 'package:flutter_task_manager_app/controller/providers/auth_provider.dart';
import 'package:flutter_task_manager_app/controller/providers/todo_provider.dart';
import 'package:flutter_task_manager_app/network_resources/authentication.dart';
import 'package:flutter_task_manager_app/routes/page_routes.dart';
import 'package:flutter_task_manager_app/storage/save_user.dart';
import 'package:flutter_task_manager_app/views/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences preferences;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  Authentication.getCurrentUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => TodoProvider()),
    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings){
          return PageRoutes().appRoutes(settings);
        },
        home: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/login_bg.jpg'))
          ),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.black38
            ),
            child: const LoginScreen(),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
