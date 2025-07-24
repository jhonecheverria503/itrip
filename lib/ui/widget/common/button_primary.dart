import 'package:flutter/material.dart';

class ButtonPrimary extends StatefulWidget {
  const ButtonPrimary({super.key, required this.onClick, required this.text});
  final Function onClick;
  final String text;

  @override
  State<ButtonPrimary> createState() => _ButtonPrimaryState();
}

class _ButtonPrimaryState extends State<ButtonPrimary> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            Color(0xFF008FC8),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(
                10,
              ),
            ),
          ),
        ),
        onPressed: () => widget.onClick(),
        // onPressed: () async {
        //   String url =
        //       "https://api.escuelajs.co/api/v1/auth/login";
        //   Map<String, String> headers = {
        //     "Content-Type": "application/json",
        //   };
        //   Map<String, String> body = {
        //     "email": "john@mail.com",
        //     "password": "changeme",
        //   };
        //   http.Response response = await http.post(
        //     Uri.parse(url),
        //     headers: headers,
        //     body: jsonEncode(body),
        //   );
        //   print(
        //     "Status Code: " +
        //         response.statusCode.toString(),
        //   );
        //   print(
        //     "Response Body: " + response.body.toString(),
        //   );
        // },
        child: Text(
          widget.text,
          style: TextStyle(color: Colors.white),
        ),
      );
  }
}