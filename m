Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 13:57:55 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:13799 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225202AbTDDM5y>; Fri, 4 Apr 2003 13:57:54 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA08586;
	Fri, 4 Apr 2003 14:58:02 +0200 (MET DST)
Date: Fri, 4 Apr 2003 14:58:02 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Erik J. Green" <erik@greendragon.org>
cc: linux-mips@linux-mips.org
Subject: Re: Unknown ARCS message/hang
In-Reply-To: <1049427871.3e8cff9f9c50e@my.visi.com>
Message-ID: <Pine.GSO.3.96.1030404142811.7307B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1921
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Fri, 4 Apr 2003, Erik J. Green wrote:

> I get the following messages when I try to boot the (very slightly) modified
> linux kernel I am working with:
> 
> --start messages
> 
> Obtaining /vmlinux.64 from server
> 1813568+1150976+172144 entry: 0xa8000000211c4000
> 
> *** PROM write error on cacheline 0x1fcd3b00 at PC=0x211c4018 RA=0xffffffff9fc5ace4
> 
> --end messages
> 
> The PC address is the first instruction in head.S (mips64) that touches the
> control register.  I've tried multiple fixes, including initializing the whole
> TLB before the error occurs.  Same error.

 0x211c4018 is a mapped address, which you can't use that early in a boot.

> Can anyone tell me:
> 
> 1) What does this error text mean exactly? 

 An unhandled exception happened due to using a mapped address.  The PROM
caught it and reported. 

> 2) What is "RA"?  The address is a location in the PROM text/stack section.

 It's a CPU register, otherwise known as $31, where the return address is
stored by most of the jump-and-link and branch-and-link instructions.
Here it's an address in the PROM following the "jalr" instruction that
invoked the kernel.

> 3) Am I missing something simple?  An initialization, a rule I'm not following?

 You really want to link your kernel at a KSEG0 address (otherwise you'd
need to struggle with the kernel and the tools to get an unsupported yet
configuration to work).  Basically this means setting LOADADDR in
arch/mips64/Makefile appropriately.  See how it's done for other
platforms.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
