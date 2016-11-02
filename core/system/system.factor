! Copyright (c) 2007, 2010 slava pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors assocs continuations init io kernel kernel.private make
math math.parser namespaces sequences ;
IN: system

PRIMITIVE: (exit) ( n -- * )
PRIMITIVE: disable-ctrl-break ( -- )
PRIMITIVE: enable-ctrl-break ( -- )
PRIMITIVE: nano-count ( -- ns )

SINGLETONS: x86.32 x86.64 arm ppc.32 ppc.64 ;

UNION: x86 x86.32 x86.64 ;
UNION: ppc ppc.32 ppc.64 ;

: cpu ( -- class ) \ cpu get-global ; foldable

SINGLETONS: windows macosx linux ;

UNION: unix macosx linux ;

: os ( -- class ) \ os get-global ; foldable

: vm-version ( -- string ) \ vm-version get-global ;

: vm-git-label ( -- string ) \ vm-git-label get-global ;

: vm-git-ref ( -- string )
    vm-git-label CHAR: - over last-index head ;

: vm-git-id ( -- string )
    vm-git-label CHAR: - over last-index 1 + tail ;

: vm-compiler ( -- string ) \ vm-compiler get-global ;

: vm-compile-time ( -- string ) \ vm-compile-time get-global ;

: image-path ( -- path ) \ image-path get-global ;

: vm-path ( -- path ) \ vm-path get-global ;

: embedded? ( -- ? ) OBJ-EMBEDDED special-object ;

: version-info ( -- str )
    ! formatting vocab not available in this context.
    [
        "Factor " % vm-version %
        " " % cpu name>> %
        " (" % build # ", " %
        vm-git-ref % "-" %
        vm-git-id 10 short head % ", " %
        vm-compile-time % ")\n[" %
        vm-compiler % "] on " % os name>> %
    ] "" make ;

: exit ( n -- * )
    [ do-shutdown-hooks (exit) ] ignore-errors
    [ "Unexpected error during shutdown!" print ] ignore-errors
    255 (exit) ;
