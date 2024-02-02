import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../errors/exceptions.dart';
import '../models/chat.dart';
import '../models/images.dart';
import '../models/model.dart';
import '../utils/constants.dart';
import 'error_message.dart';
import 'network_client.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:langchain_pinecone/langchain_pinecone.dart';

Future<List<Images>> submitGetImagesForm({
  required BuildContext context,
  required String prompt,
  required int n,
}) async {
  //
  NetworkClient networkClient = NetworkClient();
  List<Images> imagesList = [];
  try {
    final res = await networkClient.post(
      '${BASE_URL}images/generations',
      {"prompt": prompt, "n": n, "size": "1024x1024"},
      token: OPEN_API_KEY,
    );
    Map<String, dynamic> mp = jsonDecode(res.toString());
    debugPrint(mp.toString());
    if (mp['data'].length > 0) {
      imagesList = List.generate(mp['data'].length, (i) {
        return Images.fromJson(<String, dynamic>{
          'url': mp['data'][i]['url'],
        });
      });
      debugPrint(imagesList.toString());
    }
  } on RemoteException catch (e) {
    Logger().e(e.dioError);
    errorMessage(context);
  }
  return imagesList;
}

Future<List<Chat>> submitGetChatsForm({
  required BuildContext context,
  required String prompt,
  required int tokenValue,
  String? model,
}) async {
  //
  NetworkClient networkClient = NetworkClient();
  List<Chat> chatList = [];
  try {
    // final openaiApiKey = Platform
    //     .environment['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']!;
    // final pineconeApiKey =
    //     Platform.environment['2e13ee6b-e229-4546-a5e7-995b4bb809dd']!;
    // final embeddings = OpenAIEmbeddings(apiKey: openaiApiKey);
    // final vectorStore = Pinecone(
    //   apiKey: pineconeApiKey,
    //   indexName: 'ask-pdf-index1',
    //   embeddings: embeddings,
    // );

    // // Add documents to the vector store
    // await vectorStore.addDocuments(
    //   documents: const [
    //     Document(
    //       id: '1',
    //       pageContent: 'The cat sat on the mat',
    //       metadata: {'cat': 'animal'},
    //     ),
    //     Document(
    //       id: '2',
    //       pageContent: 'The dog chased the ball.',
    //       metadata: {'cat': 'animal'},
    //     ),
    //     Document(
    //       id: '3',
    //       pageContent: 'The boy ate the apple.',
    //       metadata: {'cat': 'person'},
    //     ),
    //     Document(
    //       id: '4',
    //       pageContent: 'The girl drank the milk.',
    //       metadata: {'cat': 'person'},
    //     ),
    //     Document(
    //       id: '5',
    //       pageContent: 'The sun is shining.',
    //       metadata: {'cat': 'natural'},
    //     ),
    //   ],
    // );

    // // Query the vector store
    // final res = await vectorStore.similaritySearch(
    //   query: prompt.toString(),
    //   config: const PineconeSimilaritySearch(
    //     k: 2,
    //     scoreThreshold: 0.4,
    //     filter: {'cat': 'person'},
    //   ),
    // );

    // debugPrint("👉 embedding: $res");
    String docText = """    Sprout: a simple and accessible coaching model
      A SIMPLE AND ACCESSIBLECOACHING MODELEd Temple, MCC
      The Leaderas COACH
      
      The Leader as Coach
      SPROUT: A SIMPLE AND ACCESSIBLE
      COACHING MODEL
      Ed Temple, MCC
      
      4
      The Leader as Coach
      Acknowledgements
      Part 1 | Context for Coaching
      1. 
      My Coaching Origin Story
      2. 
      Handbook Introduction
      3. 
      Sprout Coaching App
      4. 
      When do Leaders Coach?
      4.1.
       Directive vs Non-Directive
      4.2.
       Types of Feedback Conversation
      5.
       Introduction to the Sprout Coaching Model
      6.
       Sprout Visual and Icons
      7. 
      Chapter Concepts
      7.1. 
      Table of Concepts
      Part 2 | Coaching with Sprout
      8. 
      Plant
      8.1. 
      Coaching Example
      8.2. 
      Plant | Topic and Goal
      8.3. 
      Plant Application
      9. 
      Water
      9.1. 
      Coaching Example
      9.2.
       Water | Explore and Dream
      9.3.
       Water Application
      10. 
      Prune
      10.1. 
      Coaching Example
      10.2. 
      Prune | Narrow and Choose
      10.3. 
      Prune Application
      11. 
      Harvest
      11.1. 
      Coaching Example
      11.2. 
      Harvest | Learn and Commit
      11.3. 
      Harvest Application
      12. 
      Cultivating Coaching Conversations
      13. 
      Conclusion
      5
      Sprout: a simple and accessible coaching model
      Appendices
      Appendix A | Intro to Coaching Examples Using Sprout
      Appendix B | Coaching Example | Work Life Balance 
      Appendix C | Coaching Example | Advancing Career
      Appendix D | Coaching Example | Difficult Employee
      Appendix E | Coaching Example | Challenging Project
      Appendix F | Sprout and ICF Core Competencies 
      Appendix G | Visual of Sprout and ICF Core Competencies 
      Appendix H | Table of Concepts Summary
      About the Author
      Opportunities for Next Steps
      
      6
      The Leader as Coach
      “Through his own dedicated commitment to self and others, 
      Ed delivers a resource that supports leaders in applying the 
      foundations of coaching in all areas of life.  As a colleague and 
      friend who has personally felt the impact of Ed’s gifts, you’ll find his 
      wisdom comes from an applied, practical perspective. If your goals .  The Leader as Coach
      “Technology is best when it brings people together.”
      Matt Mullenweg
      Introducing the user-friendly Sprout app – your ultimate 
      companion on the journey to becoming a skilled leader as coach. 
      Download the Sprout app in the app store searching under 
      “Sprout Coaching.” The Sprout app is a tool to help you develop 
      coaching skills as a leader. The Doing part associated with the Plant phase of the Sprout 
      non-directive coaching model involves specific actions aimed 
      at facilitating coachee growth and exploration.""";
    final pj =
        OpenAI(apiKey: "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");
    debugPrint("✌${docText.length}");
    // Example messages for conversation with OpenAI
    final messages = [
      ChatMessage.system(
          "answer related this document text: ${docText.toString()}"),
      ChatMessage.humanText(prompt),
    ];

    // Use OpenAI to predict messages
    final sos = await pj.predictMessages(messages);
    String data =
        sos.contentAsString.replaceAll(RegExp(r'^\s*', multiLine: true), '');
    // chatList.add(sos.toString());
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(data.toString()),
    //     duration: const Duration(seconds: 5),
    //     action: SnackBarAction(
    //       label: 'Undo',
    //       onPressed: () {},
    //     ),
    //   ),
    // );
    int data1 = data.indexOf(':');
    String data2 = '';
    if (data1 != -1) {
      data2 = data.substring(data1 + 1).trim();
    } else {
      data2 = data;
    }
    debugPrint("👉 answer: $data");
    chatList.add(Chat.fromJson({
      'msg': data2.toString(),
      'chat': 1,
    }));

    return chatList;
    // print(res);
    // final res = await networkClient.post(
    //   "${BASE_URL}completions",
    //   {
    //     "model": model ?? "text-davinci-003",
    //     "prompt": prompt,
    //     "temperature": 0,
    //     "max_tokens": tokenValue
    //   },
    //   token: OPEN_API_KEY,
    // );
    // Map<String, dynamic> mp = jsonDecode(res.toString());
    // debugPrint(mp.toString());
    // if (mp['choices'].length > 0) {
    //   chatList = List.generate(mp['choices'].length, (i) {
    //     return Chat.fromJson(<String, dynamic>{
    //       'msg': mp['choices'][i]['text'],
    //       'chat': 1,
    //     });
    //   });
    //   debugPrint(chatList.toString());
    // }
  } on RemoteException catch (e) {
    log("$e");
    Logger().e(e.dioError);
    errorMessage(context);
  }
  return chatList;
}

Future<List<Model>> submitGetModelsForm({
  required BuildContext context,
}) async {
  //
  NetworkClient networkClient = NetworkClient();
  List<Model> modelsList = [];
  try {
    final res = await networkClient.get(
      "${BASE_URL}models",
      token: OPEN_API_KEY,
    );
    Map<String, dynamic> mp = jsonDecode(res.toString());
    debugPrint(mp.toString());
    if (mp['data'].length > 0) {
      modelsList = List.generate(mp['data'].length, (i) {
        return Model.fromJson(<String, dynamic>{
          'id': mp['data'][i]['id'],
          'created': mp['data'][i]['created'],
          'root': mp['data'][i]['root'],
        });
      });
      debugPrint(modelsList.toString());
    }
  } on RemoteException catch (e) {
    Logger().e(e.dioError);
    errorMessage(context);
  }
  return modelsList;
}
