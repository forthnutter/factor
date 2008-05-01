! Copyright (C) 2007 Alex Chapman
! See http://factorcode.org/license.txt for BSD license.
USING: arrays morse strings tools.test ;

[ "" ] [ CHAR: \\ ch>morse ] unit-test
[ "..." ] [ CHAR: s ch>morse ] unit-test
[ CHAR: s ] [ "..." morse>ch ] unit-test
[ f ] [ "..--..--.." morse>ch ] unit-test
[ "-- --- .-. ... . / -.-. --- -.. ." ] [ "morse code" >morse ] unit-test
[ "morse code" ] [ "-- --- .-. ... . / -.-. --- -.. ." morse> ] unit-test
[ "hello, world!" ] [ "Hello, World!" >morse morse> ] unit-test
[ ] [ "sos" 0.075 play-as-morse ] unit-test
[ ] [ "Factor rocks!" play-as-morse ] unit-test
