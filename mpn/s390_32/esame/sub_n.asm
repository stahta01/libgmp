dnl  S/390-32 mpn_sub_n for systems with unsigned add/subtract instructions.

dnl  Copyright 2011 Free Software Foundation, Inc.

dnl  This file is part of the GNU MP Library.

dnl  The GNU MP Library is free software; you can redistribute it and/or modify
dnl  it under the terms of the GNU Lesser General Public License as published
dnl  by the Free Software Foundation; either version 3 of the License, or (at
dnl  your option) any later version.

dnl  The GNU MP Library is distributed in the hope that it will be useful, but
dnl  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
dnl  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
dnl  License for more details.

dnl  You should have received a copy of the GNU Lesser General Public License
dnl  along with the GNU MP Library.  If not, see http://www.gnu.org/licenses/.


include(`../config.m4')

C INPUT PARAMETERS
define(`rp',	`%r2')
define(`up',	`%r3')
define(`vp',	`%r4')
define(`n',	`%r5')

ASM_START()
PROLOGUE(mpn_sub_n)
	st	%r12, 48(%r15)
	slr	%r12, %r12		C zero index register and set C flag

L(top):	l	%r0, 0(%r12,up)
	l	%r1, 0(%r12,vp)
	slbr	%r0, %r1
	st	%r0, 0(%r12,rp)
	la	%r12, 4(%r12)
	brct	n, L(top)

	slbr	%r2, %r2
	lcr	%r2, %r2

	l	%r12, 48(%r15)
	br	%r14
EPILOGUE()