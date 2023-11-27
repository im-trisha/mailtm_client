import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mailtm_client/mailtm_client.dart';

// NOTE: This is only needed for AuthenticatedUser TODO: Maybe put it in another folder? Maybe put it in another library, not .models?
import 'package:mercure_client/mercure_client.dart';
import 'package:mailtm_client/src/requests.dart';
import 'dart:convert';
import 'dart:async';
//

part 'models.freezed.dart';
part 'models.g.dart';

// Models
part 'models/api/account.dart';
part 'models/api/attachment.dart';
part 'models/api/domain.dart';
part 'models/api/message.dart';
part 'models/api/message_source.dart';
part 'models/api/token.dart';

part 'models/local/authenticated_user.dart';

// Hydras
part 'models/api/hydras/domains.dart';
part 'models/api/hydras/messages.dart';
