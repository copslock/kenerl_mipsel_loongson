Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2007 23:53:20 +0000 (GMT)
Received: from mail.zeugmasystems.com ([70.79.96.174]:10058 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S28573704AbXKPXw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2007 23:52:56 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: futex_wake_op deadlock?
Date:	Fri, 16 Nov 2007 15:52:47 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C54DCBD2@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: futex_wake_op deadlock?
Thread-Index: Acgoq8nWvia3iCW7T1uI/ViIlK+6Mw==
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Hey everyone,

From time to time, on 2.6.17.7, I see a deadlock situation go off. The
soft lockup tick occurs in the middle of do_futex, which is heavily
inlined.  The system is actually hosed; it's not one of those
recoverable CPU busy situations that can sometimes trigger the lockup
detector.

The instruction that is interrupted by the soft lockup tick appears to
be in the assembly code (__futex_atomic_op) used by the futex_wake_op
function; the case is FUTEX_OP_SET.  It's the instruction just before
the load-linked; i.e. the interrupt is outside of the ll/sc loop.

I can't figure out how the code would get into a loop here. The ll/sc
logic should eventually succeed. There is a large loop in the overall
futex operation, but that is bounded by an interation variable
(attempt++).

(I checked the 2.6.17 head, but there doesn't appear to be any
futex-related work).

This lockup has reproduced more than once for us. Once at bootup, and
several times on shutdown.

The call stack always includes several do_futex frames, and a
compat_sys_futex/handle_sysn32 at the top of the chain.

This is from syslog (the unusual format is due to running metalog rather
than syslog in our distribution, and the human-readable time in the
square-bracketed printk timestamps is a locally developed patch):

Jan  3 02:47:02 [kernel] [02:47:02.953075]  [<ffffffff8016de8c>]
softlockup_tick+0x1bc/0x208
Jan  3 02:47:02 [kernel] [02:47:02.953121]  [<ffffffff8014cc54>]
update_process_times+0x9c/0xe8
Jan  3 02:47:02 [kernel] [02:47:02.953158]  [<ffffffff801098bc>]
ll_local_timer_interrupt+0x94/0xa8
Jan  3 02:47:02 [kernel] [02:47:02.953194]  [<ffffffff801026a0>]
plat_irq_dispatch+0x120/0x1a0
Jan  3 02:47:02 [kernel] [02:47:02.953221]  [<ffffffff80163758>]
do_futex+0x870/0xb58
Jan  3 02:47:02 [kernel] [02:47:02.953251]  [<ffffffff801637e0>]
do_futex+0x8f8/0xb58
Jan  3 02:47:02 [kernel] [02:47:02.953275]  [<ffffffff8047b16c>]
__lock_text_end+0x1b3c/0x474c
Jan  3 02:47:02 [kernel] [02:47:02.953312]  [<ffffffff8036fc40>]
sys_sendto+0xe8/0x140
Jan  3 02:47:02 [kernel] [02:47:02.953345]  [<ffffffff80163fac>]
compat_sys_futex+0x84/0x188
Jan  3 02:47:02 [kernel] [02:47:02.953372]  [<ffffffff80116314>]
handle_sysn32+0x54/0xb0

The sys_sendto is a red herring, since the backtrace function dumps
every single word on the stack as an address, not having any frame
pointers to go by.

The code surrounding ffffffff80163758:

ffffffff8016374c:	00023000 	sll	a2,v0,0x0
ffffffff80163750:	08058c77 	j	ffffffff801631dc
<do_futex+0x2f4>
ffffffff80163754:	00034000 	sll	a4,v1,0x0
ffffffff80163758:	0000102d 	move	v0,zero      <----<<
ffffffff8016375c:	c2030000 	ll	v1,0(s0)
ffffffff80163760:	00a0082d 	move	at,a1
ffffffff80163764:	e2010000 	sc	at,0(s0)
ffffffff80163768:	1020fffc 	beqz	at,ffffffff8016375c
<do_futex+0x874>
ffffffff8016376c:	00000000 	nop
ffffffff80163770:	0000000f 	sync
ffffffff80163774:	8f870024 	lw	a3,36(gp)
ffffffff80163778:	00023000 	sll	a2,v0,0x0
ffffffff8016377c:	08058c77 	j	ffffffff801631dc
<do_futex+0x2f4>

You can tell from the "move at, a1" that it's the FUTEX_OP_SET case.
