import 'package:contacts_app/data/contact.dart';
import 'package:faker/faker.dart' as faker;
import 'package:scoped_model/scoped_model.dart';

class ContactsModel extends Model {
  List<Contact> _contacts = List.generate(50, (index) {
    return Contact(
      name: faker.Person().firstName() + ' ' + faker.Person().lastName(),
      email: faker.Internet().freeEmail(),
      phoneNumber: faker.RandomGenerator().integer(100000000).toString(),
    );
  });

  List<Contact> get contacts => _contacts;
  void addContact(Contact value) {
    _contacts.add(value);
    notifyListeners();
  }

  void updateContact(Contact contact, int contactIndex) {
    _contacts[contactIndex] = contact;
    notifyListeners();
  }

  void deleteContact(int index) {
    _contacts.removeAt(index);
    notifyListeners();
  }

  void changeFavoriteStatus(int index) {
    _contacts[index].isFavorite = !_contacts[index].isFavorite;
    _sortContacts();
    notifyListeners();
  }

  void _sortContacts() {
    _contacts.sort((a, b) {
      int comparisonResult;
      comparisonResult = _compareBasedOnFavoriteStatus(a, b);
      if (comparisonResult == 0) {
        comparisonResult = _compareAlphabetically(a, b);
      }
      return comparisonResult;
    });
  }

  int _compareBasedOnFavoriteStatus(Contact a, Contact b) {
    if (a.isFavorite) {
      return -1;
    } else if (b.isFavorite) {
      return 1;
    } else {
      return 0;
    }
  }

  int _compareAlphabetically(Contact a, Contact b) {
    return a.name.compareTo(b.name);
  }
}
