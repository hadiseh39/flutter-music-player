import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key, required this.song});

  final SongModel song;

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const SizedBox(height: 20,),
                Text(widget.song.title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5,),
                Text(widget.song.artist ?? 'no artist',
                  //style: TextStyle(fontSize: ),
                ),
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
                ),
                const Spacer(),
                Slider(
                  value: 0.2, 
                  thumbColor: Colors.white,
                  activeColor: Colors.white,
                  inactiveColor: const Color.fromARGB(255, 234, 234, 234),
                  onChanged: (value){}
                ),
                const Row(
                  children: [
                    SizedBox(width: 30,),
                    Text('00:10'),
                    Spacer(),
                    Text('03:10'),
                    SizedBox(width: 30,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){}, icon: const Icon(Icons.skip_previous_rounded)),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: const Color.fromARGB(255, 154, 154, 154),
                      child: IconButton(
                        icon: const Icon(
                          Icons.pause_rounded,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        onPressed: () {
                    
                        },
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.skip_next_rounded)),
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