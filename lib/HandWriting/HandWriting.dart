import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:job_card/Database/DatabaseSirvecs.dart';
import '../Other/AlertMessages/AlertMessage.dart';
import '../Other/Loading.dart';

HandSignatureControl control = HandSignatureControl(
  threshold: 0.01,
  smoothRatio: 0.65,
  velocityRange: 2.0,
);

ValueNotifier<String?> svg = ValueNotifier<String?>(null);

ValueNotifier<ByteData?> rawImage = ValueNotifier<ByteData?>(null);

ValueNotifier<ByteData?> rawImageFit = ValueNotifier<ByteData?>(null);

DatabaseSirvecs _databaseSirvecs = DatabaseSirvecs();

bool loading = false;

String url = '';

class HandWriting extends StatefulWidget {
  const HandWriting({required this.date, required this.type});

  final String date;
  final String type;

  @override
  State<HandWriting> createState() => _HandWritingState(date, type);
}

class _HandWritingState extends State<HandWriting> {
  _HandWritingState(this.date, this.type);

  final String date;
  final String type;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('الخدمات المطلوبة'),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 200,
                                constraints: BoxConstraints.expand(),
                                color: Colors.white,
                                child: HandSignature(
                                  control: control,
                                  type: SignatureDrawType.shape,
                                ),
                              ),
                              CustomPaint(
                                painter: DebugSignaturePainterCP(
                                  control: control,
                                  cp: false,
                                  cpStart: false,
                                  cpEnd: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          CupertinoButton(
                            onPressed: () {
                              control.clear();
                              svg.value = null;
                              rawImage.value = null;
                              rawImageFit.value = null;
                            },
                            child: Text('مسح'),
                          ),
                          CupertinoButton(
                            onPressed: () async {
                              var image =
                                  rawImageFit.value = await control.toImage(
                                color: Colors.blueAccent,
                                background: Colors.greenAccent,
                              );

                              setState(() {
                                loading = true;
                              });

                              try {
                                url = await _databaseSirvecs
                                    .uploadImage(image, date, type)
                                    .timeout(const Duration(seconds: 7));
                              } on TimeoutException catch (e) {
                                setState(() {
                                  loading = false;
                                });

                                await alertMessage(context, 'حدث خطأ',
                                    'تحقق من اتصال الانترنت');
                              } catch (e) {
                                setState(() {
                                  loading = false;
                                });

                                await alertMessage(context, 'حدث خطأ',
                                    'تحقق من اتصال الانترنت');
                              }

                              setState(() {
                                loading = false;
                              });

                              if (url != '')
                                Navigator.pop(context, url);
                            },
                            child: Text('حفظ'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[_buildScaledImageView()],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildScaledImageView() => Container(
        width: 192.0,
        height: 96.0,
        decoration: BoxDecoration(
          border: Border.all(),
          color: Colors.white30,
        ),
        child: ValueListenableBuilder<ByteData?>(
          valueListenable: rawImageFit,
          builder: (context, data, child) {
            if (data == null) {
              return Container(
                color: Colors.red,
                child: Center(
                  child: Text('فارغ'),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.memory(data.buffer.asUint8List()),
              );
            }
          },
        ),
      );
}
