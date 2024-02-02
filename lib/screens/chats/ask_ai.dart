import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprout/global/extensions.dart';
import 'package:sprout/models/chat.dart';
import 'package:sprout/network/api_services.dart';
import 'package:sprout/themes/input_decoration.dart';
import 'package:sprout/utils/constants.dart';
import 'package:sprout/widgets/custom_images.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../constants/colors.dart';
import '../../constants/icons.dart';
import '../../constants/strings.dart';
import '../../widgets/custom_widgets.dart';
import 'vtext.dart';

class AskAiScreen extends StatefulWidget {
  const AskAiScreen({this.old = false, super.key});
  final bool old;

  @override
  State<AskAiScreen> createState() => _AskAiScreenState();
}

class _AskAiScreenState extends State<AskAiScreen> {
  bool chatting = false;
  List<Chat> messages = [];
  List<Chat> chatToStore = [];
  TextEditingController message = TextEditingController();
  RecorderController controller = RecorderController();
  String? path;
  String? musicFile;
  bool isRecording = false,
      isLoading = false,
      isRecordingCompleted = false,
      isResponseLoading = false;
  late Directory appDirectory;
  stt.SpeechToText speech = stt.SpeechToText();
  bool speechAvailable = false;
  int seconds = 0, current = 0, total = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;
    setState(() {});
  }

  void _initialiseControllers() {
    controller = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    debugPrint('down');
    timer = Timer.periodic(oneSec, (timer) => handleClicks());
    setState(() {});
  }

  handleClicks() {
    setState(() {
      if (seconds == 0) {
        timer!.cancel();
      } else {
        seconds = seconds - 1;
        current = current + 1;
        debugPrint('current: $current');
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percent = total == 0 ? 0 : (current / total);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: 'Ask ${AppStrings.appname}', actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VText(),
                ),
              );
            },
            icon: const Icon(Icons.pages))
      ]),
      body: Stack(
        children: [
          // Positioned(
          //   right: 20,
          //   top: 10,
          //   child: InkWell(
          //     onTap: () {
          //       debugPrint('tap');
          //       if (seconds == 0 && current == 0) {
          //         Picker(
          //           adapter: NumberPickerAdapter(
          //             data: <NumberPickerColumn>[
          //               const NumberPickerColumn(
          //                 begin: 5,
          //                 end: 45,
          //                 suffix: Text(' minutes'),
          //                 jump: 5,
          //               ),
          //             ],
          //           ),
          //           hideHeader: true,
          //           confirmText: 'OK',
          //           confirmTextStyle: Theme.of(context)
          //               .textTheme
          //               .displayLarge!
          //               .copyWith(color: AppColors.primary),
          //           cancelTextStyle:
          //               Theme.of(context).textTheme.displayLarge!.copyWith(),
          //           title: const Headline('Select duration'),
          //           selectedTextStyle: Theme.of(context)
          //               .textTheme
          //               .bodyLarge!
          //               .copyWith(color: AppColors.primary),
          //           onConfirm: (Picker picker, List<int> value) {
          //             Duration duration = Duration(
          //               minutes: picker.getSelectedValues()[0],
          //             );
          //             seconds = duration.inSeconds;
          //             total = seconds;
          //             setState(() {});
          //           },
          //         ).showDialog(context);
          //       } else if (seconds != 0 && current == 0) {
          //         setState(() {
          //           startTimer();
          //         });
          //       }
          //     },
          //     child: CircularPercentIndicator(
          //       radius: 30.0,
          //       lineWidth: 3.0,
          //       percent: percent,
          //       center: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Headline(
          //           "${(percent * 100).toStringAsFixed(0)}%",
          //           fontsize: 17,
          //           align: TextAlign.center,
          //         ),
          //       ),
          //       progressColor: Colors.green,
          //     ),
          //   ),
          // ),
          messages.isEmpty
              ? SingleChildScrollView(
                  padding: pageMargin,
                  child: chatting
                      ? const Text(
                          'This ChatGPT is used to coach you in a non-directive way meaning it is not meant to give you advice or tell you what to do.'
                          'The ChatGPT has been set up to ask you questions using the Sprout model in response to whatever topic you bring.'
                          'We recommend you bring a leadership challenge to be coached on. Something where the answer is complex and can’t be found using a search engine. '
                          'You can instruct the ChatGPT what you want more of or less of. '
                          'Please set the timer so we know how long we have for this coaching conversation.'
                          'Let’s being, what would you like to be coached on?')
                      // ? Column(
                      //     children: List.generate(
                      //       convoList.length,
                      //       (index) {
                      //         final message = convoList[index];
                      //         if (message.chat == 0) {
                      //           return SendMessage(
                      //             message: message,
                      //             appDirectory: appDirectory,
                      //           );
                      //         } else {
                      //           return ReceivedMessage(
                      //             message: message,
                      //             appDirectory: appDirectory,
                      //           );
                      //         }
                      //       },
                      //     ),
                      //   )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            20.vertical,
                            assetImage(
                              AppIcons.askai_logo,
                              width: 99,
                              height: 99,
                            ),
                            70.vertical,
                            // Column(
                            //   children: List.generate(
                            //     exampleList.length,
                            //     (index) {
                            //       final message = exampleList[index];
                            //       return InkWell(
                            //         onTap: () {
                            //           setState(() {
                            //             setState(() {
                            //               isResponseLoading = true;
                            //             });
                            //             getResponse(message.title);
                            //             messages.add(
                            //               Chat(msg: message.title, chat: 0),
                            //             );
                            //           });
                            //         },
                            //         child: Container(
                            //           height: 88,
                            //           width: context.width,
                            //           padding: const EdgeInsets.all(10),
                            //           margin: const EdgeInsets.only(bottom: 10),
                            //           alignment: Alignment.center,
                            //           decoration: BoxDecoration(
                            //             color: Colors.grey,
                            //             borderRadius: BorderRadius.circular(16),
                            //           ),
                            //           child: BodyText(
                            //             message.title,
                            //             align: TextAlign.center,
                            //             font: AppStrings.font,
                            //             color: Colors.white,
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            const Text(
                                '1. This ChatGPT is used to coach you in a non-directive way meaning it is not meant to give you advice or tell you what to do.\n\n'
                                '2. The ChatGPT has been set up to ask you questions using the Sprout model in response to whatever topic you bring.\n\n'
                                '3. We recommend you bring a leadership challenge to be coached on. Something where the answer is complex and can’t be found using a search engine.\n\n'
                                '4. You can instruct the ChatGPT what you want more of or less of.\n\n'
                                '5. Please set the timer so we know how long we have for this coaching conversation.\n\n'
                                '6. Let’s being, what would you like to be coached on?\n\n'),
                            20.vertical,
                          ],
                        ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.length,
                        padding:
                            const EdgeInsets.only(top: 80, left: 15, right: 15),
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          if (message.chat == 0) {
                            return SendMessage(
                              message: message,
                              appDirectory: appDirectory,
                            );
                          } else {
                            return ReceivedMessage(
                              message: message,
                              appDirectory: appDirectory,
                            );
                          }
                        },
                      ),
                    ),
                    if (isResponseLoading)
                      Row(
                        children: [
                          Container(
                            child: const SpinKitPulse(color: AppColors.primary),
                          ),
                        ],
                      ),
                  ],
                ),
        ],
      ),
      bottomNavigationBar: widget.old
          ? const SizedBox.shrink()
          : Container(
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: isRecording
                  ? Row(
                      children: [
                        Expanded(
                          child: AudioWaveforms(
                            enableGesture: true,
                            size:
                                Size(MediaQuery.of(context).size.width / 2, 50),
                            recorderController: controller,
                            waveStyle: const WaveStyle(
                              waveColor: Colors.white,
                              extendWaveform: true,
                              showMiddleLine: false,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: AppColors.primary.withOpacity(0.5),
                            ),
                            padding: const EdgeInsets.only(left: 18),
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              startOrStopRecording();
                            });
                          },
                          icon: const Icon(Icons.stop),
                          color: Colors.white,
                        ),
                      ],
                    )
                  : TextFormField(
                      controller: message,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white),
                      decoration: decoration(
                        radius: 30,
                        color: Colors.white,
                        fontFamily: GoogleFonts.fredoka().fontFamily,
                        hint: 'Type your question here',
                        hintcolor: Colors.white,
                        suffix: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                var status = await Permission.microphone.status;
                                if (status.isDenied) {
                                  await Permission.microphone.request();
                                  return;
                                }
                                speechAvailable = await speech.initialize(
                                  onStatus: (s) {},
                                  onError: (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Unable to use MicroPhone"),
                                      ),
                                    );
                                  },
                                );
                                if (speechAvailable) {
                                  speech.listen(
                                    onResult: (result) {
                                      log(result.recognizedWords);
                                      message.text = result.recognizedWords;
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Unable to use MicroPhone"),
                                    ),
                                  );
                                }
                              },
                              icon: assetImage(AppIcons.mic),
                            ),
                            IconButton(
                              onPressed: () {
                                if (message.text.isNotEmpty) {
                                  setState(() {
                                    messages
                                        .add(Chat(msg: message.text, chat: 0));
                                    getResponse(message.text);
                                    message.clear();
                                  });
                                }
                              },
                              icon: assetImage(AppIcons.send),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
    );
  }

  getResponse(String messagePrompt) async {
    submitGetChatsForm(
      context: context,
      // prompt: "$customPropmt $messagePrompt",
      prompt: "$messagePrompt",

      // I'll provide you my input in my language and please provide me response in the same language\n\n
      tokenValue: 500,
    ).then((value) async {
      final prefs = await SharedPreferences.getInstance();
      messages.addAll(value);
      isResponseLoading = false;
      chatToStore.clear();
      chatToStore.addAll(messages);
      final dataToStore =
          jsonEncode(chatToStore.map((e) => e.toJson()).toList());
      print(dataToStore);
      final date = DateTime.now().toString().split(".")[0];
      String name = "${date}_${chatToStore[0].msg}";
      log("this to store: $name");
      await prefs.setString(name, dataToStore);
      List<String> list = prefs.getStringList("oldChats") ?? [];
      if (!list.contains(name)) {
        list.add(name);
        await prefs.setStringList("oldChats", list);
      }
      setState(() {});
    });
  }

  void startOrStopRecording() async {
    try {
      if (isRecording) {
        controller.reset();
        final path = await controller.stop(false);
        if (path != null) {
          isRecordingCompleted = true;
          debugPrint(path);
          debugPrint("Recorded file size: ${File(path).lengthSync()}");
          messages.add(Chat(
            msg: 'Audio ',
            chat: 0,
          ));
        }
      } else {
        await controller.record(path: path!);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }
}
