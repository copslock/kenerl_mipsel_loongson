Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2004 18:26:49 +0000 (GMT)
Received: from p508B7347.dip.t-dialin.net ([IPv6:::ffff:80.139.115.71]:21628
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224950AbUAYS0t>; Sun, 25 Jan 2004 18:26:49 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i0PIQkex025076;
	Sun, 25 Jan 2004 19:26:46 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i0PIQh4c025075;
	Sun, 25 Jan 2004 19:26:43 +0100
Date: Sun, 25 Jan 2004 19:26:43 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Andi Kleen <ak@suse.de>, Jan Hubicka <jh@suse.cz>,
	echristo@redhat.com, hubicka@ucw.cz, eager@mvista.com,
	gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: GCC-3.4 reorders asm() with -O2
Message-ID: <20040125182643.GA25020@linux-mips.org>
References: <4011C72C.613E25@mvista.com> <20040124011955.GA12040@nevyn.them.org> <20040124012303.GJ32288@atrey.karlin.mff.cuni.cz> <20040124050849.GB14951@nevyn.them.org> <1075009125.3649.0.camel@dzur.sfbay.redhat.com> <20040125100514.GA8810@kam.mff.cuni.cz> <20040125164758.79373419.ak@suse.de> <20040125170351.GA10938@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125170351.GA10938@nevyn.them.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 25, 2004 at 12:03:51PM -0500, Daniel Jacobowitz wrote:

> It is.  Ralf already knows about the problem, I think - we leave
> markers outside of functions which define an entry point, save some
> additional registers to the stack, and try to fall through to the
> following function.  If the function gets emitted elsewhere, obviously,
> we've lost :)
> 
> [This is save_static_function...]

I only recently fixed the problem with the save_static() inline function
which of course was fragile, speculating on the compiler doing the
right thing ...  I'll cook up a fix ...

  Ralf
