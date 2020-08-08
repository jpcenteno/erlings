-module(calculate_bmi).

-export([bmi/1, classify/1]).

-include("../src/person_record.hrl").

bmi(#person{weight=Weight, height=Height}) ->
  Weight / (Height * Height).

classify(Person) ->
  case bmi(Person) of
    BMI when BMI < 18.5                      -> underweight;
    BMI when (18.5 =< BMI) and (BMI < 25.0)  -> normal;
    BMI when (25.0 =< BMI) and (BMI =< 30.0) -> overweight;
    _                                        -> obese
  end.
