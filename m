Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Aug 2008 20:11:54 +0100 (BST)
Received: from mail.zeugmasystems.com ([192.139.122.66]:16446 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20029049AbYHETLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 Aug 2008 20:11:45 +0100
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: looking for help interpreting softlockup/stack trace
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date:	Tue, 5 Aug 2008 12:11:34 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C5FC8DD5@exchange.ZeugmaSystems.local>
In-Reply-To: <48989AFE.5000500@nortel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: looking for help interpreting softlockup/stack trace
Thread-Index: Acj3KLiOCwuA6I93R8Kpre/ka5hwhwAAze7g
From:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
To:	"Chris Friesen" <cfriesen@nortel.com>, <linux-mips@linux-mips.org>,
	<ralf@linux-mips.org>
Return-Path: <KKylheku@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KKylheku@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Chris Friesem wrote:
> I've run into an interesting issue with an Octeon-based
> board, where it
> just seems to hang.  I suspect we're hitting some kind of
> locking bug,
> and I'm trying to track it down.  If it matters, the kernel
> is quite old
> (heavily patched 2.6.14) and I've got no chance of upgrading
> it.  (The
> usual embedded scenario.)
> 
> I've added some scheduler instrumentation, as well as adding a stack
> dump to the output of the softlockup code.
> 
> In the trace below, is "epc" the program counter at the time of the
> timer interrupt?  How does "ra" fit into this, given that the function
> whose address it contains isn't seen in the stack trace until quite a
> ways down?

Hi Chris

The contents of RA may or may not be useful. RA is used to hold the
return address when some branch instructions are executed. The contents
of RA may provide some kind of clue about what the
processor was doing previously. Often, RA can give you the parent
function, but not always.

Here it looks it does give the parent function; it is apparently
inside a kernel module called "vnb", which called _read_lock
and got stuck there.

Mind you, these Linux MIPS stack traces are not completely
trustworthy; the routine just walks the stack one word at a time
and prints out anything that looks like the address of code.
So the stack trace may include stale stack data from previous
call chains that have already returned. It also might not
include the full call chain, because the return address is not
always stored on the stack. For instance, here it looks like
RA is pointing into a kernel module. But you don't actually
see this in the fake stack trace. Nowhere in the stack trace
do you see _read_lock being called by c000000001b4ab9c.

I would proceed by inspecting this vnb module and its use of locks.

> 
> Any insights are greatly appreciated...
> 
> Chris
> 
> cpu9: jiffies: 4295366417, hrtime: 552015654907, 500 ms
> without calling
> schedule() since scheduler requested
> cpu1: jiffies: 4295366418, hrtime: 552016450325, 500 ms
> without calling
> schedule() since scheduler requested
> cpu3: jiffies: 4295366442, hrtime: 552034584838, 500 ms
> without calling
> schedule() since scheduler requested
> cpu9: jiffies: 4295367258, hrtime: 552646827014, 841 ms between
> scheduler_tick() calls BUG: soft lockup detected on CPU#0!
> Cpu 0
> $ 0   : 0000000000000000 0000000000000000 ffffffff80000000
> ffffffff00000000 $ 4   : a8000000db3ce808 0000000000000084
> a8000000d34cb1ea a8000000d34cb1ea $ 8   : 0000000045000084
> 0000000000000002 0000000000000001 ffffffff8165e1e0 $12   :
> 0000000000000000 ffffffff812dedac 0000500000008000 0000100000000000
> $16   : a8000000d3a40b68 a8000000db3ce580 a8000000d3a40b00
> ffffffff8151e448 $20   : a8000000db3ce808 ffffffff81593808
> a8000000d3a40b00 0000000000000000 $24   : 0000000000000030
> c000000001ae1820 $28   : ffffffff81590000 ffffffff81593680
> ffffffff81593810 c000000001b4ab9c Hi    : 0000000000000000 
> Lo    : 0000000000000000
> epc   : ffffffff8151e44c _read_lock+0x4/0x20     Tainted: P
> ra    : c000000001b4ab9c $LBB378+0x0/0x18 [vnb]
> Status: 1000ffe3    KX SX UX KERNEL EXL IE
> Cause : 40808000
> PrId  : 000d0301
> Call Trace:
>   [<ffffffff811a251c>] softlockup_tick+0x12c/0x158
>   [<ffffffff811126dc>] timer_interrupt+0xd4/0x4c8
>   [<ffffffff81112890>] timer_interrupt+0x288/0x4c8
>   [<ffffffff81101d50>] octeon_main_timer_interrupt+0x78/0x90
>   [<ffffffff811a2c24>] handle_IRQ_event+0x45c/0x1528
>   [<ffffffff811a3dc4>] __do_IRQ+0xd4/0x230
>   [<ffffffff8151e448>] _read_lock+0x0/0x20

This read lock is almost certainly a red herring; it's
stuff left over on the stack that hasn't been overwritten
by new activation chains.

>   [<ffffffff8110c4a8>] do_IRQ+0x440/0x1520

This is the timer interrupt going off, which ends up
detecting the lockup. So the problem is above here.


>   [<ffffffff8139263c>] neigh_lookup+0xb4/0x128

This may also be garbage. Basically, the stack
trace is not that useful, except that it provides
some additional circumstantial evidence implicating
the vnb module.
