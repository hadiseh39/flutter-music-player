//import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key, required this.song, required this.audioPlayer});

  final SongModel song;
  final AudioPlayer audioPlayer;

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  Duration? duration;
  Duration currentDuration = const Duration();
  String? currentSongTitle;
  String? currentlyPlayingSongUri;
  
  Future<void> getSong() async{
    currentlyPlayingSongUri = widget.song.uri;
    duration = await widget.audioPlayer.setAudioSource(
      AudioSource.uri(Uri.parse(widget.song.uri!)),
    );
    widget.audioPlayer.positionStream.listen((event){
      currentDuration = event;
      setState(() {});
    });
    currentSongTitle = widget.song.title;
    
    widget.audioPlayer.play();
    setState(() {});
  }

  @override
  void initState() {
    getSong();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                /*ImageFiltered(   // doesen't work in my phone:(
                  imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: QueryArtworkWidget(
                    id: widget.song.id, 
                    type: ArtworkType.AUDIO,
                    artworkFit: BoxFit.cover,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                  ),
                ),*/
                Text(widget.song.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5,),
                Text(widget.song.artist ?? 'no artist',),
                const SizedBox(height: 20,),
                QueryArtworkWidget(
                  id: widget.song.id, 
                  type: ArtworkType.AUDIO,
                  artworkBorder: BorderRadius.circular(10),
                  artworkHeight: MediaQuery.of(context).size.width - 50,
                  artworkWidth: MediaQuery.of(context).size.width - 50,
                  keepOldArtwork: true,
                ),
                const Spacer(),
                Slider(
                  value: currentDuration.inSeconds / (duration?.inSeconds ?? 1), 
                  thumbColor: Colors.white,
                  activeColor: Colors.white,
                  inactiveColor: const Color.fromARGB(255, 234, 234, 234),
                  onChanged: (value){
                    widget.audioPlayer.seek(Duration(seconds: (value * (duration?.inSeconds ?? 0)).round()));
                    setState(() {});
                  }
                ),
                Row(
                  children: [
                    const SizedBox(width: 30,),
                    Text(currentDuration.toString().split('.')[0].padLeft(8, '0')),
                    const Spacer(),
                    Text(duration.toString().split('.')[0].padLeft(8, '0')),
                    const SizedBox(width: 30,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: (){
                        widget.audioPlayer.seek(currentDuration - Duration(seconds: 10));
                        setState(() {});
                      }, 
                      icon: const Icon(Icons.skip_previous_rounded),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.audioPlayer.playing) {
                          widget.audioPlayer.pause();
                        } else {
                          widget.audioPlayer.play();
                        }
                        setState(() {
                          
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 142, 142, 142),
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: Icon(widget.audioPlayer.playing 
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded, 
                          color: Colors.white, size: 40,
                        )
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        widget.audioPlayer.seek(currentDuration + Duration(seconds: 10));
                        setState(() {});
                      }, 
                      icon: const Icon(Icons.skip_next_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 50,)
              ],
            )
          ],
        ),
      ),
    );
  }
}