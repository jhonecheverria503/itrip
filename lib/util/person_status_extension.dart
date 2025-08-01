import 'package:itrip/data/enum/person_status_enum.dart';

extension PersonStatusValue on PersonStatusEnum {
  String getValue(){
    switch (this) {
      case PersonStatusEnum.individual:
        return "I";
      case PersonStatusEnum.companied:
        return "C";
    }
  }
}