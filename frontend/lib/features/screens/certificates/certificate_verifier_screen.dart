import 'package:flutter/material.dart';

class CertificateVerifierScreen extends StatelessWidget {
  final String? certificateId;
  const CertificateVerifierScreen({super.key, this.certificateId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Certificate')),
      body: Center(
        child: Text(certificateId != null && certificateId!.isNotEmpty
            ? 'Verifying $certificateId'
            : 'Enter Certificate ID'),
      ),
    );
  }
}
