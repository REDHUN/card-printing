import 'package:cardprinting/widgets/pdfpreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();

  final _commentController = TextEditingController();
  void previewScreen() async {
    final backgroundImage = pw.MemoryImage(
        (await rootBundle.load('assets/background.jpg')).buffer.asUint8List());
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        // pageTheme: pw.PageTheme(
        //   textDirection: pw.TextDirection.ltr,
        //   buildBackground: (context) => pw.FullPage(R
        //       ignoreMargins: true, child: pw.Image(backgroundImage)),
        // ),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            width: 800,
            decoration: pw.BoxDecoration(
              image: pw.DecorationImage(image: backgroundImage),
              borderRadius: pw.BorderRadius.circular(30),
            ),
            child: pw.Column(children: [
              pw.Text('Welcome',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 50)),
              pw.Text(
                _nameController.text,
                style: const pw.TextStyle(
                    fontSize: 70, color: PdfColor.fromInt(0xff1565c0)),
              ),
              pw.SizedBox(
                height: 40,
              ),
              pw.Text(
                _commentController.text,
                style: const pw.TextStyle(
                    fontSize: 70, color: PdfColor.fromInt(0xff1565c0)),
              ),
            ]),
          );
        },
      ),
    );
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfPrevie(doc: doc),
        ));
  }

  void printScreen() async {
    final doc = pw.Document();

    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            width: 800,
            decoration: pw.BoxDecoration(
              //image: pw.DecorationImage(image: backgroundImage),
              borderRadius: pw.BorderRadius.circular(30),
            ),
            child: pw.Column(children: [
              pw.Text('Welcome',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 50)),
              pw.Text(
                _nameController.text,
                style: pw.TextStyle(
                    fontSize: 70, color: PdfColor.fromInt(0xff1565c0)),
              ),
            ]),
          );
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).copyWith().primaryColorLight,
          //     gradient: LinearGradient(
          //   colors: [
          //     Color.fromARGB(255, 117, 4, 223),
          //     Color.fromARGB(31, 57, 37, 73)
          //   ],
          //   begin: Alignment.bottomLeft,
          //   end: Alignment.topRight,
          // ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  label: Text(
                    'Name',
                    style: TextStyle(color: Colors.white),
                    selectionColor: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30), right: Radius.circular(30)),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 4.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(30),
                          right: Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.white, width: 4.0)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 160,
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 80.0),
                    label: Text(
                      'Comments',
                      style: TextStyle(color: Colors.white),
                      selectionColor: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30)),
                        borderSide:
                            BorderSide(color: Colors.white, width: 4.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30)),
                        borderSide:
                            BorderSide(color: Colors.white, width: 4.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: previewScreen,
                    child: const Text('Preview'),
                  ),
                  ElevatedButton(
                      onPressed: printScreen, child: const Text('Print')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
