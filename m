Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 15:57:41 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:38101 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225202AbTDDO5j>;
	Fri, 4 Apr 2003 15:57:39 +0100
Received: from mehen.visi.com (mehen.visi.com [209.98.98.97])
	by mail-out.visi.com (Postfix) with ESMTP id 31D5536D1
	for <linux-mips@linux-mips.org>; Fri,  4 Apr 2003 08:57:31 -0600 (CST)
Received: from mehen.visi.com (localhost [127.0.0.1])
	by mehen.visi.com (8.12.9/8.12.5) with ESMTP id h34EvV6D048061
	for <linux-mips@linux-mips.org>; Fri, 4 Apr 2003 08:57:31 -0600 (CST)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mehen.visi.com (8.12.9/8.12.5/Submit) id h34EvVpi048060
	for linux-mips@linux-mips.org; Fri, 4 Apr 2003 14:57:31 GMT
X-Authentication-Warning: mehen.visi.com: www set sender to erik@greendragon.org using -f
Received: from stpns.guidant.com (stpns.guidant.com [132.189.76.10]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Fri,  4 Apr 2003 14:57:30 +0000
Message-ID: <1049468250.3e8d9d5aecb0a@my.visi.com>
Date: Fri,  4 Apr 2003 14:57:30 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: Unknown ARCS message/hang
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
X-archive-position: 1927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips

Quoting "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>:

> On Fri, 4 Apr 2003, Guido Guenther wrote:
> 
> > > > Obtaining /vmlinux.64 from server
> > > > 1813568+1150976+172144 entry: 0xa8000000211c4000
> > > >
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

Ah, okay.  I didn't understand the jr instruction there.  That's generated as 
part of a macro:

	.macro	ARC64_TWIDDLE_PC
#if defined(CONFIG_ARC64) || defined(CONFIG_MAPPED_KERNEL)
	/* We get launched at a XKPHYS address but the kernel is linked to
	   run at a KSEG0 address, so jump there.  */
	PTR_LA	t0, \@f
	jr	t0
\@:

I was under the assumption that Octane is ARC64, I may be wrong.

Clearly then, the kernel is linked at the wrong address to have this work.  The
question I have is, why is kseg0 used in this case?  Is it due to the 32 to 64
bit conversion that happens later on in the build?  It looks like the IP27 load
address was originally  0xa80000000001c000, but was amended to 0x8001c000 for
the current CVS(2.4) kernel.  Again, due to the conversion?

Erik


-- 
Erik J. Green
erik@greendragon.org
