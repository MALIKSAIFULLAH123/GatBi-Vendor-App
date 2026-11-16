import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  GoogleSignInService._();

  static Future<void>? _initialization;
  static String? _initializedServerClientId;
  static String? _initializedClientId;

  static Future<GoogleSignInAccount?> signIn({
    required String serverClientId,
    String? clientId,
  }) async {
    await _ensureInitialized(serverClientId, clientId);

    try {
      await GoogleSignIn.instance.signOut();
    } catch (_) {}

    try {
      return await GoogleSignIn.instance.authenticate(
        scopeHint: const ['email', 'profile'],
      );
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      rethrow;
    }
  }

  static Future<void> _ensureInitialized(
    String serverClientId,
    String? clientId,
  ) {
    if (_initialization != null &&
        _initializedServerClientId == serverClientId &&
        _initializedClientId == clientId) {
      return _initialization!;
    }

    _initializedServerClientId = serverClientId;
    _initializedClientId = clientId;
    _initialization = _initialize(serverClientId, clientId);
    return _initialization!;
  }

  static Future<void> _initialize(
    String serverClientId,
    String? clientId,
  ) async {
    try {
      await GoogleSignIn.instance.initialize(
        clientId: clientId,
        serverClientId: serverClientId,
      );
    } catch (_) {
      _initialization = null;
      _initializedServerClientId = null;
      _initializedClientId = null;
      rethrow;
    }
  }
}
