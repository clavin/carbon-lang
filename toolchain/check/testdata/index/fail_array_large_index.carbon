// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
// AUTOUPDATE

var a: [i32; 1] = (12,);
// CHECK:STDERR: fail_array_large_index.carbon:[[@LINE+3]]:16: ERROR: Array index `295147905179352825855` is past the end of type `[i32; 1]`.
// CHECK:STDERR: var b: i32 = a[0xFFFFFFFFFFFFFFFFF];
// CHECK:STDERR:                ^~~~~~~~~~~~~~~~~~~
var b: i32 = a[0xFFFFFFFFFFFFFFFFF];

// CHECK:STDOUT: --- fail_array_large_index.carbon
// CHECK:STDOUT:
// CHECK:STDOUT: constants {
// CHECK:STDOUT:   %.1: i32 = int_literal 1 [template]
// CHECK:STDOUT:   %.2: type = array_type %.1, i32 [template]
// CHECK:STDOUT:   %.3: type = ptr_type [i32; 1] [template]
// CHECK:STDOUT:   %.4: i32 = int_literal 12 [template]
// CHECK:STDOUT:   %.5: type = tuple_type (i32) [template]
// CHECK:STDOUT:   %.6: i32 = int_literal 0 [template]
// CHECK:STDOUT:   %.7: [i32; 1] = tuple_value (%.4) [template]
// CHECK:STDOUT:   %.8: i32 = int_literal 295147905179352825855 [template]
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: file {
// CHECK:STDOUT:   package: <namespace> = namespace {.a = %a, .b = %b} [template]
// CHECK:STDOUT:   %.loc7_14: i32 = int_literal 1 [template = constants.%.1]
// CHECK:STDOUT:   %.loc7_15: type = array_type %.loc7_14, i32 [template = constants.%.2]
// CHECK:STDOUT:   %a.var: ref [i32; 1] = var a
// CHECK:STDOUT:   %a: ref [i32; 1] = bind_name a, %a.var
// CHECK:STDOUT:   %b.var: ref i32 = var b
// CHECK:STDOUT:   %b: ref i32 = bind_name b, %b.var
// CHECK:STDOUT: }
// CHECK:STDOUT:
// CHECK:STDOUT: fn @__global_init() {
// CHECK:STDOUT: !entry:
// CHECK:STDOUT:   %.loc7_20: i32 = int_literal 12 [template = constants.%.4]
// CHECK:STDOUT:   %.loc7_23.1: (i32,) = tuple_literal (%.loc7_20)
// CHECK:STDOUT:   %.loc7_23.2: i32 = int_literal 0 [template = constants.%.6]
// CHECK:STDOUT:   %.loc7_23.3: ref i32 = array_index file.%a.var, %.loc7_23.2
// CHECK:STDOUT:   %.loc7_23.4: init i32 = initialize_from %.loc7_20 to %.loc7_23.3 [template = constants.%.4]
// CHECK:STDOUT:   %.loc7_23.5: init [i32; 1] = array_init (%.loc7_23.4) to file.%a.var [template = constants.%.7]
// CHECK:STDOUT:   %.loc7_23.6: init [i32; 1] = converted %.loc7_23.1, %.loc7_23.5 [template = constants.%.7]
// CHECK:STDOUT:   assign file.%a.var, %.loc7_23.6
// CHECK:STDOUT:   %a.ref: ref [i32; 1] = name_ref a, file.%a
// CHECK:STDOUT:   %.loc11_16: i32 = int_literal 295147905179352825855 [template = constants.%.8]
// CHECK:STDOUT:   %.loc11_35.1: ref i32 = array_index %a.ref, %.loc11_16 [template = <error>]
// CHECK:STDOUT:   %.loc11_35.2: i32 = bind_value %.loc11_35.1
// CHECK:STDOUT:   assign file.%b.var, %.loc11_35.2
// CHECK:STDOUT:   return
// CHECK:STDOUT: }
// CHECK:STDOUT:
