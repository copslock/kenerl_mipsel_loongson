Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Jan 2004 19:28:19 +0000 (GMT)
Received: from ns.suse.de ([IPv6:::ffff:195.135.220.2]:40930 "EHLO
	Cantor.suse.de") by linux-mips.org with ESMTP id <S8224950AbUAYT2S>;
	Sun, 25 Jan 2004 19:28:18 +0000
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP
	id 044B7A2E8E; Sun, 25 Jan 2004 20:28:15 +0100 (CET)
Date: Sun, 25 Jan 2004 20:28:07 +0100
From: Andi Kleen <ak@suse.de>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: jh@suse.cz, echristo@redhat.com, hubicka@ucw.cz, eager@mvista.com,
	gcc@gcc.gnu.org, linux-mips@linux-mips.org
Subject: Re: GCC-3.4 reorders asm() with -O2
Message-Id: <20040125202807.2d786115.ak@suse.de>
In-Reply-To: <20040125182643.GA25020@linux-mips.org>
References: <4011C72C.613E25@mvista.com>
	<20040124011955.GA12040@nevyn.them.org>
	<20040124012303.GJ32288@atrey.karlin.mff.cuni.cz>
	<20040124050849.GB14951@nevyn.them.org>
	<1075009125.3649.0.camel@dzur.sfbay.redhat.com>
	<20040125100514.GA8810@kam.mff.cuni.cz>
	<20040125164758.79373419.ak@suse.de>
	<20040125170351.GA10938@nevyn.them.org>
	<20040125182643.GA25020@linux-mips.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <ak@suse.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ak@suse.de
Precedence: bulk
X-list: linux-mips

On Sun, 25 Jan 2004 19:26:43 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Sun, Jan 25, 2004 at 12:03:51PM -0500, Daniel Jacobowitz wrote:
> 
> > It is.  Ralf already knows about the problem, I think - we leave
> > markers outside of functions which define an entry point, save some
> > additional registers to the stack, and try to fall through to the
> > following function.  If the function gets emitted elsewhere, obviously,
> > we've lost :)
> > 
> > [This is save_static_function...]
> 
> I only recently fixed the problem with the save_static() inline function
> which of course was fragile, speculating on the compiler doing the
> right thing ...  I'll cook up a fix ...

You can always use __attribute__((noinline))

-Andi
