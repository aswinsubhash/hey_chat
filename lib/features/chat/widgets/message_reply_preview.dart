import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hey_chat/common/providers/message_reply_provider.dart';
import 'package:hey_chat/common/widgets/common_widgets.dart';
import 'package:hey_chat/features/chat/widgets/display_text_image_git.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({super.key});

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);
    return Container(
      width: 350,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  messageReply!.isMe ? 'You' : 'Opposite',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => cancelReply(ref),
                child: const Icon(
                  Icons.close,
                  size: 16,
                ),
              )
            ],
          ),
          commonSizedBox(8),
          DisplayTextImageGIF(
            message: messageReply.message,
            type: messageReply.messageEnum,
          ),
        ],
      ),
    );
  }
}
