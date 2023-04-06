open Ava
module T = Task

asyncTest("Task. Execute Task program.", async ctx => {
  let op = () => Js.Promise2.resolve(1)
  switch await T.make(op)->T.run {
  | data => ctx->Assert.is(data, 1, ())
  | exception _ => failwith("Task can't fail.")
  }
})

asyncTest("Task. Execute Task pipeline.", async ctx => {
  let op = () => Js.Promise2.resolve(1)
  let addOne = v => v + 1
  let addOneTask = v => T.make(() => Js.Promise2.resolve(v + 1))

  let logger = (marker, a) =>
    T.make(async () => {
      let str = `
    👋 simple logger ${marker}
    value: ${Belt.Int.toString(a)}`
      Js.Console.log(str)
    })

  let program =
    T.make(op)
    // program
    ->T.map(addOne)
    ->T.chainFirst(logger("[Task]"))
    ->T.chain(addOneTask)
  switch await program->T.run {
  | data => ctx->Assert.is(data, 3, ())
  | exception _ => failwith("Task can't fail.")
  }
})

asyncTest("Task. Check if failed.", ctx => {
  let failOp = () => Js.Promise2.reject(Js.Exn.raiseError("error"))
  Assert.throwsAsync(
    ctx,
    T.make(failOp)->T.run,
    ~expectations={
      name: "Error",
      message: "[Task] run can't fail. error",
    },
    (),
  )
})
