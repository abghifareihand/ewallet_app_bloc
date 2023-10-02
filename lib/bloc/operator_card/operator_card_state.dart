part of 'operator_card_bloc.dart';

abstract class OperatorCardState extends Equatable {
  const OperatorCardState();

  @override
  List<Object> get props => [];
}

final class OperatorCardInitial extends OperatorCardState {}

final class OperatorCardLoading extends OperatorCardState {}

final class OperatorCardFailed extends OperatorCardState {
  final String error;
  const OperatorCardFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

final class OperatorCardSuccess extends OperatorCardState {
  final List<OperatorCardModel> operatorCards;
  const OperatorCardSuccess(
    this.operatorCards,
  );

  @override
  List<Object> get props => [operatorCards];
}
