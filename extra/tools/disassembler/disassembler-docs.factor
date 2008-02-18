IN: tools.disassembler
USING: help.markup help.syntax sequences.private ;

HELP: disassemble
{ $values { "obj" "a word or a pair of addresses" } }
{ $description "Disassembles either a compiled word definition or an arbitrary memory range (in the case " { $snippet "obj" } " is a pair of integers) by attaching " { $snippet "gdb" } " to the Factor VM and capturing the output." }
{ $notes "In some cases the Factor compiler emits data inline with code, which can confuse " { $snippet "gdb" } ". This occurs in words which call " { $link dispatch } ", where the jump table addresses are compiled inline. Also on the ARM architecture, various pointers are often compiled inline, and the preceeding instruction jumps over the inline pinter." } ;

ARTICLE: "tools.disassembler" "Disassembling words"
"The " { $vocab-link "tools.disassembler" } " vocabulary integrates Factor with the GNU debugger (" { $snippet "gdb" } ") for viewing the assembly code generated by the compiler. It can be used on both Unix and Windows as long as a working copy of " { $snippet "gdb" } " is installed and available in the " { $snippet "PATH" } "."
{ $subsection disassemble } ;

ABOUT: "tools.disassembler"
