import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
//just for pullout menu
import 'package:bcms_app/models/side.dart';


class Sheets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sheet Music'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[


          FlatButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => PDFViewerFromAsset(
                  pdfAssetPath: 'assets/Guitar.pdf',
                ),
              ),
            ),
            hoverColor: Colors.yellow,
            color: Colors.black12,
            child: const Text('Guitar'),
          ),


          FlatButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => PDFViewerFromAsset(
                  pdfAssetPath: 'assets/Piano.pdf',
                ),
              ),
            ),
            hoverColor: Colors.yellow,
            color: Colors.black12,
            child: const Text('Piano'),
          ),


          FlatButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => PDFViewerFromAsset(
                  pdfAssetPath: 'assets/Violin.pdf',
                ),
              ),
            ),
            hoverColor: Colors.yellow,
            color: Colors.black12,
            child: const Text('Violin'),
          ),

        ],
      ),
      drawer: Side(),
    );
  }
}


class PDFViewerFromAsset extends StatelessWidget {
  PDFViewerFromAsset({Key key, @required this.pdfAssetPath}) : super(key: key);
  final String pdfAssetPath;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF From Asset'),
        actions: <Widget>[
          StreamBuilder<String>(
              stream: _pageCountController.stream,
              builder: (_, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[900],
                      ),
                      child: Text(snapshot.data),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ],
      ),
      body: PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onPageChanged: (int current, int total) =>
            _pageCountController.add('${current + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage();
          final int pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        },
      ).fromAsset(
        pdfAssetPath,
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _pdfViewController.future,
        builder: (_, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: '-',
                  child: const Text('-'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        await pdfController.getCurrentPage() - 1;
                    if (currentPage >= 0) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
                FloatingActionButton(
                  heroTag: '+',
                  child: const Text('+'),
                  onPressed: () async {
                    final PDFViewController pdfController = snapshot.data;
                    final int currentPage =
                        await pdfController.getCurrentPage() + 1;
                    final int numberOfPages =
                    await pdfController.getPageCount();
                    if (numberOfPages > currentPage) {
                      await pdfController.setPage(currentPage);
                    }
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      drawer: Side(),
    );
  }
}