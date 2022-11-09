import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class BaseTheme {
  static double fontSizeNormal = 14;
  static double fontSizeSmall = 12;
  static double fontSizeVerySmall = 10;
  static double fontSizeLarge = 16;
  static double fontSizeVeryLarge = 18;
  static EdgeInsets marginAll = const EdgeInsets.all(8);
  static EdgeInsets marginAllSmall = const EdgeInsets.all(4);
  static EdgeInsets marginAllLarge = const EdgeInsets.all(16);

  static EdgeInsets marginVertical = const EdgeInsets.symmetric(vertical: 8);

  static EdgeInsets marginRectangular = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static EdgeInsets marginRectangularSmall = const EdgeInsets.symmetric(
    horizontal: 8,
    vertical: 4,
  );
  static EdgeInsets marginRectangularLarge = const EdgeInsets.symmetric(
    horizontal: 32,
    vertical: 16,
  );

  static String dateFormat(String? value) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy hh:mm');
    if (value == null) {
      return '';
    } else {
      var date = DateTime.parse(value);
      return dateFormat.format(date);
    }
  }

  static PreferredSizeWidget appBar(
    String title, {
    Color? textColor,
    List<Widget>? actions,
  }) {
    PreferredSizeWidget appBar = AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      toolbarHeight: title == 'splash' ? 0 : null,
      centerTitle: true,
      elevation: title == 'EMPLOYEES' ? null : 0,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: title == 'EMPLOYEES' ? FontWeight.bold : null,
          fontSize: title == 'EMPLOYEES' ? 30 : null,
          shadows: title == 'EMPLOYEES'
              ? const [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 2,
                    color: Colors.lightBlueAccent,
                  )
                ]
              : null,
        ),
      ),
      actions: actions,
    );
    return appBar;
  }

  static Widget loading() {
    return const CircularProgressIndicator(
      color: Colors.grey,
    );
  }
}
