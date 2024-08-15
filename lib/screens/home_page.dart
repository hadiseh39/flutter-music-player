import 'package:flutter/material.dart';
import 'package:music_player/screens/play_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meowsics'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index){
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/images/57200.jpg'),
              ),
              title: Text('Item $index'),
              subtitle: Text('sub'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return PlayPage();
                }));
              },
            );
          },
        ),
      );
  }
}