
import 'package:bookollab/UI/ProfilePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'dart:io';
import 'package:images_picker/images_picker.dart';
import 'maindisplaypage.dart';

import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _firestore=FirebaseFirestore.instance;
FirebaseStorage _firebaseStorage=FirebaseStorage.instance;
class AddBookPage extends StatefulWidget {
  static String id='AddBookPage_Screen';
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage>  {



  String _scanBarcode = '';
  TextEditingController _controller;
  File _ImageFile;
  String barcoderesult = "";
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  String BookName="",Author="",condition="",bkdesc="";
  double MRP=0;
  double quotedprice=0;

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFCC00),
        shadowColor: Color(0xFFF7C100),
      ),
        bottomSheet:RaisedButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical:13.0,horizontal: 13),
            child: Container(
              width: width,
              height: 25,
              child: Center(
                child: FittedBox(
                  child: Row(
                    children: [
                      Icon(Icons.book_outlined),
                      Text(' Submit',style: TextStyle(
                          fontFamily: 'LeelawUI',
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
              ),
            ),
          ),
          color: Color(0xFFFFCC00),

          onPressed: () async{
            if(check(BookName,condition,MRP,quotedprice,_ImageFile)){
              //checks passed
              //backend starts
              String useruid=FirebaseAuth.instance.currentUser.uid;
              String uploadname=useruid+DateTime.now().toString()+BookName;
              var reference=_firebaseStorage.ref()
                  .child('BookFrontCovers')
                  .child('/${uploadname}.jpg');
              reference.putFile(_ImageFile).then((val){
                val.ref.getDownloadURL().then((value) {
                  _firestore.collection("Book_Collection").doc().set({
                    "Author":Author,
                    "Availability":true,
                    "BookName":BookName,
                    "Condition":"Used",
                    "Condition Description":condition,
                    "Dislikes":0,
                    "Homepage_category":"Best Rated",
                    "ISBN":_controller.value.text.toString(),
                    "ImageUrl":value.toString(),
                    "Likes":0,
                    "Long Description":bkdesc,
                    "MRP":MRP,
                    "OwnerRatings":"5",
                    "OwnerUID":useruid,
                    "Quantity":1,
                    "QuotedDeposit":quotedprice,
                    "category":"Unknown",
                  });
                }).then((value) {
                  _onBasicSuccessAlert(context, "Book has been successfully added");
                  Navigator.pop(context);
                });
              });
            }
          },

        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Book Name",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "LeelawUI",
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value){
                        BookName =value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[290],
                        hintText: "Type your Book Name..",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Author",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "LeelawUI",
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Container(
                              width: width/2.5,
                                child: TextField(
                                  onChanged: (value){
                                    Author =value;
                                  },
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[290],
                                    hintText: "Optional",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Condition",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "LeelawUI",
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Container(
                              width: width/2.5,
                                child: TextField(
                                  onChanged: (value){
                                    condition =value;
                                  },
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[290],
                                    hintText: "Used or New",
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("ISBN (Optional)",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "LeelawUI",
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: _controller,
                            onChanged: (value){
                              _scanBarcode =value;
                            },
                            autocorrect: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[290],
                              hintText: "Scan QR or type manually",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.camera_alt), onPressed:(){
                          //_scanQR();
                          scanBarcodeNormal();
                          setState(() {
                            
                          });
                        })
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("MRP",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "LeelawUI",
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Container(
                              width: width/2.5,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  MRP =double.parse(value);
                                },
                                autocorrect: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[290],
                                  hintText: "Enter MRP",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Quoted Price",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "LeelawUI",
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                            Container(
                              width: width/2.5,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                onChanged: (value){
//                                  if(double.parse(value)>(60/100)*MRP){
//                                    quotedprice =(60/100)*MRP;
//                                  }else{
                                    quotedprice=double.parse(value);
                                  //}

                                },
                                autocorrect: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[290],
                                  hintText: " < 60% of MRP",
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Book Description (Optional)",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "LeelawUI",
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value){
                        bkdesc =value;
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[290],
                        hintText: "Enter Info of Book..",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Upload Front Book Cover",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "LeelawUI",
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:13.0,horizontal: 13),
                      child: Container(
                        width: width,
                        height: 25,
                        child: Center(
                          child: FittedBox(
                            child: Row(
                              children: [
                                Icon(Icons.camera_alt),
                                Text(' Capture',style: TextStyle(
                                    fontFamily: 'LeelawUI',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    color: Color(0xFFFFCC00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21),
                    ),
                    onPressed: () async{
                      print("camera");
                      List<Media> res = await ImagesPicker.openCamera(
                        cropOpt: CropOption(
                          aspectRatio: CropAspectRatio.custom,
                          cropType: CropType.rect,
                        ),
                        pickType: PickType.image,
                      );
                      if(res!=null){
                        _ImageFile=File(res[0].path);
                      }else{
                        print("not wrking or null return");
                      }
                    },

                  ),
                  SizedBox(height: 50,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes="";
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      if(barcodeScanRes=="-1"){
        _controller.clear();
      }
      else{
        _controller = new TextEditingController(text: barcodeScanRes);
        _scanBarcode = barcodeScanRes;
      }

    });
  }


  _getFromGallery() async {
    // File pickedFile = await ImagePicker.pickImage(
    //   source: ImageSource.camera,
    //   maxWidth: 500,
    //   maxHeight: 500,
    // );
    // if(pickedFile!=null){
    //   // _cropImage(pickedFile.path);
    // }
  }

  /// Crop Image
  _cropImage(filePath) async {
    // File croppedImage = await ImageCropper.cropImage(
    //   sourcePath: filePath,
    //
    //
    //     aspectRatioPresets: [
    //       CropAspectRatioPreset.original,
    //     ],
    //     androidUiSettings: AndroidUiSettings(
    //         toolbarTitle: 'Cropper',
    //         toolbarColor: Color(0xFFF7C100),
    //         toolbarWidgetColor: Colors.white,
    //         initAspectRatio: CropAspectRatioPreset.ratio5x4,
    //         lockAspectRatio: false),
    //     iosUiSettings: IOSUiSettings(
    //       minimumAspectRatio: 1.0,
    //     )
    // );
    // _ImageFile=croppedImage??_ImageFile;
    // print("Successfully Cropped");
  }

  bool check(String bookName, String condition, double mrp, double quotedprice, File imageFile) {
    if(bookName.trim()==""||bookName.trim().isEmpty||bookName.trim().length==0){
      _onBasicWaitingAlertPressed(context,"BookName can't be Empty");
      return false;
    }
    if(condition.trim()==""||condition.trim().isEmpty||condition.trim().length==0){
      _onBasicWaitingAlertPressed(context,"Condition field can't be Empty");
      return false;
    }
    if(mrp==0||mrp.isNaN){
      _onBasicWaitingAlertPressed(context,"Recheck MRP Field");
      return false;
    }
    if(quotedprice>(60/100)*mrp){
      _onBasicWaitingAlertPressed(context,"Quoted Price should be <= 60 % of MRP");
      return false;
    }
    if(imageFile==null){
      _onBasicWaitingAlertPressed(context,"Please Upload Front cover of Book");
      return false;
    }
    return true;
  }
//validating user fields
  _onBasicWaitingAlertPressed(context,String descrip) async {
    await Alert(
      type: AlertType.error,
      context: context,
      title: "Warning",
      desc: descrip,
    ).show();
    // Code will continue after alert is closed.
    debugPrint("Alert closed now.");
  }
  _onBasicSuccessAlert(context,String descrip) async {
    await Alert(
      type: AlertType.success,
      context: context,
      title: "Success",
      desc: descrip,
    ).show();
    // Code will continue after alert is closed.
    debugPrint("Alert closed now.");
  }

}

