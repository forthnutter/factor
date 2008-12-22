! Copyright (C) 2007, 2008 Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: ui.tools.workspace kernel quotations accessors fry
assocs present math math.order math.vectors arrays locals
models.search models.sort models sequences vocabs
tools.profiler ui ui.commands ui.gadgets ui.gadgets.panes
ui.gadgets.scrollers ui.gadgets.tracks ui.gestures
ui.gadgets.buttons ui.gadgets.tables ui.gadgets.search-tables
ui.gadgets.labelled ui.gadgets.buttons ui.gadgets.packs
ui.gadgets.labels ui.gadgets.tabbed ;
FROM: models.filter => <filter> ;
FROM: models.compose => <compose> ;
IN: ui.tools.profiler

TUPLE: profiler-gadget < track sort vocabs vocab words ;

SINGLETON: profile-renderer

! Value is a { word count } pair
M: profile-renderer row-columns
    drop [ [ present ] map ] [ { "All" "" } ] if* ;

: <profiler-model> ( values profiler -- model )
    [ [ filter-counts ] <filter> ] [ sort>> ] bi* <sort> ;

: <words-model> ( profiler -- model )
    [
        [ words>> ] [ vocab>> ] bi
        [ [ [ first vocabulary>> ] [ first ] bi* = ] when* ] <search>
    ] keep <profiler-model> ;

: match? ( pair/f str -- ? )
    swap dup [ first present subseq? ] [ 2drop t ] if ;

: <profiler-table> ( model -- table )
    [ match? ] <search-table> profile-renderer >>renderer ;

: <vocab-model> ( profiler -- model )
    [ vocab-counters <model> ] dip
    <profiler-model> [ f prefix ] <filter> ;

: sort-options ( -- alist )
    {
        { [ [ first ] compare ] "by name" }
        { [ [ second ] compare invert-comparison ] "by call count" }
    } ;

: <sort-options> ( model -- gadget )
    sort-options <radio-buttons> { 1 0 } >>orientation ;

: <profiler-tool-bar> ( profiler -- gadget )
    <shelf>
        { 5 5 } >>gap
        over <toolbar> add-gadget
        "Sort by:" <label> add-gadget
        swap sort>> <sort-options> add-gadget ;

:: <words-tab> ( profiler -- gadget )
    { 1 0 } <track>
        profiler vocabs>> <profiler-table>
            profiler vocab>> >>selected-value
        "Vocabularies" <labelled-gadget>
    1/2 track-add
        profiler <words-model> <profiler-table>
        "Words" <labelled-gadget>
    1/2 track-add ;

:: <methods-tab> ( profiler -- gadget )
    { 0 1 } <track>
    { 1 0 } <track>
    f <model> <profiler-table> "Generic words" <labelled-gadget> 1/2 track-add
    f <model> <profiler-table> "Classes" <labelled-gadget> 1/2 track-add
    1/2 track-add
    f <model> <profiler-table> "Methods" <labelled-gadget> 1/2 track-add ;

: <profiler-gadget> ( -- profiler )
    { 0 1 } profiler-gadget new-track
        [ [ first ] compare ] <model> >>sort
        all-words counters <model> >>words
        dup <vocab-model> >>vocabs
        { f 0 } <model> >>vocab
        dup <profiler-tool-bar> f track-add
        <tabbed-gadget>
            over <words-tab> "Words" add-tab
            over <methods-tab> "Methods" add-tab
        1 track-add ;

M: profiler-gadget pref-dim* call-next-method { 700 400 } vmax ;

: profiler-help ( -- ) "ui-profiler" help-window ;

\ profiler-help H{ { +nullary+ t } } define-command

profiler-gadget "toolbar" f {
    { T{ key-down f f "F1" } profiler-help }
} define-command-map

: profiler-window ( -- )
    <profiler-gadget> "Profiling results" open-window ;

MAIN: profiler-window