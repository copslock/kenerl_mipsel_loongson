Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2003 18:18:08 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:53132 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8224827AbTDGRSH>;
	Mon, 7 Apr 2003 18:18:07 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP id C9D503717
	for <linux-mips@linux-mips.org>; Mon,  7 Apr 2003 12:18:05 -0500 (CDT)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h37HI56D069131
	for <linux-mips@linux-mips.org>; Mon, 7 Apr 2003 12:18:05 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h37HI5sY069130
	for linux-mips@linux-mips.org; Mon, 7 Apr 2003 17:18:05 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from stpns.guidant.com (stpns.guidant.com [132.189.76.10]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Mon,  7 Apr 2003 17:18:05 +0000
Message-ID: <1049735885.3e91b2cd7366f@my.visi.com>
Date: Mon,  7 Apr 2003 17:18:05 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: 64 to 32 bit jr
References: <Pine.GSO.3.96.1030407174523.24634D-100000@delta.ds2.pg.gda.pl>
In-Reply-To: <Pine.GSO.3.96.1030407174523.24634D-100000@delta.ds2.pg.gda.pl>
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
X-archive-position: 1935
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips

Quoting "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>:

[deletions]
> > physical memory starting at address 0.  Head.S then jumps to the 32-bit
> part of
> > the xkphys address, which happens to be arranged so that it matches the
> correct
> > (next instruction) address in kseg0.
> 
>  Just see how these virtual addresses map to physical ones.

According to my current understanding, the base of each of 8 segments in xkphys
maps to the start of physical memory, so offset 0 in kseg0 should be the same
data as at offset 0 of the a800...0000 segment in xkphys.  So, if I load code
starting at offset 0 in xkphys, I should be able to jump to the 32-bit part of
the xkphys address and end up at the same offset in kseg0, provided the target
address is sign-extended properly.

The actual difficulty I'm having is that the address my code is loading at is
computed at link time by adding the xkphys base to the LOADADDRESS value using
mips64-linux-objcopy.  I haven't quite worked out the address math yet to  make
the code in xkphys and kseg0 have the same offsets.  Objcopy seems to have some
non-obvious rules for doing address calculations, IE objcopy using
--change-addresses=X

0xa800000000000000 + 0x20004000

gives something close to (not near my MIPS system atm)

0xa7ffffff2001c000

So, I'm thinking constructing the address in a register might be easier for now.

> 
>  HTH,
> 
>   Maciej


It does, thanks.

Erik
-- 
Erik J. Green
erik@greendragon.org
