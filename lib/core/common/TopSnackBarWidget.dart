import 'package:flutter/cupertino.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class topSnackBarWidget{
  topSnackBarSuccess(BuildContext context,String text){
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message:
        text,
      ),
    );
  } topSnackBarInfo(BuildContext context,String text){
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(
        message:
        text,
      ),
    );
  } topSnackBarError(BuildContext context,String text){
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message:
        text,
      ),
    );
  }
}