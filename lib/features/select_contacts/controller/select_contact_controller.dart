import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hey_chat/features/select_contacts/repository/select_contact_repository.dart';

final getContactProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return selectContactRepository.getContacts();
});
