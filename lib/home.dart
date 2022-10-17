import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gr_code_generator/controller/app_cubit.dart';
import 'package:gr_code_generator/controller/app_states.dart';
import 'package:gr_code_generator/qrcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyHomePage extends StatelessWidget {
  final String? qrData;

  MyHomePage({Key? key, this.qrData}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController textQrToGenerateController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("QrCode App"),
            ),
            body: Scrollbar(
              thickness: 5,
              radius: const Radius.circular(10),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        (AppCubit.get(context).qrCodeText != null)
                            ? Container(
                                decoration:
                                    BoxDecoration(border: Border.all(width: 5)),
                                child: QrImage(
                                  data: AppCubit.get(context).qrCodeText!,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: textQrToGenerateController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "you should type any thing to generate";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.qr_code),
                            label: Text(
                              "Type Here",
                            ),
                            hintText: "Type any thing to generate",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                //todo: generate Qr code
                                if (_formKey.currentState!.validate()) {
                                  AppCubit.get(context).generateQrCode(
                                      textQrToGenerateController.text);
                                }
                              },
                              color: Theme.of(context).primaryColor,
                              child: const Text("Generate QR code"),
                            ),
                            // const SizedBox(height: 10,),
                            MaterialButton(
                              onPressed: () {
                                //todo: generate Qr code
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QRViewExample(),
                                    ));
                              },
                              color: Theme.of(context).primaryColor,
                              child: const Text("Scan QR code"),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (qrData != null) Text("Code Scanned: $qrData"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
