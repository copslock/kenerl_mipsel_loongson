Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2004 12:55:13 +0000 (GMT)
Received: from p508B78CC.dip.t-dialin.net ([IPv6:::ffff:80.139.120.204]:38676
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225377AbUCSMzM>; Fri, 19 Mar 2004 12:55:12 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i2JCt5Mk026277;
	Fri, 19 Mar 2004 13:55:05 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i2JCt2DC026275;
	Fri, 19 Mar 2004 13:55:02 +0100
Date: Fri, 19 Mar 2004 13:55:02 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
Message-ID: <20040319125502.GA32363@linux-mips.org>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com> <1078478086.4308.14.camel@dzur.sfbay.redhat.com> <16456.21112.570245.1011@arsenal.mips.com> <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl> <20040318213713.GC25815@linux-mips.org> <Pine.GSO.4.58.0403191141290.2173@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403191141290.2173@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 19, 2004 at 11:42:11AM +0100, Geert Uytterhoeven wrote:

> > Take a look at the 68020 to see where instruction set madness can lead:
> >
> > 	movel	([42, a0, d0.2*2],123), ([43, a0, d0.2*2], 22)
> > 	bfextu	([42, a0, d0.2*2],123){8:8}, d2
> 
> These instructions didn't complete in 1 cycle, while the new RISCies do.

That's the point, they went overboard with their C^2ISC philosophy.  These
instructions were more or less unusable by compilers of the time and the
given the rarity were not the most performant instructions of the
architecture either, so made sense only relativly rarely.  So in the end
the didn't get it right in the beginning which lead to the removal of the
instruction in 060, if I recall right.

  Ralf
