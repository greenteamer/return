// https://homepages.inf.ed.ac.uk/wadler/papers/marktoberdorf/baastad.pdf

// 2.1 The basic evaluator

module Basic = {
  type rec term = Con(int) | Div(term, term)

  let rec eval = term =>
    switch term {
    | Con(i) => i
    | Div(t, u) => eval(t) / eval(u)
    }
}
