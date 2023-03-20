/* TypeScript file generated from Task.res by genType. */
/* eslint-disable import/first */


// @ts-ignore: Implicit any on import
const Curry = require('rescript/lib/js/curry.js');

// @ts-ignore: Implicit any on import
const TaskBS = require('./Task.bs');

// tslint:disable-next-line:interface-over-type-literal
export type t<a> = { tag: "Task"; value: () => Promise<a> };

export const make: <a>(ta:(() => Promise<a>)) => t<a> = function <a>(Arg1: any) {
  const result = TaskBS.make(Arg1);
  return {tag:"Task", value:result._0}
};

export const run: <a>(ta:t<a>) => Promise<a> = function <a>(Arg1: any) {
  const result = TaskBS.run({TAG: 0, _0:Arg1.value} as any);
  return result
};

export const map: <a,b>(ta:t<a>, fab:((_1:a) => b)) => t<b> = function <a,b>(Arg1: any, Arg2: any) {
  const result = Curry._2(TaskBS.map, {TAG: 0, _0:Arg1.value} as any, Arg2);
  return {tag:"Task", value:result._0}
};

export const chain: <a,b>(ta:t<a>, fab:((_1:a) => t<b>)) => t<b> = function <a,b>(Arg1: any, Arg2: any) {
  const result = Curry._2(TaskBS.chain, {TAG: 0, _0:Arg1.value} as any, function (Arg11: any) {
      const result1 = Arg2(Arg11);
      return {TAG: 0, _0:result1.value} as any
    });
  return {tag:"Task", value:result._0}
};

export const chainFirst: <a,b>(ta:t<a>, fab:((_1:a) => t<b>)) => t<a> = function <a,b>(Arg1: any, Arg2: any) {
  const result = Curry._2(TaskBS.chainFirst, {TAG: 0, _0:Arg1.value} as any, function (Arg11: any) {
      const result1 = Arg2(Arg11);
      return {TAG: 0, _0:result1.value} as any
    });
  return {tag:"Task", value:result._0}
};
