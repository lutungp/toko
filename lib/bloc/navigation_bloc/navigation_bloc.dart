import 'package:bloc/bloc.dart';
import 'package:mystore/pages/ui/messages_page.dart';
import 'package:mystore/pages/ui/my_cards.dart';
import 'package:mystore/pages/ui/utility_bills_page.dart';

enum NavigationEvents {
  DashboardClickEvent,
  MessagesClickEvent,
  UtilityClickEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;
  
  NavigationBloc({this.onMenuTap});

  @override
  NavigationStates get initialState => MyCardsPage(
    onMenuTap: onMenuTap,
  );

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashboardClickEvent:
          yield MyCardsPage(
            onMenuTap: onMenuTap,
          );
        break;
      case NavigationEvents.MessagesClickEvent:
          yield MessagesPage(
            onMenuTap: onMenuTap,
          );
        break;
      case NavigationEvents.UtilityClickEvent:
          yield UtilityBills(
            onMenuTap: onMenuTap,
          );
        break;
    }
  }
}