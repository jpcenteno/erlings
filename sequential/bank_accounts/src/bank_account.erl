-module(bank_account).

-export([process_operation/2]).

process_operation(Bank, {AccountNumber, withdraw, Amount}) ->
  Account = lists:keyfind(AccountNumber, 1, Bank),
  case Account of
    false -> {error, account_not_found};
    _     -> withdraw(Account, Amount)
  end;

process_operation(Bank, {AccountNumber, deposit, Amount}) ->
  Account = lists:keyfind(AccountNumber, 1, Bank),
  case Account of
    false -> {error, account_not_found};
    _     -> deposit(Account, Amount)
  end.

withdraw({AccountNumber, AccountAmount}, WithdrawalAmount) when WithdrawalAmount =< AccountAmount ->
  {AccountNumber, AccountAmount - WithdrawalAmount};
withdraw(_Account, _WithdrawalAmount) ->
  {error, insufficient_funds}.

deposit({AccountNumber, AccountAmount}, WithdrawalAmount) ->
  {AccountNumber, AccountAmount + WithdrawalAmount}.
