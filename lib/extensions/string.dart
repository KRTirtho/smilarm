extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String toCamelCase() {
    return split(' ').map((String word) {
      return word.capitalize();
    }).join('');
  }

  String toSnakeCase() {
    return split(' ').join('_').toLowerCase();
  }

  String toKebabCase() {
    return split(' ').join('-').toLowerCase();
  }

  String toPascalCase() {
    return split(' ').map((String word) {
      return word.capitalize();
    }).join('');
  }

  String toConstantCase() {
    return split(' ').join('_').toUpperCase();
  }
}
