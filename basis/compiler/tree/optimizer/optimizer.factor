! Copyright (C) 2008 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel namespaces
compiler.tree.normalization
compiler.tree.propagation
compiler.tree.cleanup
compiler.tree.escape-analysis
compiler.tree.tuple-unboxing
compiler.tree.def-use
compiler.tree.dead-code
compiler.tree.strength-reduction
compiler.tree.loop.detection
compiler.tree.finalization
compiler.tree.checker ;
IN: compiler.tree.optimizer

SYMBOL: check-optimizer?

: optimize-tree ( nodes -- nodes' )
    normalize
    propagate
    cleanup
    detect-loops
    escape-analysis
    unbox-tuples
    compute-def-use
    remove-dead-code
    ! strength-reduce
    check-optimizer? get [
        compute-def-use
        dup check-nodes
    ] when
    finalize ;