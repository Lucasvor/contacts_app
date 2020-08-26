import 'package:contacts_app/data/contact.dart';
import 'package:contacts_app/ui/contact/contact_edit_page.dart';
import 'package:contacts_app/ui/model/contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    Key key,
    @required this.contactIndex,
  }) : super(key: key);

  final int contactIndex;

  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<ContactsModel>(context);
    final displayedContact = model.contacts[contactIndex];
    return Slidable(
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Delete",
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            model.deleteContact(contactIndex);
          },
        )
      ],
      actionPane: SlidableBehindActionPane(),
      child: _buildContent(
        context,
        displayedContact,
        model,
      ),
    );
  }

  Container _buildContent(
    BuildContext context,
    Contact displayedContact,
    ContactsModel model,
  ) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: ListTile(
        title: Text(displayedContact.name),
        subtitle: Text(displayedContact.email),
        leading: _buildCircleAvatar(displayedContact),
        trailing: IconButton(
          icon: Icon(
            displayedContact.isFavorite ? Icons.stars : Icons.star_border,
            color: displayedContact.isFavorite ? Colors.amber : Colors.grey,
          ),
          onPressed: () {
            model.changeFavoriteStatus(contactIndex);
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ContactEditPage(
                  editedContact: displayedContact,
                  editedcontactindex: contactIndex),
            ),
          );
        },
      ),
    );
  }

  Hero _buildCircleAvatar(Contact displayedContact) {
    return Hero(
      tag: displayedContact.hashCode,
      child: CircleAvatar(
        child: Text(displayedContact.name[0]),
      ),
    );
  }
}
