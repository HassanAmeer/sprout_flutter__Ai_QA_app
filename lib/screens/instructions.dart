import 'package:flutter/material.dart';

class Instructions extends StatelessWidget {
  Instructions({super.key, required this.name, required this.index});
  final String name;
  final int index;

  final List<String> data = [
    '''
For coaching practice of direct leaders, peers, supervisors or others.

 1. Set an agreed among of time.

 2. Use the Sprout questions to coach working through the whole model. 

 3. After the coaching practice debrief with the Coachee with these questions:

    a. What did you notice about the coaching process?
    b. What was helpful about the coaching?
    c. What would you want more or less of?
''',
    '''
For coaching practice within a cohort of 3-4 like-minded learners. 

 1. Choose roles in the Pod for practice (Coach, Coachee and Observer/s).

 2. Set the time for the coaching practice.

 3. Use the Sprout questions to coach working through the whole model. 

 4. After the coaching practice the Observer facilitates the conversation with these questions:

   a. What did you do well in your coaching? (Coach)
   b. If you tried again, what would you change? (Coach)
   c. What did you gain from being coached? (Coachee)
   d. Observer: Provide strength-based feedback observations

''',
    '''
For coaching practice with a like minded leader also learning coaching skills through Sprout. 

 1. Set the time for the coaching practice. 

 2. Use the Sprout questions to coach working through the whole model. 

 3. After the coaching discuss the following:

   a. What did the Coach feel they did well?
   b. What was the impact on the Coachee?
   c. If the coach could redo the conversation, what would they change?
   d. What did the Coachee notice about the Coach’s approach?

'''
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          data[index],
        ),
      ),
    );
  }
}
