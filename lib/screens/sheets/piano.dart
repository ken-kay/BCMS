import 'package:flutter/material.dart';

import 'package:native_pdf_view/native_pdf_view.dart';
//just for pullout menu
import 'package:bcms_app/models/side.dart';


final pdfController=PdfController(
  document: PdfDocument.openAsset('assets/Piano.pdf'),
);

Widget pdfView()=>PdfView(
  controller: pdfController,
);

class Piano extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Piano Music'),
      ),
      body: Center(
          child: PdfView(
            controller: pdfController,
          )
      ),
      drawer: Side(),
    );
  }
}