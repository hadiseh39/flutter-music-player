//import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key, required this.song});

  final SongModel song;


  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration? duration;
  Duration currentDuration = Duration();

  Future<void> getSong() async{
    duration = await _audioPlayer.setAudioSource(
      AudioSource.uri(Uri.parse(widget.song.uri!)),
    );
    _audioPlayer.positionStream.listen((event){
      currentDuration = event;
      setState(() {});
    });
    
    _audioPlayer.play();
    setState(() {
      
    });
  }

  @override
  void initState() {
    getSong();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    super.dispose();
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
               /* ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/57200.jpg',
                    width: MediaQuery.of(context).size.width - 50,
                  )
                ), */
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
                    _audioPlayer.seek(Duration(seconds: (value * (duration?.inSeconds ?? 0)).round()));
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
                        _audioPlayer.seek(currentDuration - Duration(seconds: 10));
                        setState(() {});
                      }, 
                      icon: const Icon(Icons.skip_previous_rounded),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_audioPlayer.playing) {
                          _audioPlayer.pause();
                        } else {
                          _audioPlayer.play();
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
                        child: Icon(_audioPlayer.playing 
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded, 
                          color: Colors.white, size: 40,
                        )
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        _audioPlayer.seek(currentDuration + Duration(seconds: 10));
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