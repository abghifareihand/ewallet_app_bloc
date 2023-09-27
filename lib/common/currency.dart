import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

String formatCurrency(num number, {String symbol = 'Rp '}) {
  return NumberFormat.currency(
    locale: 'id',
    symbol: symbol,
    decimalDigits: 0,
  ).format(number);
}

// Image Picker
Future<XFile?> selectImage() async {
  XFile? selectImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  return selectImage;
}
