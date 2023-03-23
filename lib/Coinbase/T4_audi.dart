import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'setting_layout/EAForYouModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'setting_layout/EAConstants.dart';
import 'setting_layout/EADataProvider.dart';
import 'setting_layout/EAapp_widgets.dart';
import 'setting_layout/T4_chatItem.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:video_player/video_player.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

/// defaultUserName use in a Chat name
const String defaultUserName = "Alisa Hearth";

class T4_audi extends StatefulWidget {
  T4_audi({Key? key}) : super(key: key);

  _T4_audiState createState() => _T4_audiState();
}

class _T4_audiState extends State<T4_audi>
    with TickerProviderStateMixin {
  String _name = '';
  ScrollController scrollController = ScrollController();
  FocusNode msgFocusNode = FocusNode();
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  TextEditingController msgController = TextEditingController();
  bool _isWriting = false;
  var msgListing = getChatMsgData();
  final pusher = PusherChannelsFlutter.getInstance();
  final channels = {};
  PusherEvent? event;

  Future<void> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      _name = (prefs.getString('name') ?? '');
    });
  }
  initPusher() async {
    await pusher.init(
        apiKey: "26c6542973ee33d13f11",
        cluster: "ap2",
        onAuthorizer: onAuthorizer
    );
    final myChannel = await pusher.subscribe(
        channelName: "private-group-channel",
        onEvent: onEvent
    );
    await pusher.connect();
    print("success");
  }
  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    String secret = "61346aa15fc2a07ed8b5";
    String message = socketId+":"+channelName+":"+'{"user_id": 1}';

    var key = utf8.encode(secret);
    var bytes = utf8.encode(message);

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);

    return {
      "auth": "26c6542973ee33d13f11:$digest",
      "channel_data": '{"user_id": 1}',
      "shared_secret": "foobar"
    };
  }
  void onEvent(event) {
    DateFormat formatter = DateFormat('hh:mm a');
    String data = event.data;
    final msg = jsonDecode(data);
    var msgModel = EAMessageModel();
    msgModel.msg = msg['message'];
    msgModel.time = formatter.format(DateTime.now());;
    msgModel.senderId = 123;
    msgModel.name = msg['name'];
    msgListing.insert(0, msgModel);

    if (mounted) scrollController.animToTop();
    setState(() {});
  }


  @override
  void initState() {
    initPusher();
    getStringValuesSF();
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// body in chat like a list in a message
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ///
              /// Create wave appbar
              ///
              ClipPath(
                child: Container(
                  height: 160.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF81B622), Color(0xFFECF87F)])),
                ),
                clipper: BottomWaveClipper(),
              ),

              ///
              /// Get triangle widget
              ///
              _triangle(
                20.0,
                10.0,
              ),
              _triangle(
                110.0,
                80.0,
              ),
              _triangle(
                60.0,
                190.0,
              ),
              _triangle(
                40.0,
                300.0,
              ),
              _triangle(
                130.0,
                330.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0, left: 20.0),
                child: Row(children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Auditorium",
                    style:
                    TextStyle(fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  )
                ]),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0),
            child: Container(
              height: 200.0,
              child: VideoPlayerScreen(),
            ),
          ),
          Divider(height: 30.0),
          Expanded(
            child: Container(
              color: Colors.white,
              child: new Column(children: <Widget>[
                new Flexible(
                  child: Container(
                    child: new ListView.builder(
                      controller: scrollController,
                      itemBuilder: (_, index) {
                        EAMessageModel data = msgListing[index];
                        var isMe = data.senderId == EASender_id;

                        return ChatMessageWidget2(isMe: isMe, data: data);
                      },
                      itemCount: msgListing.length,
                      reverse: true,
                      padding:
                      new EdgeInsets.only(right: 10.0,left: 10.0, bottom: 10.0),
                    ),
                  ),

                ),

                /// Line
                new Divider(height: 1.0),
                new Container(
                  child: _buildComposer(),
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(blurRadius: 1.0, color: Colors.black12)
                      ]),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// Component for typing text
  Widget _buildComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.yellow),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        controller: _textController,
                        focusNode: msgFocusNode,
                        onChanged: (String txt) {
                          setState(() {
                            _isWriting = txt.length > 0;
                          });
                        },
                        style: TextStyle(color: Colors.black),
                        onSubmitted: _submitMsg,
                        decoration: new InputDecoration.collapsed(
                            hintText: "Enter some text to send a message",
                            hintStyle: TextStyle(
                                fontFamily: "Sans",
                                fontSize: 16.0,
                                color: Colors.black26)),
                      ),
                    ),
                  ),
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                      child: new Text("Submit"),
                      onPressed: _isWriting
                          ? () => _submitMsg(_textController.text)
                          : null)
                      : new IconButton(
                    icon: new Icon(
                      Icons.message,
                      color: Color(0xFF81B622),
                    ),
                    onPressed: _isWriting
                        ? () => _submitMsg(_textController.text)
                        : null,
                  )),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
              border: new Border(top: new BorderSide(color: Colors.brown)))
              : null),
    );
  }

  void _submitMsg(String txt) async {
    DateFormat formatter = DateFormat('hh:mm a');

    if (_textController.text.trim().isNotEmpty) {
      hideKeyboard(context);
      var msgModel = EAMessageModel();
      msgModel.msg = _textController.text.toString();
      msgModel.time = formatter.format(DateTime.now());
      msgModel.senderId = 1;
      msgModel.name = _name;
      hideKeyboard(context);
      msgListing.insert(0, msgModel);
      final eventz = PusherEvent(
          channelName: "private-group-channel",
          eventName: "client-message",
          data: jsonEncode(msgModel) ,
          userId: "1");
      await pusher.trigger(eventz);

      _textController.text = '';

      if (mounted) scrollController.animToTop();
      FocusScope.of(context).requestFocus(msgFocusNode);
      setState(() {});

      await Future.delayed(Duration(seconds: 1));


      if (mounted) scrollController.animToTop();
    } else {
      FocusScope.of(context).requestFocus(msgFocusNode);
    }

    setState(() {});
  }



  Widget _triangle(double top, left) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: left),
      child: ClipPath(
        child: Container(
          height: 40.0,
          width: 40.0,
          color: Colors.white12.withOpacity(0.09),
        ),
        clipper: TriangleClipper(),
      ),
    );
  }
}

///
/// Create wave appbar
///
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
    Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

///
/// Create triangle clipper
///
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
   late VideoPlayerController _controller;
   late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

