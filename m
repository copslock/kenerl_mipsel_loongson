Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2003 17:30:00 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:11677 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224827AbTDGQ37>; Mon, 7 Apr 2003 17:29:59 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA26755;
	Mon, 7 Apr 2003 18:30:18 +0200 (MET DST)
Date: Mon, 7 Apr 2003 18:30:18 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Erik J. Green" <erik@greendragon.org>
cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: 64 to 32 bit jr
In-Reply-To: <1049727719.3e9192e77cc49@my.visi.com>
Message-ID: <Pine.GSO.3.96.1030407174523.24634D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Mon, 7 Apr 2003, Erik J. Green wrote:

> >  0xa8000000211c4000 is indeed in XKPHYS but the code jumps to 0x211c4018.
> 
> Okay, I want to make sure I understand the addressing correctly for the 64 to 32
> bit jump.  The existing code for the IP27 (seems to load at about
> a800000000000000, which is one of the segments in xkphys, corresponding to
> physical memory starting at address 0.  Head.S then jumps to the 32-bit part of
> the xkphys address, which happens to be arranged so that it matches the correct
> (next instruction) address in kseg0.

 Just see how these virtual addresses map to physical ones.

> I am unable to arrange my addresses similarly neatly, mostly I think due to
> fighting with the toolchain I have.  Is it "legal" for me to load a kernel using
> the xkphys address and then do something like:
> 
> lui    t0,0x8000
> addiu  t0,t0,@next
> jr     t0
> nop
> next:

 You need to do:

lui	t0,%hi(next)
addiu	t0,%lo(next)

or use the "la" macro instead, to get both low halfwords right (the "lui" 
instruction will implicitly set the high word of t0 appropriately by
sign-extending the low word).

> to jump to the next instruction but in kseg0 instead of xkphys?  I believe the

 Obviously you have to make sure that the binary is linked such that 
"next" is within KSEG0.

> jump target should be word aligned in this case because it's the start of an

 It normally is unless you try to play tricks with the assembler.

> instruction.  I'm assuming if I generate a jr to a 32 bit address that the cpu
> will assume I'm jumping to a compatibility segment, am I wrong?

 Internally there is no such thing as a 32-bit address -- all addresses
are 64-bit in 64-bit processors (as that is the width of registers).  It's
simply that using 32-bit operations to calculate addresses limits the
range of results to these that have their top 33 bits set to the same
value.

 There is nothing special about the jump above and the CPU assumes nothing
specific about it.  The target address is just like any other one.  Once
the jump is executed, the following instruction will be fetched using
addressing rules defined for the segment it lies within (or an address
error exception happens if the address happens to be outside defined
segments). So after a jump to 0x00000000211c4018, the rules for XKUSEG
apply. 

 HTH,

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
