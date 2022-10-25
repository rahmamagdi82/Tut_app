import 'dart:ffi';

import 'package:rxdart/subjects.dart';
import 'package:tut_app/domain/model/models.dart';

import '../../../../../../domain/usecase/notifications_usecase.dart';
import '../../../../../base/base_view_model.dart';
import '../../../../../common/state_renderer/state_remderer_impl.dart';
import '../../../../../common/state_renderer/state_renderer.dart';

class NotificationViewModel extends BaseViewModel with NotificationViewModelInput,NotificationViewModelOutput{

  final _notificationsStreamController= BehaviorSubject<NotificationModel>();

  final NotificationUseCase _notificationUseCase;
  NotificationViewModel(this._notificationUseCase);

  @override
  void start() {
    _getNotificationsData();
  }

  @override
  void dispose() {
    _notificationsStreamController.close();
    super.dispose();
  }

//inputs

  @override
  Sink get inputNotifications => _notificationsStreamController.sink;

  _getNotificationsData() async {
    inputState.add(LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _notificationUseCase.execute(Void)).fold(
            (failure) {
          // left
          inputState.add(ErrorState(StateRendererType.popupErrorState,failure.message));
        },
            (notifications) {
          inputState.add(ContentState());
          inputNotifications.add(notifications);
        });
  }

//outputs

  @override
  Stream<NotificationModel> get  outputNotifications=> _notificationsStreamController.stream.map((notifications) => notifications);
}

abstract class NotificationViewModelInput{
  Sink get inputNotifications;
}

abstract class NotificationViewModelOutput{
  Stream<NotificationModel> get outputNotifications;
}