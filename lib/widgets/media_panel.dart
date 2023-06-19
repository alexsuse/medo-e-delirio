import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';

import '../models/audio.dart';
import '../utils/audio_singleton.dart';
import 'package:cross_file/cross_file.dart';

Function _pressFunction(Audio audio) {
  return () async {
    AudioPlayerSingleton.instance.audioPlayer.setVolume(1.0);
    AudioPlayerSingleton.instance.audioPlayer.setUrl(audio.url());
    await AudioPlayerSingleton.instance.audioPlayer.play();
  };
}

Function _onLongPressFunction(Audio audio) {
  return () async {
    Uint8List bytes = await readBytes(audio.uri());
    XFile sharedFile = XFile.fromData(bytes, mimeType: 'audio/mpeg');

    await Share.shareXFiles([sharedFile]);
  };
}

class MediaPanel extends StatelessWidget {
  MediaPanel(
    this.screenSize,
    this.audio,
  )   : onPress = _pressFunction(audio),
        onLongPress = _onLongPressFunction(audio) {}

  final Audio audio;
  final Function onPress;
  final Size screenSize;
  final Function onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onPress();
      },
      onLongPress: () {
        this.onLongPress();
      }, // this.onLongPress,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: screenSize.width * .01,
            horizontal: screenSize.width * .01),
        padding: EdgeInsets.all(screenSize.width * .02),
        width: screenSize.width * .35,
        height: screenSize.height * .1,
        decoration: BoxDecoration(
            color: Color(0XFF629460), borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.audio.label,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  fontSize: screenSize.width * .036, color: Colors.white),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: screenSize.width * .02),
              child: Text(
                this.audio.author,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontSize: screenSize.width * .032, color: Colors.yellow),
              ),
            ),

            /*GestureDetector(
                  child: FaIcon(
                    this.isFavorite
                        ? FontAwesomeIcons.solidStar
                        : FontAwesomeIcons.star,
                    size: screenSize.height * 0.020,
                    color: Colors.white,
                  ),
                  onTap: this.favoriteAction),*/
          ],
        ),
      ),
    );
  }
}
