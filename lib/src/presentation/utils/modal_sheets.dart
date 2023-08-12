import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/models/editable_items.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/painting_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/domain/sevices/save_as_image.dart';
import 'package:stories_editor/src/presentation/utils/Extensions/hexColor.dart';
import 'package:stories_editor/src/presentation/utils/constants/app_enums.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';
import 'package:stories_editor/stories_editor.dart';
import 'package:fenolive/view/page/screen_bridge/screen_bridge.dart';

/// create item of type GIF
Future createGiphyItem(
    {required BuildContext context, required giphyKey}) async {
  final _editableItem =
      Provider.of<DraggableWidgetNotifier>(context, listen: false);
  _editableItem.giphy = await ModalGifPicker.pickModalSheetGif(
    context: context,
    apiKey: giphyKey,
    rating: GiphyRating.r,
    sticker: true,
    backDropColor: Colors.black,
    crossAxisCount: 3,
    childAspectRatio: 1.2,
    topDragColor: Colors.white.withOpacity(0.2),
  );

  /// create item of type GIF
  if (_editableItem.giphy != null) {
    _editableItem.draggableWidget.add(EditableItem()
      ..type = ItemType.gif
      ..gif = _editableItem.giphy!
      ..position = const Offset(0.0, 0.0));
  }
}

/// custom exit dialog
Future<bool> exitDialog({required context, required contentKey}) async {
  return (await showDialog(
        context: context,
        barrierColor: Colors.black38,
        // barrierDismissible: true,
        builder: (c) => Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetAnimationDuration: const Duration(milliseconds: 300),
          insetAnimationCurve: Curves.ease,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24).r,
              color: HexColor.fromHex('#262626'),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25, horizontal: 5).r,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    langDataGlobal.dialog!.title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5.r),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    langDataGlobal.dialog!.body.toString(),
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white54,
                        letterSpacing: 0.1.w),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),

                  /// Sil Butonu,basıldığında kaydetmeden çıkar
                  AnimatedOnTapButton(
                    onTap: () async {
                      //_resetDefaults(context: context);
                      Navigator.pop(context);
                      print("çıkmak istedi222");
                    },
                    child: Text(
                      "İptal Et",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.redAccent.shade200,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.1.r),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  /// Kaydet Ve Çık ,Çizimi Kaydet ve Çık
                  // AnimatedOnTapButton(
                  //   onTap: () async {
                  //     final _paintingProvider =
                  //         Provider.of<PaintingNotifier>(context, listen: false);
                  //     final _widgetProvider =
                  //         Provider.of<DraggableWidgetNotifier>(context,
                  //             listen: false);
                  //     if (_paintingProvider.lines.isNotEmpty ||
                  //         _widgetProvider.draggableWidget.isNotEmpty) {
                  //       /// save image
                  //       var response = await takePicture(
                  //           contentKey: contentKey,
                  //           context: context,
                  //           saveToGallery: true);
                  //       if (response) {
                  //         _dispose(
                  //             context: context,
                  //             message: langDataGlobal.dialog!.saveSuccess
                  //                 .toString());
                  //       } else {
                  //         _dispose(
                  //           context: context,
                  //           message: langDataGlobal.dialog!.error.toString(),
                  //         );
                  //       }
                  //     } else {
                  //       _dispose(
                  //         context: context,
                  //         message: langDataGlobal.dialog!.emptyDraw.toString(),
                  //       );
                  //     }
                  //   },
                  //   child: Text(
                  //     langDataGlobal.dialog!.saveSuccess.toString(),
                  //     style: const TextStyle(
                  //         fontSize: 16,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //         letterSpacing: 0.5),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  SizedBox(
                    height: 22.h,
                    child: const Divider(
                      color: Colors.white10,
                    ),
                  ),

                  ///cancel butonu tıklandığında dialog ekranı kapanır
                  AnimatedOnTapButton(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      "Vazgeç",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5.w),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      )) ??
      false;
}

_resetDefaults({required BuildContext context}) {
  final _paintingProvider =
      Provider.of<PaintingNotifier>(context, listen: false);
  final _widgetProvider =
      Provider.of<DraggableWidgetNotifier>(context, listen: false);
  final _controlProvider = Provider.of<ControlNotifier>(context, listen: false);
  final _editingProvider =
      Provider.of<TextEditingNotifier>(context, listen: false);
  _paintingProvider.lines.clear();
  _widgetProvider.draggableWidget.clear();
  _widgetProvider.setDefaults();
  _paintingProvider.resetDefaults();
  _editingProvider.setDefaults();
  _controlProvider.mediaPath = '';
}

_dispose({required context, required message}) {
  _resetDefaults(context: context);
  Fluttertoast.showToast(msg: message);
  Navigator.of(context).pop(true);
}
