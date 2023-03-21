// referances
// https://blog.mads-hartmann.com/ocaml/2015/01/05/gadt-ocaml.html
// https://kevanstannard.github.io/rescript-blog/simple-gadt-example-add.html

type rec value<_> =
  | Bool(bool): value<bool>
  | Int(int): value<int>

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
    | If(b, l, r) =>
      if eval(b) {
        eval(l)
      } else {
        eval(r)
      }
    | Eq(a, b) => eval(a) == eval(b)
    | Lt(a, b) => eval(a) < eval(b)
    }

let ifExpr = If(Value(Bool(true)), Value(Int(1)), Value(Int(2)))
