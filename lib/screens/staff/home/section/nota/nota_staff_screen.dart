import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:printing/printing.dart';
import 'package:staff_cleaner/screens/staff/home/section/nota/pdf/pdf_nota_digital.dart';

class NotaStaffScreen extends StatefulWidget {
  final String noSurat;
  final QueryDocumentSnapshot<Map<String, dynamic>> item;
  final User? user;
  const NotaStaffScreen({super.key, required this.noSurat, required this.item, required this.user});

  @override
  State<NotaStaffScreen> createState() => _NotaStaffScreenState();
}

class _NotaStaffScreenState extends State<NotaStaffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(widget.noSurat, widget.item, widget.user),
      ),
    );
    ;
  }
}
