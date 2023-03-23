import 'dart:async';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';


class PusherService {
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();


  Future<void> initPusher() async {
    try {
      await pusher.init(
        apiKey: "26c6542973ee33d13f11",
        cluster: "ap2"
      );
      await pusher.subscribe(channelName: 'presence-chatbox');
      await pusher.connect();
    } catch (e) {
      print("ERROR: $e");
    }
  }

}