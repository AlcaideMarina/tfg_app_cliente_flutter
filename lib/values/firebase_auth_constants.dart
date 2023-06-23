class FirebaseAuthConstants {
  static const Map<String, String> loginErrors = {
    'invalid-email': 'El formato del email no es válido. Revise los datos.',
    'user-not-found':
        'El usuario y/o contraseña no son correctos. Revise los datos.',
    'wrong-password':
        'El usuario y/o contraseña no son correctos. Revise los datos.',
    'network-request-failed':
        "Ha ocurrido un error de conexión. Compruebe que tenga acceso a internet e inténtelo más tarde."
  };

  static const genericError =
      'Se ha producido un error inesperado. Por favor, intente acceder en otro momento.';
}
