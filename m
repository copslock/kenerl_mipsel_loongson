Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2003 16:02:04 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:32649 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8224827AbTDGPCC>;
	Mon, 7 Apr 2003 16:02:02 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP id 544CA3717
	for <linux-mips@linux-mips.org>; Mon,  7 Apr 2003 10:02:00 -0500 (CDT)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h37F206D067783
	for <linux-mips@linux-mips.org>; Mon, 7 Apr 2003 10:02:00 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h37F1xS9067782
	for linux-mips@linux-mips.org; Mon, 7 Apr 2003 15:01:59 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from stpns.guidant.com (stpns.guidant.com [132.189.76.10]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Mon,  7 Apr 2003 15:01:59 +0000
Message-ID: <1049727719.3e9192e77cc49@my.visi.com>
Date: Mon,  7 Apr 2003 15:01:59 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: 64 to 32 bit jr
References: <Pine.GSO.3.96.1030404161724.7307D-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <Pine.GSO.3.96.1030404161724.7307D-100000@delta.ds2.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 132.189.76.10
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips

Quoting "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>:
[deletions]
> > > > *** PROM write error on cacheline 0x1fcd3b00 at PC=0x211c4018
> RA=0xffffffff9fc5ace4
> > [..snip..]
> > >
> > >  0x211c4018 is a mapped address, which you can't use that early in a
> boot.
> > Isn't 0xa8000000211c4000 in xkphys and therefore unmapped? The PROM only
> > seems to look at the lower 32bits of PC though.
> 
>  0xa8000000211c4000 is indeed in XKPHYS but the code jumps to 0x211c4018.

Okay, I want to make sure I understand the addressing correctly for the 64 to 32
bit jump.  The existing code for the IP27 (seems to load at about
a800000000000000, which is one of the segments in xkphys, corresponding to
physical memory starting at address 0.  Head.S then jumps to the 32-bit part of
the xkphys address, which happens to be arranged so that it matches the correct
(next instruction) address in kseg0.

I am unable to arrange my addresses similarly neatly, mostly I think due to
fighting with the toolchain I have.  Is it "legal" for me to load a kernel using
the xkphys address and then do something like:

lui    t0,0x8000
addiu  t0,t0,@next
jr     t0
nop
next:


to jump to the next instruction but in kseg0 instead of xkphys?  I believe the
jump target should be word aligned in this case because it's the start of an
instruction.  I'm assuming if I generate a jr to a 32 bit address that the cpu
will assume I'm jumping to a compatibility segment, am I wrong?

Erik




-- 
Erik J. Green
erik@greendragon.org
