// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

// --- implicit.carbon

package Implicit api;

// CHECK:STDERR: implicit.carbon:[[@LINE+3]]:12: ERROR: Name `x` not found.
// CHECK:STDERR: var a_ref: x;
// CHECK:STDERR:            ^
var a_ref: x;
// CHECK:STDERR: implicit.carbon:[[@LINE+3]]:18: ERROR: Name `x` not found.
// CHECK:STDERR: var b_ref: {.a = x};
// CHECK:STDERR:                  ^
var b_ref: {.a = x};
// CHECK:STDERR: implicit.carbon:[[@LINE+3]]:13: ERROR: Name `x` not found.
// CHECK:STDERR: var c_ref: (x,);
// CHECK:STDERR:             ^
var c_ref: (x,);
// CHECK:STDERR: implicit.carbon:[[@LINE+3]]:12: ERROR: Name `x` not found.
// CHECK:STDERR: var d_ref: x*;
// CHECK:STDERR:            ^
var d_ref: x*;

// --- implicit.impl.carbon

package Implicit impl;

// In each of these cases, name lookup should succeed, but they should all have
// an error type.
var a: i32 = a_ref;
var b: i32 = b_ref;
var c: i32 = c_ref;
var d: i32 = d_ref;

// CHECK:STDOUT: --- implicit.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace {.a_ref = %a_ref, .b_ref = %b_ref, .c_ref = %c_ref, .d_ref = %d_ref} [template]
// CHECK:STDOUT:   %x.ref.loc7: <error> = name_ref x, <error> [template = <error>]
// CHECK:STDOUT:   %a_ref.var: ref <error> = var a_ref
// CHECK:STDOUT:   %a_ref: ref <error> = bind_name a_ref, %a_ref.var
// CHECK:STDOUT:   %x.ref.loc11: <error> = name_ref x, <error> [template = <error>]
// CHECK:STDOUT:   %.loc11: <error> = struct_literal (%x.ref.loc11)
// CHECK:STDOUT:   %b_ref.var: ref <error> = var b_ref
// CHECK:STDOUT:   %b_ref: ref <error> = bind_name b_ref, %b_ref.var
// CHECK:STDOUT:   %x.ref.loc15: <error> = name_ref x, <error> [template = <error>]
// CHECK:STDOUT:   %.loc15: <error> = tuple_literal (%x.ref.loc15)
// CHECK:STDOUT:   %c_ref.var: ref <error> = var c_ref
// CHECK:STDOUT:   %c_ref: ref <error> = bind_name c_ref, %c_ref.var
// CHECK:STDOUT:   %x.ref.loc19: <error> = name_ref x, <error> [template = <error>]
// CHECK:STDOUT:   %.loc19: type = ptr_type <error> [template = <error>]
// CHECK:STDOUT:   %d_ref.var: ref <error> = var d_ref
// CHECK:STDOUT:   %d_ref: ref <error> = bind_name d_ref, %d_ref.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: --- implicit.impl.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace {.a_ref = %import_ref.1, .b_ref = %import_ref.2, .c_ref = %import_ref.3, .d_ref = %import_ref.4, .a = %a, .b = %b, .c = %c, .d = %d} [template]
// CHECK:STDOUT:   %import_ref.1: ref <error> = import_ref ir1, inst+3, used
// CHECK:STDOUT:   %import_ref.2: ref <error> = import_ref ir1, inst+8, used
// CHECK:STDOUT:   %import_ref.3: ref <error> = import_ref ir1, inst+12, used
// CHECK:STDOUT:   %import_ref.4: ref <error> = import_ref ir1, inst+16, used
// CHECK:STDOUT:   %a.var: ref i32 = var a
// CHECK:STDOUT:   %a: ref i32 = bind_name a, %a.var
// CHECK:STDOUT:   %b.var: ref i32 = var b
// CHECK:STDOUT:   %b: ref i32 = bind_name b, %b.var
// CHECK:STDOUT:   %c.var: ref i32 = var c
// CHECK:STDOUT:   %c: ref i32 = bind_name c, %c.var
// CHECK:STDOUT:   %d.var: ref i32 = var d
// CHECK:STDOUT:   %d: ref i32 = bind_name d, %d.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %a_ref.ref: ref <error> = name_ref a_ref, file.%import_ref.1
// CHECK:STDOUT:   assign file.%a.var, <error>
// CHECK:STDOUT:   %b_ref.ref: ref <error> = name_ref b_ref, file.%import_ref.2
// CHECK:STDOUT:   assign file.%b.var, <error>
// CHECK:STDOUT:   %c_ref.ref: ref <error> = name_ref c_ref, file.%import_ref.3
// CHECK:STDOUT:   assign file.%c.var, <error>
// CHECK:STDOUT:   %d_ref.ref: ref <error> = name_ref d_ref, file.%import_ref.4
// CHECK:STDOUT:   assign file.%d.var, <error>
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
