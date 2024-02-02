import 'package:sprout/constants/strings.dart';
import 'package:sprout/model/app_model.dart';
import 'package:sprout/models/chat.dart';

List<AppModel> exampleList = <AppModel>[
  AppModel(
    'ChatGPT is an artificial-intelligence chatbot developed by Open AI',
    0,
  ),
  AppModel(
    'ChatGPT launched in November 2022.',
    0,
  ),
  AppModel(
    'ChatGPT is an artificial-intelligence chatbot developed by OpenAI',
    0,
  ),
];

List<Chat> convoList = <Chat>[
  Chat(msg: 'Hello ! there', chat: 0),
  Chat(msg: 'Hello there! How may I assist you today?', chat: 1),
  Chat(msg: 'Show me what can you do?', chat: 0),
  Chat(
    msg:
        'As an AI language model, I can generate text for various purposes such as :\n'
        '\n${AppStrings.bullet} Writing articles, essays and reports on various topics.\n'
        '\n${AppStrings.bullet} Generating product descriptions and reviews.\n'
        '\n${AppStrings.bullet} Tra|',
    chat: 1,
  ),
];

List<String> harvest = <String>[
  'What action will you commit to?',
  'How will you celebrate this?',
  'What do you envision will happen now?',
  'What image or symbol represents your learning',
  'What will you be most proud of in future?',
  'How will you ensure to capture your learning?',
  'What have you learned about yourself?',
  'How will you hold yourself accountable?',
  'How this learning applied to what you wanted?',
  'What do you need to acknowledge for yourself?',
  'What progress have you made?',
  'Who do you need to tell this about?',
];

List<String> prune = <String>[
  'What would you do, if nothing was holding you back?',
  'What can you change?',
  'What have you not considered?',
  'What have you not yet tried?',
  'What is holding you back?',
  'What belief could you change about this topic?',
  'What will matter about this in future?',
  'What have you not tried?',
  'What does your gut tell you?',
  'What is the impact if you do nothing?',
  'What is currently working?',
  'What part of this is easy?',
];

List<String> water = <String>[
  'What are you learning from this?',
  'How does your enivronment shape your thinking about this topic?',
  'How do you feel about this?',
  'What past experience can you draw from?',
  'Years from now, what advice would you give yourself?',
  'What resources do you have that can help?',
  'What else is connected to this topic?',
  'How do your values shape your thinking on this?',
  'What is possible?',
  'What are you telling yourself that is getting in the way?',
  'What would you do if you did not care what people thought?',
  'What is clear about this?',
];

List<String> plant = <String>[
  'What do you want to be coached on?',
  'What is getting in the way of what you want?',
  'What makes this important to you today?',
  'How will you know we were successful?',
  'What makes this relevant today?',
  'What are your concerns related to this?',
  'What do you want to walk away with?',
  'What part of this topic is most relevant to explore?',
  'Where do we need to explore further?',
  'What is your goal for this conversation?',
  'How does this fit with other priorities?',
  'What do you need from this situation?',
];
