import 'package:flutter/material.dart';
import 'package:quizmaster/shared/loading.dart';
import 'package:quizmaster/topics/topic_item.dart';
import '../services/firestore.dart';
import '../services/models.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen>
    with AutomaticKeepAliveClientMixin<TopicsScreen>{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Topics'),
      ),
      body: FutureBuilder<List<Topic>>(
        future : FirestoreService.getTopics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Text('No topics found in Firestore. Check database');
          }
          var topics = snapshot.data!;
          return GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20.0),
            crossAxisSpacing: 10.0,
            crossAxisCount: 2,
            children: topics.map((topic) => TopicItem(topic: topic))
                .toList(),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}