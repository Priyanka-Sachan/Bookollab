import 'package:bookollab/Models/maindisp_book_info_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bookollab/Models/homepage_items_featured.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:jiffy/jiffy.dart';

class Failed_transaction extends StatefulWidget {
  static String id='Failed_transaction_Screen';
  @override
  _Failed_transactionState createState() => _Failed_transactionState();
}

class _Failed_transactionState extends State<Failed_transaction> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
