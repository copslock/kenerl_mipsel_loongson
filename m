Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Nov 2002 14:56:31 +0100 (MET)
Received: from onda.linux-mips.net ([IPv6:::ffff:192.168.169.2]:54697 "EHLO
	dea.linux-mips.net") by ralf.linux-mips.org with ESMTP
	id <S870673AbSK2N4X>; Fri, 29 Nov 2002 14:56:23 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gATDgkR13634;
	Fri, 29 Nov 2002 14:42:46 +0100
Date: Fri, 29 Nov 2002 14:42:46 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: atul srivastava <atulsrivastava9@rediffmail.com>,
	linux-mips@linux-mips.org
Subject: Re: a quick question regarding CONFIG_MIPS_UNCACHED..
Message-ID: <20021129144246.A13295@linux-mips.org>
References: <20021129134230.A11704@linux-mips.org> <Pine.GSO.3.96.1021129135000.24948B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1021129135000.24948B-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Fri, Nov 29, 2002 at 02:03:00PM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 744
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 29, 2002 at 02:03:00PM +0100, Maciej W. Rozycki wrote:

>  BTW, how do you know that ll/sc happens to work for uncached operation on
> some processors?  Maybe it simply fails, but the result is subtle enough
> not to be observed easily.  A failure may be masked by other factors, e.g. 
> for the UP operation, there is normally no way for two parallel requests
> for a spinlock to happen and an exception resets the LLbit regardless of
> the caching attribute of the area involved.

That's a consequence of the simplemost way to implement ll/sc in hardware.
ll puts the physicall address of the the memory reference into c0_lladdr
and sets the ll-bit.  eret clears the ll-bit and finally sc fails if the
ll-bit is cleared.  That's the simplest implementation for a non-coherent
uniprocessor, there is not much more needed that a flip-flop and due to
every designers desire for simplicity a different implementation seem
unlikely.  Btw, c0_lladdr is just a useless gadget here.

It's different for coherent processors, those actually need to snoop on
the bus interface.  On those the simplest implementation is ll generates
a cache line in exclusive state; sc then fails if either the ll-bit has
been cleared; the snooping logic clears the ll-bit if the cache-line's
state changes or an eret is executed.  So the mechanism fails without
caches.

  Ralf
