import 'package:flutter/material.dart';

<<<<<<< HEAD
import 'domain.dart';
import 'pages/home_page.dart';
import 'theme_changer.dart';

=======
>>>>>>> parent of 25ca4e8 (add chat demo)
void main() {
  runApp(MyApp());
}

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  _MyMaterialAppState createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      themeMode:
      ThemeChanger.of(context)? ThemeMode.light : ThemeMode.dark,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: HomePage(),
    );
  }
}

<<<<<<< HEAD
class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ThemeChanger(
        islight: true,
        child: MyMaterialApp()
    );
  }
}
=======
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Text('Profile')),
            ListTile(
              title: Text('Add profile'),
              onTap: (){},
            ),
            ListTile(
              title: Text('Exit'),
              onTap: (){},
            )
          ],
          padding: EdgeInsets.zero,
        ),
      ),
      body: BodyData(), //ListView
      appBar: AppBar(
        title: Center(
          child: Text('Home'),
        ),
        actions: [
          IconButton(icon: Icon(Icons.invert_colors), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.black54,
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myBottomNavigationBar(context);
  }
}

Widget _myBottomNavigationBar(BuildContext context) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.book),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        label: 'Daily',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.timeline),
        label: 'Timeline',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: 'Explore',
      ),
    ],
    unselectedItemColor: Colors.blueGrey,
    selectedItemColor: Colors.teal,
    showUnselectedLabels: true,
  );
}

class BodyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
    scrollDirection: Axis.vertical,
    children:
    ListTile.divideTiles(
      context: context,
        tiles: [
          ElevatedButton.icon(
              onPressed: (){},
              icon: Icon(Icons.android),
              label: Text('Questionnaire Bot'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )
              ),
          ),
          ListTile(
            title: Text('Family'),
            leading: CircleAvatar(
                foregroundColor: Colors.blueGrey,
                child: Icon(Icons.family_restroom)
            ),
            subtitle: Text('No events. Click to create one.'),
          ),
          ListTile(
            title: Text('Job'),
            leading: CircleAvatar(
                foregroundColor: Colors.blueGrey,
                child: Icon(Icons.work)
            ),
            subtitle: Text('No events. Click to create one.'),
          ),
          ListTile(
            title: Text('Travel'),
            leading: CircleAvatar(
                foregroundColor: Colors.blueGrey,
                child: Icon(Icons.local_shipping)
            ),
            subtitle: Text('No events. Click to create one.'),
          ),
          ListTile(
            title: Text('Sports'),
            leading: CircleAvatar(
                foregroundColor: Colors.blueGrey,
                child: Icon(Icons.sports_basketball)
            ),
            subtitle: Text('No events. Click to create one.'),
          ),
          ListTile(
            title: Text('Friends'),
            leading: CircleAvatar(
                foregroundColor: Colors.blueGrey,
                child: Icon(Icons.wine_bar)
            ),
            subtitle: Text('No events. Click to create one.'),
          ),
    ]
    ).toList(),

  );
}
>>>>>>> parent of 25ca4e8 (add chat demo)
