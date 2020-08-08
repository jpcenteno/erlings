-module(bank_account).

-export([process_operation/2]).

process_operation(Bank, {AccountNumber, Operation, Amount}) ->
  Account = lists:keyfind(AccountNumber, 1, Bank),
  case Account of
    false -> {error, account_not_found};
    _     -> process_operation_on_account(Account, Operation, Amount)
  end.

process_operation_on_account(Account, withdraw, Amount) ->
  withdraw(Account, Amount);
process_operation_on_account(Account, deposit, Amount) ->
  deposit(Account, Amount).

withdraw({AccountNumber, AccountAmount}, WithdrawalAmount) when WithdrawalAmount =< AccountAmount ->
  {AccountNumber, AccountAmount - WithdrawalAmount};
withdraw(_Account, _WithdrawalAmount) ->
  {error, insufficient_funds}.

deposit({AccountNumber, AccountAmount}, WithdrawalAmount) ->
  {AccountNumber, AccountAmount + WithdrawalAmount}.
