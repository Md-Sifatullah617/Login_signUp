import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({Key? key, required this.title, required this.onTap, this.loading = false}) : super(key: key);

  final String title;
  final VoidCallback onTap;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
          child: loading ? const CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) : Text(title,style: const TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
