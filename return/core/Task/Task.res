module Promise = Js.Promise2

type t<'a> = Task(unit => promise<'a>)

@genType
let make = (ta): t<'a> => Task(ta)

// let run = async (Task(ta): t<'a>) => await ta()
@genType
let run = async (Task(ta): t<'a>) =>
  switch await ta() {
  | x => x
  | exception Js.Exn.Error(err) =>
    switch Js.Exn.message(err) {
    | Some(msg) => Js.Exn.raiseError("[Task] run can't fail. " ++ msg)
    | None => Js.Exn.raiseError("[Task] run can't fail.")
    }
  }

@genType
let map = (Task(ta): t<'a>, fab: 'a => 'b): t<'b> =>
  make(async () =>
    switch await ta() {
    | a => fab(a)
    | exception _ => failwith("Wrong usage. Task can't fail.")
    }
  )

@genType
let chain = (Task(ta): t<'a>, fab: 'a => t<'b>): t<'b> =>
  make(async () =>
    try {
      let a = await ta()
      let b = await run(fab(a))
      b
    } catch {
    | Js.Exn.Error(_) =>
      failwith("[Task.chian] Wrong usage. Task can't fail. Use TaskEither instead.")
    }
  )

@genType
let chainFirst = (Task(ta), fab: 'a => t<'b>): t<'a> =>
  make(async () =>
    try {
      let a = await ta()
      let _ = await run(fab(a))
      a
    } catch {
    | Js.Exn.Error(_) =>
      failwith("[Task.chian] Wrong usage. Task can't fail. Use TaskEither instead.")
    }
  )
