/*
//worked a bit
import 'package:flutter/material.dart';

import 'package:native_pdf_view/native_pdf_view.dart';
//just for pullout menu
import 'package:bcms_app/models/side.dart';


final pdfController=PdfController(
  document: PdfDocument.openAsset('assets/Suzuki_Violin.pdf'),
);

Widget pdfView()=>PdfView(
  controller: pdfController,
);

class Sheets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sheet Music'),
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


/*
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:native_pdf_view/native_pdf_view.dart';
//import 'package:native_pdf_view_example/has_support.dart';
//just for pullout menu
import 'package:bcms_app/models/side.dart';

class Sheets extends StatelessWidget {

  Future<PdfDocument> _getDocument()async{
      return PdfDocument.openAsset('assets/First.pdf');
  }

  @override
  Widget build(BuildContext context)=>MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sheet Music')
        ),
          body:FutureBuilder<PdfDocument>(
          future: _getDocument(),
            builder: (_, snapshot){
            if(snapshot.hasData) {
              return PDFView(
                document: snapshot.data,
              );
            }
              if (snapshot.hasError){
                return Center(
                  child: Text(
                    'PDF unavailable',
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
        ),
      ),
    );
}
*/






/*import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
//For the pullout menu
import 'package:bcms_app/models/side.dart';

class Sheets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sheet Music',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Paper(),
    );
  }
}

class Paper extends StatefulWidget {
  @override
  _PaperState createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  String url="https://www.something.com/pdf.pdf";
  String pdfasset = "assets/PDF/First.pdf";
  PDFDocument _doc;
  bool _loading;

  @override
  void initState(){
    super.initState();
    _initPdf();
  }

  _initPdf()async{
    setState(() {
      _loading=true;
    });
    final doc=await PDFDocument.fromURL(url);
    setState(() {
      _doc=doc;
      _loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDFs"),
      ),
      body: _loading ? Center(child: CircularProgressIndicator(),) :PDFViewer(document: _doc,
      indicatorBackground: Colors.green,
      ),
    );
  }
}


 */



/*
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

//For the pullout menu
import 'package:bcms_app/models/side.dart';

class Sheets extends StatefulWidget {
  @override
  _SheetsState createState() => _SheetsState();
}

class _SheetsState extends State<Sheets> {
  String _version='Unknown';
  String _document="https://pdftron.s3.amazonaws.com/downloads/pl/PDFTRON_mobile_about.pdf";

  @override
  void initState(){
    super.initState();
    initPlatformState();
    showViewer();


  }

  Future<void> initPlatformState() async{
    String version;
    //use try and catch
    try{
      PdftronFlutter.initialize("your_pdftron_license_key");
      version=await PdftronFlutter.version;
    } on PlatformException{
      version='Failed to get platform version.';
    }

    if(!mounted)return;

    setState((){
      _version=version;
    });
  }

  void showViewer(){
    var config=Config();
    PdftronFlutter.openDocument(_document, config:config);
  }

  @override
    Widget build(BuildContext context){
  return MaterialApp(
    home:Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      drawer: Side(),
    ),
  );
  }
  void _onDocumentViewCreated(DocumentViewController controller){
    controller.openDocument(_document);
  }
}
*/


  /*Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text ('View PDFs'),
        ),
        body: Center(
          child: Text('running: $_version\n'),
        ),
      ),
    );
  }
}

   */


/*
//This one didn't work

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
//if using the internet:
import 'package:http/http.dart' as http;
//For the pullout menu
import 'package:bcms_app/models/side.dart';
//import 'package:bcms_app/models/side.dart';

class Sheets extends StatefulWidget {
  @override
  _SheetsState createState() => _SheetsState();
}

class _SheetsState extends State<Sheets> {
  String assetPDFPath="";
  String urlPDFPath="";
  @override
  void initState(){
    super.initState();

    //For local files
    getFileFromAsset("assets/PDFs/First.pdf").then((f){
      setState(() {
        assetPDFPath=f.path;
        print(assetPDFPath);
      });
    });

    //For URLs
    getFileFromUrl("http://www.pdf995.com/samples/pdf.pdf").then((f){
      setState(() {
        urlPDFPath=f.path;
        print(urlPDFPath);
      });
    });

  }

  Future<File>getFileFromAsset(String asset)async{
    try{
      var data=await rootBundle.load(asset);
      var bytes=data.buffer.asUint8List();
      var dir=await getApplicationDocumentsDirectory();
      //this is for loading the PDFs so see about making more
      File file=File("${dir.path}/First.pdf");
      File assetFile=await file.writeAsBytes(bytes);
      return assetFile;
    }catch (e){
      throw Exception("Error opening PDF");
    }
  }

  //For online PDFs
  Future<File>getFileFromUrl(String url)async{
    try{
      var data=await http.get(url);
      var bytes=data.bodyBytes;
      var dir=await getApplicationDocumentsDirectory();
      File file=File("${dir.path}/mypdfonline.pdf");
      File urlFile=await file.writeAsBytes(bytes);
      return urlFile;
    }catch(e){
      throw Exception("Error opening online PDF");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sheet Music"),
        ),
        body: Center(
          child: Builder(
            builder: (context)=>Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color:Colors.amber,
                  child: Text("Open Online PDF"),
                  onPressed: (){
                    if(urlPDFPath!=null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>
                              PdfViewPage(path:assetPDFPath)
                        )
                      );

                    }
                  },
                ),

                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.cyan,
                  child: Text("Open PDF"),
                  onPressed: (){
                    if(assetPDFPath!=null){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>
                              PdfViewPage(path:assetPDFPath)
                        )
                      );

                    }
                  },
                )
              ],
            ),
          ),

        ),
      ),
    );
  }
}

class PdfViewPage extends StatefulWidget {
  final String path;
  const PdfViewPage({Key key,this.path}):super(key:key);

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages=0;
  int _currentPage=0;
  bool pdfReady=false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Side(),
      appBar: AppBar(
        title: Text("Files"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            //nightMode:true,
            nightMode: false,
            onError: (e){
              print(e);
            },
            onRender: (_pages){
              setState(() {
                _totalPages=_pages;
                pdfReady=true;
              });
            },
            onViewCreated: (PDFViewController vc){
              _pdfViewController=vc;
            },
            onPageChanged: (int page,int total){
              setState(() {});
            },
            onPageError: (page,e){},
          ),
          !pdfReady
            ?Center(
            child: CircularProgressIndicator(),
          )
              :Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage>0
          ?FloatingActionButton.extended(
              backgroundColor: Colors.red,
              label:Text("Turn to ${_currentPage-1}"),
              onPressed: (){
                _currentPage-=1;
                _pdfViewController.setPage(_currentPage);
              },
          )
              :Offstage(),
          _currentPage+1<_totalPages
          ?FloatingActionButton.extended(
            label: Text("Turn to ${_currentPage+1}"),
              onPressed: (){
              _currentPage+=1;
              _pdfViewController.setPage(_currentPage);
              },
          )
              :Offstage(),
        ],
      ),
    );
  }
}
*/


/*import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

//for the pullout
import 'package:bcms_app/models/side.dart';

const String _documentPath=('/assets/PDFs/An End, Once and For All.pdf');

/*class Pieces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Practice",
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Pieces(),
    );
  }
}
 */
class Sheets extends StatefulWidget{
  Sheets({Key key}):super(key:key);
  @override
  _SheetsState createState()=>_SheetsState();
}

class _SheetsState extends State<Sheets>{
  //to move the PDF so it can be viewed in app
  Future<String>prepareTestPdf()async{
    final ByteData bytes=
        await DefaultAssetBundle.of(context).load(_documentPath);
    final Uint8List list=bytes.buffer.asUint8List();
    final tempDir=await getTemporaryDirectory();
    final tempDocumentPath='${tempDir.path}/$_documentPath';
    final file=await File(tempDocumentPath).create(recursive:true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF"),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () =>{
                prepareTestPdf().then((path){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder:(context)=>PdfView(path)),
                  );
                })
              },
              child: const Text('open pdf'),
            ),
          ],
        ),
      ),
      drawer: Side(),
    );
  }
}

class PdfView extends StatelessWidget {

  final String pdfPath;
  PdfView(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text("Music"),
      ),
      path: pdfPath
    );
  }
}

 */

/*class Pieces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      drawer: Side(),
    );
  }
}

 */

/*
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class Sheets extends StatefulWidget {
  @override
  _SheetsState createState() => _SheetsState();
}

class _SheetsState extends State<Sheets> {
  String pathPDF="";

  @override
  void initState(){
    super.initState();
    createFileOfPdfUrl().then((f){
      setState((){
        pathPDF=f.path;
        print(pathPDF);
      });
    });
  }
  Future<File>createFileOfPdfUrl()async{
    final url
  }
}


 */