Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Feb 2008 22:58:57 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:10159
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20032551AbYBCW6t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 3 Feb 2008 22:58:49 +0000
Received: from router-wag54gp2 ([192.168.1.33] helo=[192.168.1.2])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JLnnM-00019r-3p
	for linux-mips@linux-mips.org; Sun, 03 Feb 2008 23:58:42 +0100
Subject: Re: new type of crash report?
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <47A5F580.8080300@mips.com>
References: <1202050578.7035.11.camel@scarafaggio>
	 <5BFC57F9-7E81-4667-9D15-72F5F20FA4DD@27m.se>
	 <1202054465.7035.20.camel@scarafaggio>  <47A5F580.8080300@mips.com>
Content-Type: text/plain
Date:	Sun, 03 Feb 2008 23:59:34 +0100
Message-Id: <1202079574.18109.6.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.12.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi Kevin,

Il giorno dom, 03/02/2008 alle 18.10 +0100, Kevin D. Kissell ha scritto:
> Giuseppe Sacco wrote: 
[...]
> > Thanks for your reply. I will try to understand how to use gdb on this
> > context. (Any URI would be really appreciated.)
> > Anyway I now understood that a dbe is a data bus error, so probably this
> > is an error on the physical address, i.e. a kernel problem related to
> > the mapping between vertical and physical addresses. Is this correct?
> >   
> That's correct.  You didn't say what processor you were running on, so
> it's hard to be more specific - there are some which have a bus error
> input pin that can be asserted by the system for other reasons - but
> in general it means that there's a data reference at 0x2ac2bffc whose
> valid translation goes to a bad address.  Generally, that address
> range is where shared libraries are mapped, so to find the instruction
> you want to run the program that caused the crash under gdb, set a
> breakpoint very early (e.g. main), run to the breakpoint, and
> disassemble the virtual address.  I find it interesting that the
> register value reported for register $10 is a reasonable data address
> shifted up by 32 bits.  It's possible that code would have a real
> reason to do that, but I can't help wonder if that isn't part of the
> problem. We may be looking at a 2-level bug here:  User(?) code
> screwing up a base register used for a load or store, and the OS
> failing to handle the upper reaches of the 64-bit address space
> correctly.

The complete bug report is available at http://bugs.debian.org/463808.
The cpu is an "R5000 V2.1  FPU V1.0".

The system is Debian stable, running mainly with courier-imap-ssl and
exim4 (often in TLS mode).

I cannot find a single program to debug, but I know for sure that if I
leave the machine with those two daemons, it will hung in about 30
minutes. If I run a kernel build (using gcc-4.2 from dDebian testing),
then the machine hungs in a few minutes. One time out of three gcc get a
segmentation fault, other two times the machine stop.

Thanks for your help,
Giuseppe
