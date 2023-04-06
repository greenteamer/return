// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Ava = require("ava").default;
var Task = require("../return/core/Task/Task.bs.js");
var Js_exn = require("rescript/lib/js/js_exn.js");
var Pervasives = require("rescript/lib/js/pervasives.js");

Ava("Task. Execute Task program.", (async function (ctx) {
        var op = function (param) {
          return Promise.resolve(1);
        };
        var data;
        try {
          data = await Task.run(Task.make(op));
        }
        catch (exn){
          return Pervasives.failwith("Task can't fail.");
        }
        ctx.is(data, 1, undefined);
      }));

Ava("Task. Execute Task pipeline.", (async function (ctx) {
        var op = function (param) {
          return Promise.resolve(1);
        };
        var addOne = function (v) {
          return v + 1 | 0;
        };
        var addOneTask = function (v) {
          return Task.make(function (param) {
                      return Promise.resolve(v + 1 | 0);
                    });
        };
        var program = Task.chain(Task.chainFirst(Task.map(Task.make(op), addOne), (function (param) {
                    var marker = "[Task]";
                    return Task.make(async function (param$1) {
                                var str = "\n    👋 simple logger " + marker + "\n    value: " + String(param) + "";
                                console.log(str);
                              });
                  })), addOneTask);
        var data;
        try {
          data = await Task.run(program);
        }
        catch (exn){
          return Pervasives.failwith("Task can't fail.");
        }
        ctx.is(data, 3, undefined);
      }));

Ava("Task. Check if failed.", (function (ctx) {
        var failOp = function (param) {
          return Promise.reject(Js_exn.raiseError("error"));
        };
        return ctx.throwsAsync(Task.run(Task.make(failOp)), {
                    message: "[Task] run can't fail. error",
                    name: "Error"
                  }, undefined);
      }));

var T;

exports.T = T;
/*  Not a pure module */
