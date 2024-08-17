import 'package:flutter/material.dart';
import 'package:music_player/screens/play_page.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer audioPlayer = AudioPlayer();
  final OnAudioQuery _audioQuery = OnAudioQuery();
  List<SongModel> _songs = [];

  Future<void> getSongs() async{
    bool hasPermission = await _audioQuery.checkAndRequest(retryRequest: true);
    if (hasPermission) {
      _songs = await _audioQuery.querySongs();
      setState(() {
        
      });
    }
  }

  @override
  void initState() {
    getSongs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meowsics'),
          centerTitle: true,
        ),
        body: _songs == null ? const Center(child:  CircularProgressIndicator()) 
        : ListView.builder(
          itemCount: _songs.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: QueryArtworkWidget(
                id: _songs[index].id,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(10),
              ),
              title: Text(_songs![index].title, overflow: TextOverflow.fade,),
              subtitle: Text(_songs![index].artist ?? ""),
              onTap: () {
                if(audioPlayer.playing){
                  audioPlayer.stop();
                  setState(() {});
                }
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return PlayPage(song: _songs![index], audioPlayer: audioPlayer,);
                }));
              },
            );
          },
        ),
      );
  }
}