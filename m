Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 19:39:24 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:50319 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225559AbUATTjY>;
	Tue, 20 Jan 2004 19:39:24 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1Aj1iY-0007kl-PL; Tue, 20 Jan 2004 14:39:18 -0500
Date: Tue, 20 Jan 2004 14:39:18 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Pavel Kiryukhin <savl@dev.rtsoft.ru>, linux-mips@linux-mips.org
Subject: Re: __MIPSEL__ in sys32_rt_sigtimedwait
Message-ID: <20040120193918.GA2108@nevyn.them.org>
References: <400D6877.1000105@dev.rtsoft.ru> <20040120183157.GB5495@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120183157.GB5495@linux-mips.org>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 20, 2004 at 07:31:57PM +0100, Ralf Baechle wrote:
> On Tue, Jan 20, 2004 at 08:42:15PM +0300, Pavel Kiryukhin wrote:
> 
> > Hi all,
> > my question - does endiannes matters in sigset translation in 
> > sys32_rt_sigtimedwait (arch/mips/signal32.c)?
> 
> Think about where bit 33 ends for a big endian machine with an without
> the conversion.

No, I'm pretty sure Pavel's right.

-#ifdef __MIPSEB__
    case 1: these.sig[0] = these32.sig[0] | (((long)these32.sig[1]) << 32);
-#endif
-#ifdef __MIPSEL__
-    case 1: these.sig[0] = these32.sig[1] | (((long)these32.sig[0]) << 32);
-#endif

Consider a 64-bit sigset.  32-bit userland, 64-bit kernel.  Here's a
userland sigset with signal 33 set, only, on a little endian target.
Word 1, least significant bit, right?

byte address in memory
	1	2	3	4	5	6	7	8
val	0	0	0	0	0	0	0	1

Obviously, as a 64-bit integer the sigset looks different.  There it's
supposed to be 1 << (33 - 1).
val	0	0	0	1	0	0	0	0

So the correct algorithm to convert a userspace sigset to a kernel
sigset is to shift the second word left 32 bits, and leave the first
word right aligned, and or them together.  Which is what using the
__MIPSEB__ case does.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
