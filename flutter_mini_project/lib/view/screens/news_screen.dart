import 'package:flutter/material.dart';
import 'package:flutter_mini_project/components/news_component.dart';
import 'package:flutter_mini_project/viewmodel/providers/news_provider.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getNewsNow();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (BuildContext context, news, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('News'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              news.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        ...news.resNews!.articles!.map(
                          (e) => NewsComponent(
                            newsTitle: e.title ?? " ",
                            newsimage: e.urlToImage ?? " ",
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      );
    });
  }
}
