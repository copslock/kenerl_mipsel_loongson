Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2004 12:10:50 +0000 (GMT)
Received: from p508B5D28.dip.t-dialin.net ([IPv6:::ffff:80.139.93.40]:5187
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225220AbUAZMKt>; Mon, 26 Jan 2004 12:10:49 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0QCAkex012175
	for <linux-mips@linux-mips.org>; Mon, 26 Jan 2004 13:10:46 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0QCAkAB012174
	for linux-mips@linux-mips.org; Mon, 26 Jan 2004 13:10:46 +0100
Resent-Message-Id: <200401261210.i0QCAkAB012174@fluff.linux-mips.net>
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0Q8aoex008348;
	Mon, 26 Jan 2004 09:36:50 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0Q8alg3008347;
	Mon, 26 Jan 2004 09:36:47 +0100
Date: Mon, 26 Jan 2004 09:36:47 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andi Kleen <ak@suse.de>
Cc: jh@suse.cz, echristo@redhat.com, hubicka@ucw.cz, eager@mvista.com,
	gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: GCC-3.4 reorders asm() with -O2
Message-ID: <20040126083647.GA28612@linux-mips.org>
References: <4011C72C.613E25@mvista.com> <20040124011955.GA12040@nevyn.them.org> <20040124012303.GJ32288@atrey.karlin.mff.cuni.cz> <20040124050849.GB14951@nevyn.them.org> <1075009125.3649.0.camel@dzur.sfbay.redhat.com> <20040125100514.GA8810@kam.mff.cuni.cz> <20040125164758.79373419.ak@suse.de> <20040125170351.GA10938@nevyn.them.org> <20040125182643.GA25020@linux-mips.org> <20040125202807.2d786115.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125202807.2d786115.ak@suse.de>
User-Agent: Mutt/1.4.1i
Resent-From: ralf@linux-mips.org
Resent-Date: Mon, 26 Jan 2004 13:10:46 +0100
Resent-To: linux-mips@linux-mips.org
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 25, 2004 at 08:28:07PM +0100, Andi Kleen wrote:

> > > It is.  Ralf already knows about the problem, I think - we leave
> > > markers outside of functions which define an entry point, save some
> > > additional registers to the stack, and try to fall through to the
> > > following function.  If the function gets emitted elsewhere, obviously,
> > > we've lost :)
> > > 
> > > [This is save_static_function...]
> > 
> > I only recently fixed the problem with the save_static() inline function
> > which of course was fragile, speculating on the compiler doing the
> > right thing ...  I'll cook up a fix ...
> 
> You can always use __attribute__((noinline))

Not in this particular case.   save_static's purpose was saving all
caller saved registers into the stack so they can be accessed via the
usual struct pt_regs pointer and to make that work it to be inline before
any change of these registers.  That was a small optimization but it also
was fragile so I removed that.  save_static_function was meant to be
used immediately preceeding a syscall's C function and served the same
purpose.  As the implementation ``knew'' gcc wasn't going to move around
the code just falling though worked fine but again that was fragile.

  Ralf
