import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mini_project/components/newsComponent.dart';
import 'package:flutter_mini_project/providers/news_provider.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NewsProvider>(context, listen: false).getTopNews();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (BuildContext context, news, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Berita'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              news.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        ...news.resNews!.articles!.map(
                          (e) => newsComponent(
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
