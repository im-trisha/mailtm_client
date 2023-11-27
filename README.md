# Estimated reading time: 2 minutes
# Index
1. [Introduction](#Introduction)
2. [Example](#example)
3. [Usage](#usage)

## Introduction
This package is a simple but complete mail.tm api wrapper, you can use this to save and manage your accounts, as well read all your temporary emails.

## Example
See in [the example folder](example/)

## Usage

### MailTm 
A static class which is mainly needed for storing, creating and loading accounts

#### Gettings the available domains
To get the available domains use 
```dart
await MailTm.domains();
```

#### Create an account

To create an account you just need to use the MailTm.register method.

Params

- username: address' username (abcdqwerty@mail.tm, here, abcdqwerty is the username)
- password: account's password
- domain: address' domain, you can either get one from MailTm.domains() or, if not given, a random one will be provided.
- randomStringLength: will be used to generate a random password and/or username if not provided (16 is the default length)

```dart
await MailTm.register(password: 'ah yes password');
```

Returns a ``Future<AuthenticatedUser>`` instance

#### Loading an account

You can load an account by using the `MailTm.login` method

Params

- id: Will be used to retrieve the account, ONLY IF it was already retireved using login/register
- username: Address, only if id was not provided
- password: Password, only if id was not provided

Returns a ``Future<AuthenticatedUser>`` instance

#### AuthenticatedUser
This class is the one that represents an authenticated account (Having both an account's password and jwt token)

There are many methods, thought, they are pretty simple:
- `messageFrom`: Gets a message from its id
- `deleteMessage`: Deletes a message
- `readMessage`: Marks a message as read
- `unreadMessage`: Marks a message as unread
- `messageSource`: Gets a message's source (docs.mail.tm for further clarifications)
- `downloadAttachment`: Downloads an attachment as a list of bytes
- `delete`: Deletes the underlying account
- `update`: Updates the underlying account (e.g. its used quota)
- `messagesAt`: Gets the messages from a certain page. Each page has 30 messages
- `allMessages`: Gets every page from the messages list
- `messages`: You can listen to this Stream to get every upcoming message
