open Ava
open GADTExample

test("GADT. expression.", ctx => {
  open Expr

  let f = If(Value(Bool(true)), Value(Int(1)), Value(Int(2)))->eval
  let s = Eq(Value(Str("string")), Value(Str("new string")))->eval
  ctx->Assert.is(f, 1, ())
  ctx->Assert.is(s, false, ())
})
