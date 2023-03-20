type t<'e, 'a> = Reader('e => 'a)

@genType
let make = (ea): t<'e, 'a> => Reader(ea)

@genType
let run = (Reader(r): t<'e, 'a>, env): 'a => r(env)

@genType
let ask = (): t<'e, 'e> => Reader(env => env)

@genType
let local = (r: t<'e, 'a>, fe: 'e => 'e) => Reader(env => run(r, fe(env)))

@genType
let map = (r: t<'e, 'a>, fab: 'a => 'b) => Reader(env => fab(run(r, env)))

@genType
let chain = (Reader(ea): t<'e, 'a>, fab: 'a => t<'e, 'b>) => Reader(env => run(env->ea->fab, env))

@genType
let chainFirst = (Reader(ea): t<'e, 'a>, fab: 'a => t<'e, 'b>): t<'e, 'a> => Reader(
  env => {
    let _ = ea(env)->fab->run(env)
    ea(env)
  },
)
