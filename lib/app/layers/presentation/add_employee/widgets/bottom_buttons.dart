import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({
    Key? key,
    required this.onTapSave,
    required this.onTapCancel,
    this.prefix,
  }) : super(key: key);

  final VoidCallback? onTapSave;
  final VoidCallback? onTapCancel;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 2.0,
          thickness: 2.0,
          color: Color(0xFFF2F2F2),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (prefix != null) ...[
                prefix!,
                const Spacer(),
              ],
              ElevatedButton(
                  onPressed: onTapCancel,
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFFEDF8FF))),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )),
              const SizedBox(width: 16.0),
              Hero(
                tag: 'addToSaveButton',
                child: ElevatedButton(
                    onPressed: onTapSave,
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: const Text('Save')),
              ),
            ],
          ),
        )
      ],
    );
  }
}
