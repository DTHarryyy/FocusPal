
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practice/features/chat_bot/ui/pages/chat_bot_pages.dart';

class HomeWidgetsTree extends StatefulWidget {
  const HomeWidgetsTree({super.key});

  @override
  State<HomeWidgetsTree> createState() => _HomeWidgetsTreeState();
}

class _HomeWidgetsTreeState extends State<HomeWidgetsTree> {
  int selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('hi'),
      ),


      floatingActionButton: FloatingActionButton(shape: CircleBorder(),
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBotPages()));},
          child: Transform.translate(offset: Offset(-3, 0),
          child: Icon(FontAwesomeIcons.robot))
        ),
      bottomNavigationBar: NavigationBar(destinations:const [
        NavigationDestination(icon: Icon(FontAwesomeIcons.house,), label: 'home'),
        NavigationDestination(icon: Icon(FontAwesomeIcons.pen), label: 'Learn'),
        NavigationDestination(icon: Icon(FontAwesomeIcons.peopleGroup), label: 'Groups'),
        NavigationDestination(icon: Icon(FontAwesomeIcons.checkDouble), label: 'Task'),
        NavigationDestination(icon: Icon(FontAwesomeIcons.user), label: 'Profile'),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: (index){
        setState(() {
          selectedIndex = index;
        });
      },
      )
    );
  }
}