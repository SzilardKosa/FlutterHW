import 'package:flutter/widgets.dart';
import 'movie_interactor.dart';

class InteractorProvider extends InheritedWidget {
  final MovieInteractor interactor;

  const InteractorProvider({
    Key? key,
    required this.interactor,
    required Widget child
  }) : super(key: key, child: child);

  //region InheritedWidget implementation
  static InteractorProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InteractorProvider>();
  }

  @override
  bool updateShouldNotify(InteractorProvider old) => false;
  //endregion
}