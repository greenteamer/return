// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Curry = require("rescript/lib/js/curry.js");

function make(ea) {
  return /* Reader */{
          _0: ea
        };
}

function run(r, env) {
  return Curry._1(r._0, env);
}

function ask(param) {
  return /* Reader */{
          _0: (function (env) {
              return env;
            })
        };
}

function local(r, fe) {
  return /* Reader */{
          _0: (function (env) {
              return run(r, Curry._1(fe, env));
            })
        };
}

function map(r, fab) {
  return /* Reader */{
          _0: (function (env) {
              return Curry._1(fab, run(r, env));
            })
        };
}

function chain(ea, fab) {
  var ea$1 = ea._0;
  return /* Reader */{
          _0: (function (env) {
              return run(Curry._1(fab, Curry._1(ea$1, env)), env);
            })
        };
}

function chainFirst(ea, fab) {
  var ea$1 = ea._0;
  return /* Reader */{
          _0: (function (env) {
              run(Curry._1(fab, Curry._1(ea$1, env)), env);
              return Curry._1(ea$1, env);
            })
        };
}

exports.make = make;
exports.run = run;
exports.ask = ask;
exports.local = local;
exports.map = map;
exports.chain = chain;
exports.chainFirst = chainFirst;
/* No side effect */