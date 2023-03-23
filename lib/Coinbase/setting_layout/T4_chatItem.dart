import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'EAForYouModel.dart';
import 'EAConstants.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'EAForYouModel.dart';
import 'EAapp_widgets.dart';
import 'EADataProvider.dart';
import 'php_functions.dart';

/// defaultUserName use in a Chat name
const String defaultUserName = "Someone Else";

class T4_chatItem extends StatefulWidget {
  T4_chatItem({Key? key}) : super(key: key);

  _T4_chatItemState createState() => _T4_chatItemState();
}

class _T4_chatItemState extends State<T4_chatItem>
    with TickerProviderStateMixin {
  var uuid;
  String _chatname = '';
  String _name='';
  String _email='';
  String _email2='';
  ScrollController scrollController = ScrollController();
  FocusNode msgFocusNode = FocusNode();
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;
  var msgListing = getChatMsgData();
  final pusher = PusherChannelsFlutter.getInstance();
  final channels = {};
  PusherEvent? event;
  var data;

  Future<void> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = (prefs.getString('name') ?? '');
    _email = (prefs.getString('email') ?? '');
    _email2 = (prefs.getString('email2') ?? '');
    _chatname = (prefs.getString('chatname') ?? '');
    //Return String
    setState(() {
    });
  }

  get_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = (prefs.getString('name') ?? '');
    _email = (prefs.getString('email') ?? '');
    _email2 = (prefs.getString('email2') ?? '');
    data = await get_chat1(_email,_email2);
    uuid = data['uuid'];
    initPusher();
    setState(() {
    });
  }

  initPusher() async {
    await pusher.init(
        apiKey: "26c6542973ee33d13f11",
        cluster: "ap2",
      onAuthorizer: onAuthorizer
    );
    final myChannel = await pusher.subscribe(
        channelName: "private-$uuid-channel",
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
    var msgModel = EAMessageModel();
    msgModel.msg = data;
    msgModel.time = formatter.format(DateTime.now());;
    msgModel.senderId = 123;
    msgListing.insert(0, msgModel);

    if (mounted) scrollController.animToTop();
    FocusScope.of(context).requestFocus(msgFocusNode);
    setState(() {});
  }


    @override
  void initState() {
    getStringValuesSF();
    get_data();
    super.initState();
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
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 19.0,
                      )),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    _chatname,
                    style:
                        TextStyle(color: Colors.white ,fontSize: 25.0, fontWeight: FontWeight.w700),
                  )
                ]),
              )
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: new Column(children: <Widget>[
                new Flexible(
                  child: msgListing.length > 0
                      ? Container(
                          child: new ListView.builder(
                            controller: scrollController,
                            itemBuilder: (_, index) {
                              EAMessageModel data = msgListing[index];
                              var isMe = data.senderId == EASender_id;

                              return ChatMessageWidget1(isMe: isMe, data: data);
                            },
                            itemCount: msgListing.length,
                            reverse: true,
                            padding:
                                new EdgeInsets.only(right: 10.0,left: 10.0, bottom: 10.0),
                          ),
                        )
                      : NoMessage(),
                ),

                /// Line
                new Divider(height: 1.5),
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
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: Color(0xFF81B622),
                ),
                onPressed: () => _sendvcard(),
              ),
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
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.done,
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

    @override
    void dispose() {
      for (Msg msg in _messages) {
        msg.animationController!.dispose();
      }
      super.dispose();
    }
  }
  void _submitMsg1(String txt) {
    setState(() {
      _isWriting = false;
    });
    Msg msg = new Msg(
      txt: txt,
      animationController: new AnimationController(
          vsync: this, duration: new Duration(milliseconds: 800)),
    );
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController!.forward();
  }

  void _submitMsg(String txt) async {
    DateFormat formatter = DateFormat('hh:mm a');

    if (_textController.text.trim().isNotEmpty) {
      hideKeyboard(context);
      var msgModel = EAMessageModel();
      msgModel.msg = _textController.text.toString();
      msgModel.time = formatter.format(DateTime.now());
      msgModel.senderId = 1;
      msgModel.name = "Me";
      hideKeyboard(context);
      msgListing.insert(0, msgModel);
      final eventz = PusherEvent(
          channelName: "private-$uuid-channel",
          eventName: "client-message",
          data: msgModel.msg ,
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

  void _sendvcard() async {
    DateFormat formatter = DateFormat('hh:mm a');
    var msgModel1 = EAMessageModel();
    msgModel1.msg = "V-card request sent";
    msgModel1.time = formatter.format(DateTime.now());;
    msgModel1.senderId = 1;
    msgListing.insert(0, msgModel1);
      var msgModel = EAMessageModel();
      msgModel.msg = "V-card request recieved";
      msgModel.time = formatter.format(DateTime.now());
      msgModel.senderId = 1;
      msgModel.name = "Me";
      final eventz = PusherEvent(
          channelName: "private-$uuid-channel",
          eventName: "client-message",
          data: msgModel.msg ,
          userId: "1");
      await pusher.trigger(eventz);


      if (mounted) scrollController.animToTop();
      FocusScope.of(context).requestFocus(msgFocusNode);
      setState(() {});

      await Future.delayed(Duration(seconds: 1));


      if (mounted) scrollController.animToTop();

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

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});

  final String? txt;
  final AnimationController? animationController;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController!, curve: Curves.fastOutSlowIn),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Expanded(
              child: Padding(
                padding: const EdgeInsets.all(00.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(1.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0)),
                        color: Color(0xFFA665D1).withOpacity(0.6),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(
                        txt!,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(
              child: Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    "lib/Coinbase/Assets/noMessage.png",
                    height: 220.0,
                  )),
            ),
          ),
          Center(
              child: Text(
            "Not Have Message",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black12,
                fontSize: 17.0,
                fontFamily: "Popins"),
          ))
        ],
      ),
    ));
  }
}
