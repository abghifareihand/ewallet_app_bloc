part of 'transfer_bloc.dart';

abstract class TransferState extends Equatable {
  const TransferState();

  @override
  List<Object> get props => [];
}

final class TransferInitial extends TransferState {}

final class TransferLoading extends TransferState {}

final class TransferFailed extends TransferState {
  final String error;

  const TransferFailed(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

final class TransferSuccess extends TransferState {}
