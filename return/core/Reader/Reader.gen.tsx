/* TypeScript file generated from Reader.res by genType. */
/* eslint-disable import/first */


// @ts-ignore: Implicit any on import
const Curry = require('rescript/lib/js/curry.js');

// @ts-ignore: Implicit any on import
const ReaderBS = require('./Reader.bs');

// tslint:disable-next-line:interface-over-type-literal
export type t<e,a> = { tag: "Reader"; value: (_1:e) => a };

export const make: <a,e>(ea:((_1:e) => a)) => t<e,a> = function <a,e>(Arg1: any) {
  const result = ReaderBS.make(Arg1);
  return {tag:"Reader", value:result._0}
};

export const run: <a,e>(r:t<e,a>, env:e) => a = function <a,e>(Arg1: any, Arg2: any) {
  const result = Curry._2(ReaderBS.run, {TAG: 0, _0:Arg1.value} as any, Arg2);
  return result
};

export const ask: <e>() => t<e,e> = function <e>() {
  const result = ReaderBS.ask();
  return {tag:"Reader", value:result._0}
};

export const local: <a,e>(r:t<e,a>, fe:((_1:e) => e)) => t<e,a> = function <a,e>(Arg1: any, Arg2: any) {
  const result = Curry._2(ReaderBS.local, {TAG: 0, _0:Arg1.value} as any, Arg2);
  return {tag:"Reader", value:result._0}
};

export const map: <a,b,e>(r:t<e,a>, fab:((_1:a) => b)) => t<e,b> = function <a,b,e>(Arg1: any, Arg2: any) {
  const result = Curry._2(ReaderBS.map, {TAG: 0, _0:Arg1.value} as any, Arg2);
  return {tag:"Reader", value:result._0}
};

export const chain: <a,b,e>(ea:t<e,a>, fab:((_1:a) => t<e,b>)) => t<e,b> = function <a,b,e>(Arg1: any, Arg2: any) {
  const result = Curry._2(ReaderBS.chain, {TAG: 0, _0:Arg1.value} as any, function (Arg11: any) {
      const result1 = Arg2(Arg11);
      return {TAG: 0, _0:result1.value} as any
    });
  return {tag:"Reader", value:result._0}
};

export const chainFirst: <a,b,e>(ea:t<e,a>, fab:((_1:a) => t<e,b>)) => t<e,a> = function <a,b,e>(Arg1: any, Arg2: any) {
  const result = Curry._2(ReaderBS.chainFirst, {TAG: 0, _0:Arg1.value} as any, function (Arg11: any) {
      const result1 = Arg2(Arg11);
      return {TAG: 0, _0:result1.value} as any
    });
  return {tag:"Reader", value:result._0}
};
