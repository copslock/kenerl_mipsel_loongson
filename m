Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Mar 2004 12:38:13 +0000 (GMT)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:12754
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225385AbUCXMiM>; Wed, 24 Mar 2004 12:38:12 +0000
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id D0B4212A; Wed, 24 Mar 2004 13:38:04 +0100 (NFT)
Received: from mx5.informatik.uni-tuebingen.de ([127.0.0.1])
 by localhost (mx5 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 38972-04; Wed, 24 Mar 2004 13:38:03 +0100 (NFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id A5FF6121; Wed, 24 Mar 2004 13:38:02 +0100 (NFT)
Received: from mrvn by dual with local (Exim 3.36 #1 (Debian))
	id 1B67eN-0004WS-00; Wed, 24 Mar 2004 13:38:27 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
	<1078478086.4308.14.camel@dzur.sfbay.redhat.com>
	<16456.21112.570245.1011@arsenal.mips.com>
	<Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
	<20040318213713.GC25815@linux-mips.org>
	<Pine.GSO.4.58.0403191141290.2173@waterleaf.sonytel.be>
	<20040319125502.GA32363@linux-mips.org>
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 24 Mar 2004 13:38:27 +0100
In-Reply-To: <20040319125502.GA32363@linux-mips.org>
Message-ID: <87isguwhbw.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> writes:

> On Fri, Mar 19, 2004 at 11:42:11AM +0100, Geert Uytterhoeven wrote:
> 
> > > Take a look at the 68020 to see where instruction set madness can lead:
> > >
> > > 	movel	([42, a0, d0.2*2],123), ([43, a0, d0.2*2], 22)
> > > 	bfextu	([42, a0, d0.2*2],123){8:8}, d2
> > 
> > These instructions didn't complete in 1 cycle, while the new RISCies do.
> 
> That's the point, they went overboard with their C^2ISC philosophy.  These
> instructions were more or less unusable by compilers of the time and the
> given the rarity were not the most performant instructions of the
> architecture either, so made sense only relativly rarely.  So in the end
> the didn't get it right in the beginning which lead to the removal of the
> instruction in 060, if I recall right.
> 
>   Ralf

Thats a

 move.l 31530(A0, D0*2), 5675(A0, D0*2)  (that would give a bus error)

before assembly right?

That instruction is great to access array or aligned structure members
with an offset and compilers should be able to generate it for it. But
its only realy usefull if your short on registers, which gcc does not
optimize for.

Don't think they got removed. Could it be you are thinking about
mulu.l d0,d0:d1   (32*32=64 bit mul) and the like?

MfG
        Goswin
