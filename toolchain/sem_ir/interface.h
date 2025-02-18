// Part of the Carbon Language project, under the Apache License v2.0 with LLVM
// Exceptions. See /LICENSE for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef CARBON_TOOLCHAIN_SEM_IR_INTERFACE_H_
#define CARBON_TOOLCHAIN_SEM_IR_INTERFACE_H_

#include "toolchain/sem_ir/ids.h"

namespace Carbon::SemIR {

// An interface.
struct Interface : public Printable<Interface> {
  auto Print(llvm::raw_ostream& out) const -> void {
    out << "{name: " << name_id << ", enclosing_scope: " << enclosing_scope_id
        << "}";
  }

  // Determines whether this interface has been fully defined. This is false
  // until we reach the `}` of the interface definition.
  auto is_defined() const -> bool { return defined; }

  // The following members always have values, and do not change throughout the
  // lifetime of the interface.

  // The interface name.
  NameId name_id;
  // The enclosing scope.
  NameScopeId enclosing_scope_id;
  // The first declaration of the interface. This is a InterfaceDecl.
  InstId decl_id;

  // The following members are set at the `{` of the interface definition.

  // The definition of the interface. This is a InterfaceDecl.
  InstId definition_id = InstId::Invalid;
  // The interface scope.
  NameScopeId scope_id = NameScopeId::Invalid;
  // The first block of the interface body.
  // TODO: Handle control flow in the interface body, such as if-expressions.
  InstBlockId body_block_id = InstBlockId::Invalid;

  // The following members are set at the `}` of the interface definition.
  bool defined = false;
};

}  // namespace Carbon::SemIR

#endif  // CARBON_TOOLCHAIN_SEM_IR_INTERFACE_H_
