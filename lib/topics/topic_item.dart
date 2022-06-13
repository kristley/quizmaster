import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:quizmaster/services/firestore.dart';
import '../services/models.dart';
import '../shared/loading.dart';

class TopicItem extends StatelessWidget {
  final Topic topic;
  const TopicItem({ Key? key, required this.topic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreService.downloadURL(topic.img),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingScreen();
        }
        var defaultImage = Image.asset('assets/default.png', fit: BoxFit.contain);
        var image = snapshot.hasData
            ? CachedNetworkImage(imageUrl : snapshot.data!, placeholder: (_, __) => defaultImage, fit: BoxFit.contain)
            : defaultImage;
        return Hero(
          tag: topic.img,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => TopicScreen(topic: topic, imageUrl: snapshot.data!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: SizedBox(
                      child: image
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        topic.title,
                        style: const TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                  ),
                  //Flexible(child: TopicProgress(topic: topic)),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
class TopicScreen extends StatelessWidget {
  final Topic topic;
  final String imageUrl;

  const TopicScreen({Key? key,required this.topic, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: topic.img,
          child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: MediaQuery.of(context).size.width,
          ),
        ),
        Text(
          topic.title,
          style:
          const TextStyle(height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}