open Ava
module R = Reader

test("Reader. Make addToOne program with deps", ctx => {
  let addToOne = env => 1 + env
  let program = R.make(addToOne)->R.run
  ctx->Assert.is(program(5), 6, ())
})

test("Reader. Make addToOne with doubled deps deps", ctx => {
  let addToOne = env => 1 + env
  let doubleEnv = env => env * 2
  let program = R.make(addToOne)->R.local(doubleEnv)->R.run
  ctx->Assert.is(program(5), 11, ())
})

test("Reader. AddToOne with local doubled env value", ctx => {
  let addToOne = env => 1 + env
  let doubleEnv = env => env * 2
  let program = R.make(addToOne)->R.map(a => a * 2)->R.local(doubleEnv)->R.run
  ctx->Assert.is(program(5), 22, ())
})

// dependency type
type env = {value: int}
test("Reader. Pipe.", ctx => {
  let addToOne = env => 1 + env.value
  let double = a => a * 2
  let logger = (marker, a) =>
    R.make(env => {
      let str = `
    👋 simple logger ${marker}
    value: ${Belt.Int.toString(a)}
    env.value: ${Belt.Int.toString(env.value)}`
      Js.Console.log(str)
    })
  let run =
    R.make(addToOne)
    ->R.chainFirst("[first into callstack]"->logger)
    ->R.map(double)
    ->R.chainFirst("[second into callstack]"->logger)
    ->R.run

  // run with dependencies
  ctx->Assert.is(run({value: 5}), 12, ())
})

// asyncTest("bar", async ctx => {
//   let response = Js.Promise2.resolve("bar")

//   switch await response {
//   | data => ctx->Assert.is(data, "bar", ())
//   | exception _ => failwith("Should not throw.")
//   }
// })
