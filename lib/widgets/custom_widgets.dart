import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sprout/constants/strings.dart';
import 'package:sprout/global/extensions.dart';
import 'package:sprout/models/chat.dart';

import '../constants/colors.dart';
import '../constants/icons.dart';
import 'custom_images.dart';

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final int? index;
  final String? path;
  final double? width;
  final Directory appDirectory;

  const WaveBubble({
    Key? key,
    required this.appDirectory,
    this.width,
    this.index,
    this.isSender = false,
    this.path,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  File? file;

  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  playerWaveStyle() => PlayerWaveStyle(
        fixedWaveColor: widget.isSender
            ? Colors.white54
            : AppColors.primary.withOpacity(0.2),
        liveWaveColor: widget.isSender ? Colors.white : AppColors.primary,
        spacing: 6,
      );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      setState(() {});
    });
  }

  void _preparePlayer() async {
    if (widget.index != null) {
      file = File('${widget.appDirectory.path}/audio${widget.index}.mp3');
      await file?.writeAsBytes(
        (await rootBundle.load('assets/audios/audio${widget.index}.mp3'))
            .buffer
            .asUint8List(),
      );
    }
    if (widget.index == null && widget.path == null && file?.path == null) {
      return;
    }

    controller.preparePlayer(
      path: widget.path ?? file!.path,
      shouldExtractWaveform: widget.index?.isEven ?? true,
    );

    if (widget.index?.isOdd ?? false) {
      controller
          .extractWaveformData(
            path: widget.path ?? file!.path,
            noOfSamples:
                playerWaveStyle().getSamplesForWidth(widget.width ?? 200),
          )
          .then(
            (waveformData) => debugPrint(waveformData.toString()),
          );
    }
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.path != null || file?.path != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (!controller.playerState.isStopped)
                IconButton(
                  onPressed: () async {
                    controller.playerState.isPlaying
                        ? await controller.pausePlayer()
                        : await controller.startPlayer(
                            finishMode: FinishMode.loop,
                          );
                  },
                  icon: Icon(
                    controller.playerState.isPlaying
                        ? Icons.stop
                        : Icons.play_arrow,
                  ),
                  color: widget.isSender ? Colors.white : AppColors.primary,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
              Expanded(
                child: AudioFileWaveforms(
                  size: Size(MediaQuery.of(context).size.width * 0.7, 30),
                  playerController: controller,
                  waveformType: widget.index?.isOdd ?? false
                      ? WaveformType.fitWidth
                      : WaveformType.long,
                  playerWaveStyle: playerWaveStyle(),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

class ReceivedMessage extends StatefulWidget {
  const ReceivedMessage(
      {required this.message, super.key, required this.appDirectory});
  final Chat message;
  final Directory appDirectory;

  @override
  State<ReceivedMessage> createState() => _ReceivedMessageState();
}

class _ReceivedMessageState extends State<ReceivedMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      constraints: BoxConstraints(maxWidth: context.width * 0.8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: BodyText(widget.message.msg),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: widget.message.msg),
                  );
                },
                icon: assetImage(AppIcons.copy),
              ),
              IconButton(
                onPressed: () async => Share.share(widget.message.msg),
                icon: assetImage(AppIcons.share),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SendMessage extends StatefulWidget {
  const SendMessage({
    required this.message,
    super.key,
    required this.appDirectory,
  });
  final Chat message;
  final Directory appDirectory;

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: context.width * 0.7),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: BodyText(widget.message.msg, color: Colors.white),
      ),
    );
  }
}

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, required this.title, this.actions});
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const CustomBackButton(),
      title: Headline(title, color: Colors.white, fontsize: 26),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_ios),
      color: Colors.white,
    );
  }
}

EdgeInsetsGeometry get pageMargin =>
    const EdgeInsets.symmetric(horizontal: 15, vertical: 10);

class Headline extends StatelessWidget {
  const Headline(
    this.text, {
    Key? key,
    this.fontsize,
    this.color,
    this.align,
    this.font,
    this.maxLines,
    this.height,
    this.overflow,
    this.decoration,
  }) : super(key: key);
  final String text;
  final double? fontsize;
  final Color? color;
  final TextAlign? align;
  final String? font;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: fontsize ?? 20,
            color: color ?? Colors.black,
            fontFamily: font ?? GoogleFonts.fredoka().fontFamily,
            height: height,
            decoration: decoration,
          ),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText(
    this.text, {
    Key? key,
    this.fontsize,
    this.color,
    this.maxLines,
    this.overflow,
    this.align,
    this.weight,
    this.font,
    this.decoration,
    this.height,
  }) : super(key: key);
  final String text;
  final double? fontsize;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? align;
  final FontWeight? weight;
  final String? font;
  final TextDecoration? decoration;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: fontsize ?? 14,
            color: color ?? Colors.black,
            fontWeight: weight ?? FontWeight.normal,
            fontFamily: font ?? AppStrings.font,
            decoration: decoration,
            height: height ?? 1,
          ),
    );
  }
}
