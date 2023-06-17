import 'package:employee_manager/app/layers/domain/entities/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyDropdownField extends StatefulWidget {
  const MyDropdownField({Key? key, required this.onSelectItem})
      : super(key: key);

  final void Function(Role) onSelectItem;

  @override
  State<MyDropdownField> createState() => _MyDropdownFieldState();
}

class _MyDropdownFieldState extends State<MyDropdownField> {
  Role? selectedItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showRoleOptions(context),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E5E5), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(4.0))),
        child: Row(
          children: [
            const SizedBox(width: 10.5),
            SizedBox(
              width: 19.0,
              height: 17.5,
              child: SvgPicture.asset(
                'assets/images/svg/work.svg',
              ),
            ),
            const SizedBox(width: 14.5),
            Expanded(
                child: Text(
              selectedItem?.description ?? 'Select role',
              style: TextStyle(
                  fontSize: 16.0,
                  color: selectedItem == null
                      ? const Color(0xFF949C9E)
                      : const Color(0xFF323238)),
            )),
            SvgPicture.asset(
              'assets/images/svg/arrow_dropdown.svg',
            ),
            const SizedBox(width: 12.17),
          ],
        ),
      ),
    );
  }

  void _showRoleOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        var hasBuiltFirstItem = false;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: Role.values.map(
            (role) {
              Widget item = InkWell(
                onTap: () {
                  widget.onSelectItem(role);
                  setState(() => selectedItem = role);
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: hasBuiltFirstItem
                      ? const EdgeInsets.symmetric(vertical: 16.0)
                      : const EdgeInsets.only(bottom: 16.0),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE5E5E5), width: 1.0)),
                  ),
                  child: Text(
                    role.description,
                    textAlign: TextAlign.center,
                  ),
                ),
              );

              if (!hasBuiltFirstItem) {
                hasBuiltFirstItem = true;
                item = Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 16.0,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                    ),
                    item,
                  ],
                );
              }

              return item;
            },
          ).toList(),
        );
      },
      backgroundColor: Colors.transparent,
    );
  }
}
