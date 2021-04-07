import 'package:flutter/material.dart';

import 'package:native_pdf_view/native_pdf_view.dart';
//just for pullout menu
import 'package:bcms_app/models/side.dart';

class Violin extends StatelessWidget {
  //@override
  Widget pdfView() => FutureBuilder<PDFDocument>(
    //asset
      future: PDFDocument.openAsset('assets/Violin.pdf'),
      builder: (_,snapshot){
        return PDFView(document: snapshot.data);
      }
  );

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Side(),
    );
  }
}


/*
final pdfController=PdfController(
  document: PdfDocument.openAsset('assets/Suzuki_Violin.pdf'),
);

Widget pdfView()=>PdfView(
  controller: pdfController,
);

class Violin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Violin Music'),
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

 */