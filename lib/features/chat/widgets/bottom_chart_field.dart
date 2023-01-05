import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:hey_chat/common/enums/message_enum.dart';
import 'package:hey_chat/common/providers/message_reply_provider.dart';
import 'package:hey_chat/features/chat/controller/chat_controller.dart';
import 'package:hey_chat/features/chat/widgets/message_reply_preview.dart';
import 'package:hey_chat/utils/colors.dart';
import 'package:hey_chat/utils/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String receiverUserId;
  const BottomChatField({
    Key? key,
    required this.receiverUserId,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic permission not allowed!');
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void sendTextMessage() async {
    //text messaging part
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.receiverUserId,
          );
      setState(() {
        _messageController.text = '';
      });

      //audio recording part
    } else {
      var tempDirectory = await getTemporaryDirectory();
      var path = '${tempDirectory.path}/flutter_sound.aac';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _soundRecorder!.stopRecorder();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _soundRecorder!.startRecorder(
          toFile: path,
        );
      }
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.receiverUserId,
          messageEnum,
        );
  }

  void selectImageFromCamera() async {
    File? image = await pickImageFromCamera(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
  

    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  prefixIcon: SizedBox(
                    width: 10,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: toggleEmojiKeyboardContainer,
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: selectImageFromCamera,
                          icon: const Icon(
                            Icons.camera_alt,
                            color: greyColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) {
                                  return customBottomSheet(context);
                                });
                          },
                          icon: const Icon(
                            Icons.attach_file,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: 'Type a message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 2,
                left: 2,
              ),
              child: CircleAvatar(
                radius: 24,
                backgroundColor: tabColor,
                child: GestureDetector(
                  onTap: sendTextMessage,
                  child: Icon(
                    isShowSendButton
                        ? Icons.send_rounded
                        : isRecording
                            ? Icons.close
                            : Icons.mic,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        isShowEmojiContainer
            ? SizedBox(
                height: 310,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    setState(() {
                      _messageController.text =
                          _messageController.text + emoji.emoji;
                    });

                    if (!isShowSendButton) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    }
                  },
                ),
              )
            : const SizedBox()
      ],
    );
  }

  Widget customBottomSheet(context) {
    return Container(
      decoration: const BoxDecoration(
        color: backgroundColor,
      ),
      height: 150,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Choose From',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.image,
                      color: tabColor,
                    ),
                  ),
                  const Text('Images'),
                ],
              ),
              const SizedBox(
                width: 70,
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: selectVideo,
                    icon: const Icon(
                      Icons.video_camera_back,
                      color: tabColor,
                    ),
                  ),
                  const Text('Videos'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
