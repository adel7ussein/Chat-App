import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:scholar_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/widgets/image_buble.dart';
import 'package:uuid/uuid.dart';

import '../widgets/chat_buble.dart';

bool iconBool = false;
String? data;

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

IconData _iconLight = Icons.wb_sunny;
IconData _iconDark = Icons.nights_stay;

class _ChatPageState extends State<ChatPage> {
  final ScrollController _controller = ScrollController();
  bool isRecording = false;
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  String audioPath = '';
  @override
  void initState() {
    audioRecord = Record();
    audioPlayer = AudioPlayer();
    super.initState();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error Start Recording : $e');
    }
  }

  Future<void> stopRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        String? path = await audioRecord.stop();
        setState(() {
          isRecording = false;
          audioPath = path!;
          uploadRecord();
        });
        if (path != null) {
          File file = File(path);
          var c = file.readAsBytes();
          print(c);
        }
      }
    } catch (e) {
      print('Error Stopping Record : $e');
    }
  }

  Future<void> playRecording() async {
    try {
      //Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(UrlSource(audioPath));
    } catch (e) {
      print('Error Playing Recording : $e');
    }
  }

  File? imageFile;
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    await imagePicker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        setState(() {
          uploadImage();
        });
      }
    });
  }

  String imageUrl = '';
  Future uploadImage() async {
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    await referenceImageToUpload.putFile(imageFile!);
    imageUrl = await referenceImageToUpload.getDownloadURL();
    print(imageUrl);
  }

  String recordUrl = '';
  File? recordFile;
  Future uploadRecord() async {
    recordFile = File(audioPath);
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('records');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
    await referenceImageToUpload.putFile(recordFile!);
    recordUrl = await referenceImageToUpload.getDownloadURL();
  }

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          //print(snapshot.data?.docs[4]['imageurl']);
          if (snapshot.hasData) {
            List<dynamic> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(MessageResponse.fromjson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                /*actions: [
          IconButton(onPressed: (){
            setState(() {
              iconBool = !iconBool;
            });
          }, icon: Icon(iconBool ? _iconDark : _iconLight))
        ],*/
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kLogo,
                      height: 50,
                    ),
                    const Text('chat')
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          return messageList[index].id == email
                              ? ChatBuble(
                                  message: messageList[index],
                                )
                              : ChatBubleForFriend(message: messageList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      controller: controller,
                      onSubmitted: (data) {},
                      decoration: InputDecoration(
                          hintText: 'Send Message',
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.camera_enhance),
                                onPressed: () {
                                  getImage();
                                },
                              ), //SizedBox(width: 5), // Add space between icons
                              //Icon(Icons.mic),
                              //SizedBox(width: 10), // Add space between icons
                              IconButton(
                                icon: isRecording
                                    ? const Icon(Icons.stop_circle_rounded)
                                    : const Icon(Icons.mic),
                                onPressed: isRecording
                                    ? stopRecording
                                    : startRecording,
                              ),
                              IconButton(
                                  onPressed: () {
                                    messages.add({
                                      'message': controller.text,
                                      'id': email,
                                      kCreatedAt: DateTime.now(),
                                      'imageurl': imageUrl,
                                      'recordurl': recordUrl,
                                    });
                                    _scrollDown();
                                    controller.clear();
                                    setState(() {
                                      imageUrl = '';
                                      recordUrl = '';
                                    });
                                  },
                                  icon: Icon(Icons.send))
                              //SizedBox(width: 5), // Add space between icons
                            ],
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: kPrimaryColor))),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Loading...'));
          }
        });
  }

  void _scrollDown() {
    _controller.jumpTo(0);
  }
}
