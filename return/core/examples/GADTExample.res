// referances
// https://blog.mads-hartmann.com/ocaml/2015/01/05/gadt-ocaml.html
// https://kevanstannard.github.io/rescript-blog/simple-gadt-example-add.html
module Expr = {
  type rec value<_> =
    | Bool(bool): value<bool>
    | Int(int): value<int>
    | Str(string): value<string>

  type rec expr<_> =
    | Value(value<'a>): expr<'a>
    | If(expr<bool>, expr<'a>, expr<'a>): expr<'a>
    | Eq(expr<'a>, expr<'a>): expr<bool>
    | Lt(expr<int>, expr<int>): expr<bool>

  let rec eval:
    type a. expr<a> => a =
    exresion =>
      switch exresion {
      | Value(Bool(b)) => b
      | Value(Int(i)) => i
      | Value(Str(i)) => i
      | If(b, l, r) =>
        if eval(b) {
          eval(l)
        } else {
          eval(r)
        }
      | Eq(a, b) => eval(a) == eval(b)
      | Lt(a, b) => eval(a) < eval(b)
      }
}

module Branch = {
  // Not working btw as I expected
  type rec state<_> =
    | Step('a): state<'a>
    | Confirmed(bool): state<'a>

  type rec action<_> =
    | Next
    | Prev
    | Update(int): action<int>

  let eval = (type s a, s: state<s>, ac: action<a>): state<s> => {
    switch s {
    | Step(st) =>
      switch ac {
      | Next => Step(st)
      | Prev => Step(st)
      | Update(i) => i + 1 < 3 ? Step(st) : Confirmed(true)
      }
    | Confirmed(v) => Confirmed(v)
    }
  }
}
