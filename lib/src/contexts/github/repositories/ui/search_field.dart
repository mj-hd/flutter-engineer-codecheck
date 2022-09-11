import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:github_viewer/src/utils/hooks/use_debounced_text_changed.dart';

class SearchField extends HookWidget {
  const SearchField({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    const timespan = Duration(milliseconds: 500);

    final focusNode = useFocusNode();
    final controller = useTextEditingController();

    useDebouncedTextChanged(controller, timespan, onChanged);

    return TextField(
      decoration: const InputDecoration(
        label: Text('Repository name'),
      ),
      focusNode: focusNode,
      controller: controller,
      autofocus: true,
      autocorrect: false,
      keyboardType: TextInputType.text,
    );
  }
}
