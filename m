Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA24667; Mon, 13 May 1996 07:28:57 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id OAA18053 for linux-list; Mon, 13 May 1996 14:27:32 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA18044 for <linux@cthulhu.engr.sgi.com>; Mon, 13 May 1996 07:27:30 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA24594 for <lmlinux@neteng.engr.sgi.com>; Mon, 13 May 1996 07:27:29 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA18037 for <lmlinux@neteng.engr.sgi.com>; Mon, 13 May 1996 07:27:28 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id HAA02189; Mon, 13 May 1996 07:27:26 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id AAA28631; Mon, 13 May 1996 00:05:06 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id AAA05898; Mon, 13 May 1996 00:05:04 -0400
Date: Mon, 13 May 1996 00:05:04 -0400
Message-Id: <199605130405.AAA05898@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: tridge@cs.anu.edu.au
CC: lmlinux@neteng.engr.sgi.com, torvalds@cs.helsinki.fi
Subject: wicked checksum optimization...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I think I figured out how to do it all "the right way(tm)"

The big problem is alignment, but %97 of the time the buffer is
aligned how we like.  I've decided it is ok to take the hit of an
unaligned access trap for the %3 cases, but not that much of a hit.
The implementation looks like this:

All loads and stores in the ip checksum routines will look the same,
the only time we do stores is for the csum/copy routines.  Anyways the
eight instruction codes recognized will be for:

	ld	[%o0 + offset], %o4
	ld	[%o0 + offset], %o5
	lduh	[%o0 + offset], %o4
	lduh	[%o0 + offset], %o5
	st	%o4, [%g3 + offset]
	st	%o5, [%g3 + offset]
	sth	%o4, [%g3 + offset]
	sth	%o5, [%g3 + offset]

The unaligned trap handler (before it even tries to save any state)
will look something like:

mna_trap:
	andcc	%l0, PSR_PS, %g0
	be,a	mna_fromuser

	ld	[%l1], %l5
	sethi	%hi(LOAD_O4), %l4
	and	%l5, %l4, %l6
	cmp	%l6, %l4
	bne	1f
	 sethi	%hi(LOAD_O5), %l4
	mov	%l1, %g6				! %pc
	sethi	%hi(C_LABEL(csum_ldo4_fixup)), %l1
	or	%l1, %lo(C_LABEL(csum_ldo4_fixup)), %l1
	wr	%l0, 0x0, %psr				! fix cond-codes
	and	%l5, LOAD_IMMEDIATE_FIELD, %g7
	srl	%g7, LOAD_IMMEDIATE_SHIFT, %g7		! offset
	jmp	%l1
	rett	%l1 + 0x4

1:
	/* etc. for other instructions recognized */

mna_fromuser:
	SAVE_ALL
	/* From user mode or something we don't handle for the
	 * kernel.
	 */
	call	C_LABEL(do_mna)
	 nop
	RESTORE_ALL

Ok, now the fixup routines just look like:

csum_ldo4_fixup:
	ldub	[%o0 + %g7], %g4
	add	%g7, 1, %g7
	ldub	[%o0 + %g7], %g5
	sll	%g4, 24, %g4
	add	%g7, 1, %g7
	sll	%g5, 16, %g5
	or	%g4, %g5, %o4
	ldub	[%o0 + %g7], %g4
	add	%g7, 1, %g7
	ldub	[%o0 + %g7], %g5
	sll	%g4, 8, %g4
	or	%g5, %g4, %g4
	jmp	%g6		! wheee...
	or	%o4, %g4, %o4

and so on...  then csum_parial and friends can just blaze through
assuming proper alignment for all pointers to the packet contents
etc.  Nifty eh?  Sparc is fun...

Later,
David S. Miller
davem@caip.rutgers.edu
