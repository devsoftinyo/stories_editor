import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/presentation/widgets/tool_button.dart';
import 'package:stories_editor/stories_editor.dart';

class TopTextTools extends StatelessWidget {
  final void Function() onDone;
  const TopTextTools({Key? key, required this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TextEditingNotifier>(
      builder: (context, editorNotifier, child) {
        return Container(
          padding: const EdgeInsets.only(top: 15).r,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// font family / font color
                  ToolButton(
                    onTap: () {
                      editorNotifier.isFontFamily =
                          !editorNotifier.isFontFamily;
                      editorNotifier.isTextAnimation = false;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (editorNotifier.fontFamilyController.hasClients) {
                          editorNotifier.fontFamilyController.animateToPage(
                              editorNotifier.fontFamilyIndex,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                      });
                    },
                    child: Transform.scale(
                        scale: !editorNotifier.isFontFamily ? 0.8 : 1.3,
                        child: !editorNotifier.isFontFamily
                            ? ImageIcon(
                                const AssetImage('assets/icons/text.png',
                                    package: 'stories_editor'),
                                size: 20.r,
                                color: Colors.white,
                              )
                            : Image.asset(
                                'assets/icons/circular_gradient.png',
                                package: 'stories_editor',
                              )),
                  ),

                  /// text align
                  ToolButton(
                    onTap: editorNotifier.onAlignmentChange,
                    child: Transform.scale(
                        scale: 0.8,
                        child: Icon(
                          editorNotifier.textAlign == TextAlign.center
                              ? Icons.format_align_center
                              : editorNotifier.textAlign == TextAlign.right
                                  ? Icons.format_align_right
                                  : Icons.format_align_left,
                          color: Colors.white,
                        )),
                  ),

                  /// background color
                  ToolButton(
                    onTap: editorNotifier.onBackGroundChange,
                    child: Transform.scale(
                        scale: 0.7,
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 5, bottom: 3).r,
                            child: const ImageIcon(
                              AssetImage('assets/icons/font_backGround.png',
                                  package: 'stories_editor'),
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),
                  ToolButton(
                    onTap: () {
                      editorNotifier.isTextAnimation =
                          !editorNotifier.isTextAnimation;

                      /// animate to selected animation page
                      if (editorNotifier.isTextAnimation) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (editorNotifier
                              .textAnimationController.hasClients) {
                            editorNotifier.textAnimationController
                                .animateToPage(
                                    editorNotifier.fontAnimationIndex,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                          }
                        });
                      } else {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (editorNotifier.fontFamilyController.hasClients) {
                            editorNotifier.fontFamilyController.animateToPage(
                                editorNotifier.fontFamilyIndex,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          }
                        });
                      }
                    },
                    child: Transform.scale(
                        scale: 0.7,
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: ImageIcon(
                              AssetImage('assets/icons/video_trim.png',
                                  package: 'stories_editor'),
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ),

                  /// close and create items
                  GestureDetector(
                    onTap: onDone,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 8).r,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12)
                            .r
                            .r,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border:
                                Border.all(color: Colors.white, width: 1.5.w),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          langDataGlobal.dialog!.done.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
