/// This package is a simple but complete mail.tm api wrapper
/// You can use this to save and manage your accounts, as well read all your temporary emails.
library;

export 'src/models.dart'
    show
        Account,
        Attachment,
        Domain,
        HydraDomains,
        HydraMessages,
        Message,
        MessageSource,
        Token,
        AuthenticatedUser;

export 'src/requests.dart' show MailTmService;

export 'src/mailtm.dart' show MailTm;
export 'package:dio/dio.dart' show DioException;
