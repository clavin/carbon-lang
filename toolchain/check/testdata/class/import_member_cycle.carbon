// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- a.carbon

library "a" api;

class Cycle {
  var a: Cycle*;
}

// --- b.carbon

library "b" api;

import library "a";

fn Run() {
  var a: Cycle*;
}

// CHECK:STDOUT: --- a.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Cycle: type = class_type @Cycle [template]
// CHECK:STDOUT:   %.1: type = ptr_type Cycle [template]
// CHECK:STDOUT:   %.2: type = unbound_element_type Cycle, Cycle* [template]
// CHECK:STDOUT:   %.3: type = struct_type {.a: Cycle*} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace {.Cycle = %Cycle.decl} [template]
// CHECK:STDOUT:   %Cycle.decl = class_decl @Cycle, () [template = constants.%Cycle]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Cycle {
// CHECK:STDOUT:   %Cycle.ref: type = name_ref Cycle, file.%Cycle.decl [template = constants.%Cycle]
// CHECK:STDOUT:   %.loc5_15: type = ptr_type Cycle [template = constants.%.1]
// CHECK:STDOUT:   %.loc5_8: <unbound element of class Cycle> = field_decl a, element0 [template]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .a = %.loc5_8
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- b.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Cycle: type = class_type @Cycle [template]
// CHECK:STDOUT:   %.1: type = ptr_type Cycle [template]
// CHECK:STDOUT:   %.2: type = struct_type {.a: Cycle*} [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace {.Cycle = %import_ref, .Run = %Run} [template]
// CHECK:STDOUT:   %import_ref: type = import_ref ir1, inst+1, used [template = constants.%Cycle]
// CHECK:STDOUT:   %Run: <function> = fn_decl @Run [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Cycle {
// CHECK:STDOUT:   %import_ref = import_ref ir1, inst+7, unused
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .a = %import_ref
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Run() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Cycle.decl = class_decl @Cycle, () [template = constants.%Cycle]
// CHECK:STDOUT:   %Cycle.ref: type = name_ref Cycle, file.%import_ref [template = constants.%Cycle]
// CHECK:STDOUT:   %.loc7: type = ptr_type Cycle [template = constants.%.1]
// CHECK:STDOUT:   %a.var: ref Cycle* = var a
// CHECK:STDOUT:   %a: ref Cycle* = bind_name a, %a.var
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
