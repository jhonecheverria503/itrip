class Validator {
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo Requerido";
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return "Correo electronico invalido";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Campo Requerido";
    }
    if (value.length < 6) {
      return "La contraseña debe tener al menos 6 caracteres";
    }
    return null;
  }
}