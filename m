Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2002 15:20:36 +0100 (MET)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:35539 "EHLO
	delta.ds2.pg.gda.pl") by ralf.linux-mips.org with ESMTP
	id <S870684AbSK2OU1>; Fri, 29 Nov 2002 15:20:27 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA27437;
	Fri, 29 Nov 2002 15:23:20 +0100 (MET)
Date: Fri, 29 Nov 2002 15:23:19 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: a quick question regarding CONFIG_MIPS_UNCACHED..
In-Reply-To: <20021129144246.A13295@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1021129150114.24948D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 29 Nov 2002, Ralf Baechle wrote:

> That's a consequence of the simplemost way to implement ll/sc in hardware.
> ll puts the physicall address of the the memory reference into c0_lladdr
> and sets the ll-bit.  eret clears the ll-bit and finally sc fails if the
> ll-bit is cleared.  That's the simplest implementation for a non-coherent
> uniprocessor, there is not much more needed that a flip-flop and due to
> every designers desire for simplicity a different implementation seem
> unlikely.  Btw, c0_lladdr is just a useless gadget here.

 Hmm, MIPS doesn't support external invalidation requests for non-coherent
areas, so eret/rfe appears to be the only way to reset the LLbit.  So we
may simply make the option depend on CONFIG_NONCOHERENT_IO=y.  It would
simplify the CML hassle, too.

> It's different for coherent processors, those actually need to snoop on
> the bus interface.  On those the simplest implementation is ll generates
> a cache line in exclusive state; sc then fails if either the ll-bit has
> been cleared; the snooping logic clears the ll-bit if the cache-line's
> state changes or an eret is executed.  So the mechanism fails without
> caches.

 Oh, I think a comparator using CP0.LLAddr for any bus cycles wouldn't be
much more complicated if at all.  But it would then spuriously fail for
noncoherent areas, so the actual implementation is better.

 So how about the following patch?

 And yes, the Carsten's argument is valid, too.  The option need not
necessarily be used to debug Linux -- it may be used to debug hardware or
to run on an incomplete implementation.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-2.4.20-pre6-20021129-mips-uncached-0
--- linux/arch/mips/config-shared.in.macro	Fri Nov 22 13:28:35 2002
+++ linux/arch/mips/config-shared.in	Fri Nov 29 14:13:53 2002
@@ -836,9 +836,7 @@ if [ "$CONFIG_AU1000_UART" = "y" -o "$CO
 fi
 bool 'Enable run-time debugging' CONFIG_DEBUG
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
-if [ "$CONFIG_SMP" != "y" ]; then
-   bool 'Run uncached' CONFIG_MIPS_UNCACHED
-fi
+dep_bool 'Run uncached' CONFIG_MIPS_UNCACHED $CONFIG_NONCOHERENT_IO
 endmenu
 
 source lib/Config.in
