open Ava
open Paper

test("Paper. Basic eval. Should success.", ctx => {
  open Basic
  let answer = eval(Div(Div(Con(1972), Con(2)), Con(23)))
  ctx->Assert.is(answer, 42, ())
})

test("Paper. Basic eval. Should fail.", ctx => {
  open Basic
  try {
    let _ = eval(Div(Con(1), Con(0)))
  } catch {
  | Division_by_zero => ctx->Assert.is(0, 0, ())
  }
})
