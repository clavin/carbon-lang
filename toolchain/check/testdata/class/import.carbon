// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- a.carbon

library "a" api;

class Empty {
}

class Field {
  var x: i32;
}

class ForwardDeclared;

class ForwardDeclared {
  fn F[self: Self]();
  fn G[addr self: Self*]();
}

class Incomplete;

// --- b.carbon

library "b" api;

import library "a";

fn Run() {
  var a: Empty = {};

  var b: Field = {.x = 1};
  b.x = 2;

  var c: ForwardDeclared = {};
  c.F();
  c.G();

  var d: ForwardDeclared* = &c;

  var e: Incomplete*;
}

// CHECK:STDOUT: --- a.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Empty: type = class_type @Empty [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %Field: type = class_type @Field [template]
// CHECK:STDOUT:   %.2: type = unbound_element_type Field, i32 [template]
// CHECK:STDOUT:   %.3: type = struct_type {.x: i32} [template]
// CHECK:STDOUT:   %ForwardDeclared: type = class_type @ForwardDeclared [template]
// CHECK:STDOUT:   %.4: type = ptr_type ForwardDeclared [template]
// CHECK:STDOUT:   %Incomplete: type = class_type @Incomplete [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace {.Empty = %Empty.decl, .Field = %Field.decl, .ForwardDeclared = %ForwardDeclared.decl.loc11, .Incomplete = %Incomplete.decl} [template]
// CHECK:STDOUT:   %Empty.decl = class_decl @Empty, () [template = constants.%Empty]
// CHECK:STDOUT:   %Field.decl = class_decl @Field, () [template = constants.%Field]
// CHECK:STDOUT:   %ForwardDeclared.decl.loc11 = class_decl @ForwardDeclared, () [template = constants.%ForwardDeclared]
// CHECK:STDOUT:   %ForwardDeclared.decl.loc13 = class_decl @ForwardDeclared, () [template = constants.%ForwardDeclared]
// CHECK:STDOUT:   %Incomplete.decl = class_decl @Incomplete, () [template = constants.%Incomplete]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Empty {
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Field {
// CHECK:STDOUT:   %.loc8: <unbound element of class Field> = field_decl x, element0 [template]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .x = %.loc8
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @ForwardDeclared {
// CHECK:STDOUT:   %F: <function> = fn_decl @F [template]
// CHECK:STDOUT:   %G: <function> = fn_decl @G [template]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .F = %F
// CHECK:STDOUT:   .G = %G
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Incomplete;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F[%self: ForwardDeclared]();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G[addr %self: ForwardDeclared*]();
// CHECK:STDOUT:
// CHECK:STDOUT: --- b.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %Empty: type = class_type @Empty [template]
// CHECK:STDOUT:   %.1: type = struct_type {} [template]
// CHECK:STDOUT:   %.2: type = tuple_type () [template]
// CHECK:STDOUT:   %.3: type = ptr_type {} [template]
// CHECK:STDOUT:   %.4: Empty = struct_value () [template]
// CHECK:STDOUT:   %Field: type = class_type @Field [template]
// CHECK:STDOUT:   %.5: type = struct_type {.x: i32} [template]
// CHECK:STDOUT:   %.6: type = ptr_type {.x: i32} [template]
// CHECK:STDOUT:   %.7: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.8: Field = struct_value (%.7) [template]
// CHECK:STDOUT:   %.9: type = unbound_element_type Field, i32 [template]
// CHECK:STDOUT:   %.10: i32 = int_literal 2 [template]
// CHECK:STDOUT:   %ForwardDeclared: type = class_type @ForwardDeclared [template]
// CHECK:STDOUT:   %.11: ForwardDeclared = struct_value () [template]
// CHECK:STDOUT:   %.12: type = ptr_type ForwardDeclared [template]
// CHECK:STDOUT:   %Incomplete: type = class_type @Incomplete [template]
// CHECK:STDOUT:   %.13: type = ptr_type Incomplete [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace {.Empty = %import_ref.1, .Field = %import_ref.2, .ForwardDeclared = %import_ref.3, .Incomplete = %import_ref.4, .Run = %Run} [template]
// CHECK:STDOUT:   %import_ref.1: type = import_ref ir1, inst+1, used [template = constants.%Empty]
// CHECK:STDOUT:   %import_ref.2: type = import_ref ir1, inst+4, used [template = constants.%Field]
// CHECK:STDOUT:   %import_ref.3: type = import_ref ir1, inst+11, used [template = constants.%ForwardDeclared]
// CHECK:STDOUT:   %import_ref.4: type = import_ref ir1, inst+25, used [template = constants.%Incomplete]
// CHECK:STDOUT:   %Run: <function> = fn_decl @Run [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Empty {
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Field {
// CHECK:STDOUT:   %import_ref: <unbound element of class Field> = import_ref ir1, inst+7, used [template = imports.%.1]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .x = %import_ref
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @ForwardDeclared {
// CHECK:STDOUT:   %import_ref.1: <function> = import_ref ir1, inst+24, used [template = imports.%G]
// CHECK:STDOUT:   %import_ref.2: <function> = import_ref ir1, inst+17, used [template = imports.%F]
// CHECK:STDOUT:
// CHECK:STDOUT: !members:
// CHECK:STDOUT:   .G = %import_ref.1
// CHECK:STDOUT:   .F = %import_ref.2
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: class @Incomplete;
// CHECK:STDOUT:
// CHECK:STDOUT: fn @Run() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %Empty.decl = class_decl @Empty, () [template = constants.%Empty]
// CHECK:STDOUT:   %Empty.ref: type = name_ref Empty, file.%import_ref.1 [template = constants.%Empty]
// CHECK:STDOUT:   %a.var: ref Empty = var a
// CHECK:STDOUT:   %a: ref Empty = bind_name a, %a.var
// CHECK:STDOUT:   %.loc7_19.1: {} = struct_literal ()
// CHECK:STDOUT:   %.loc7_19.2: init Empty = class_init (), %a.var [template = constants.%.4]
// CHECK:STDOUT:   %.loc7_19.3: init Empty = converted %.loc7_19.1, %.loc7_19.2 [template = constants.%.4]
// CHECK:STDOUT:   assign %a.var, %.loc7_19.3
// CHECK:STDOUT:   %Field.decl = class_decl @Field, () [template = constants.%Field]
// CHECK:STDOUT:   %Field.ref: type = name_ref Field, file.%import_ref.2 [template = constants.%Field]
// CHECK:STDOUT:   %b.var: ref Field = var b
// CHECK:STDOUT:   %b: ref Field = bind_name b, %b.var
// CHECK:STDOUT:   %.loc9_24: i32 = int_literal 1 [template = constants.%.7]
// CHECK:STDOUT:   %.loc9_25.1: {.x: i32} = struct_literal (%.loc9_24)
// CHECK:STDOUT:   %.loc9_25.2: ref i32 = class_element_access %b.var, element0
// CHECK:STDOUT:   %.loc9_25.3: init i32 = initialize_from %.loc9_24 to %.loc9_25.2 [template = constants.%.7]
// CHECK:STDOUT:   %.loc9_25.4: init Field = class_init (%.loc9_25.3), %b.var [template = constants.%.8]
// CHECK:STDOUT:   %.loc9_25.5: init Field = converted %.loc9_25.1, %.loc9_25.4 [template = constants.%.8]
// CHECK:STDOUT:   assign %b.var, %.loc9_25.5
// CHECK:STDOUT:   %b.ref: ref Field = name_ref b, %b
// CHECK:STDOUT:   %.loc10_4: ref i32 = class_element_access %b.ref, element0
// CHECK:STDOUT:   %.loc10_9: i32 = int_literal 2 [template = constants.%.10]
// CHECK:STDOUT:   assign %.loc10_4, %.loc10_9
// CHECK:STDOUT:   %ForwardDeclared.decl = class_decl @ForwardDeclared, () [template = constants.%ForwardDeclared]
// CHECK:STDOUT:   %ForwardDeclared.ref.loc12: type = name_ref ForwardDeclared, file.%import_ref.3 [template = constants.%ForwardDeclared]
// CHECK:STDOUT:   %c.var: ref ForwardDeclared = var c
// CHECK:STDOUT:   %c: ref ForwardDeclared = bind_name c, %c.var
// CHECK:STDOUT:   %.loc12_29.1: {} = struct_literal ()
// CHECK:STDOUT:   %.loc12_29.2: init ForwardDeclared = class_init (), %c.var [template = constants.%.11]
// CHECK:STDOUT:   %.loc12_29.3: init ForwardDeclared = converted %.loc12_29.1, %.loc12_29.2 [template = constants.%.11]
// CHECK:STDOUT:   assign %c.var, %.loc12_29.3
// CHECK:STDOUT:   %c.ref.loc13: ref ForwardDeclared = name_ref c, %c
// CHECK:STDOUT:   %.loc13_4: <bound method> = bound_method %c.ref.loc13, @ForwardDeclared.%import_ref.2
// CHECK:STDOUT:   %.loc13_3: ForwardDeclared = bind_value %c.ref.loc13
// CHECK:STDOUT:   %.loc13_6: init () = call %.loc13_4(%.loc13_3)
// CHECK:STDOUT:   %c.ref.loc14: ref ForwardDeclared = name_ref c, %c
// CHECK:STDOUT:   %.loc14_4: <bound method> = bound_method %c.ref.loc14, @ForwardDeclared.%import_ref.1
// CHECK:STDOUT:   %.loc14_3: ForwardDeclared* = addr_of %c.ref.loc14
// CHECK:STDOUT:   %.loc14_6: init () = call %.loc14_4(%.loc14_3)
// CHECK:STDOUT:   %ForwardDeclared.ref.loc16: type = name_ref ForwardDeclared, file.%import_ref.3 [template = constants.%ForwardDeclared]
// CHECK:STDOUT:   %.loc16_25: type = ptr_type ForwardDeclared [template = constants.%.12]
// CHECK:STDOUT:   %d.var: ref ForwardDeclared* = var d
// CHECK:STDOUT:   %d: ref ForwardDeclared* = bind_name d, %d.var
// CHECK:STDOUT:   %c.ref.loc16: ref ForwardDeclared = name_ref c, %c
// CHECK:STDOUT:   %.loc16_29: ForwardDeclared* = addr_of %c.ref.loc16
// CHECK:STDOUT:   assign %d.var, %.loc16_29
// CHECK:STDOUT:   %Incomplete.decl = class_decl @Incomplete, () [template = constants.%Incomplete]
// CHECK:STDOUT:   %Incomplete.ref: type = name_ref Incomplete, file.%import_ref.4 [template = constants.%Incomplete]
// CHECK:STDOUT:   %.loc18: type = ptr_type Incomplete [template = constants.%.13]
// CHECK:STDOUT:   %e.var: ref Incomplete* = var e
// CHECK:STDOUT:   %e: ref Incomplete* = bind_name e, %e.var
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @F[%self: ForwardDeclared]();
// CHECK:STDOUT:
// CHECK:STDOUT: fn @G[addr %self: ForwardDeclared*]();
// CHECK:STDOUT:
