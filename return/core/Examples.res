module Model = {
  type pickupTime = Js.Date.t
  type pickupAddress = string
  type dropoffAddress = string
  type dateConfirmed = Js.Date.t
}

module DoubleStep = {
  type rec state<_, _> =
    | Step1(int, unit): state<int, unit>
    | Step2(state<int, unit>, string): state<state<int, unit>, string>

  type rec action<_> =
    | Next(state<'a, unit>): action<state<state<'a, unit>, string>>
    | Prev(state<state<int, unit>, string>): action<state<int, unit>>

  let reducer = (type a, action: action<a>): a =>
    switch action {
    | Next(Step1(num, ())) => Step2(Step1(num, ()), "address")
    | Prev(Step2(Step1(st, ()), _)) => Step1(st, ())
    }
}
