Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2004 10:42:16 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:9899 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225474AbUCSKmP>;
	Fri, 19 Mar 2004 10:42:15 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i2JAgBdU027720;
	Fri, 19 Mar 2004 11:42:11 +0100 (MET)
Date: Fri, 19 Mar 2004 11:42:11 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
Subject: Re: gcc support of mips32 release 2
In-Reply-To: <20040318213713.GC25815@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0403191141290.2173@waterleaf.sonytel.be>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
 <1078478086.4308.14.camel@dzur.sfbay.redhat.com> <16456.21112.570245.1011@arsenal.mips.com>
 <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
 <20040318213713.GC25815@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Thu, 18 Mar 2004, Ralf Baechle wrote:
> On Thu, Mar 18, 2004 at 02:18:01PM +0100, Maciej W. Rozycki wrote:
> >  As a side note, it makes me wonder where the borderline of the RISC
> > actually is.  Even Intel abandoned support for bit insert/extract
> > instructions after an initial attempt for the i386.  They figured out the
> > implementation was too complicated. ;-)
>
> Take a look at the 68020 to see where instruction set madness can lead:
>
> 	movel	([42, a0, d0.2*2],123), ([43, a0, d0.2*2], 22)
> 	bfextu	([42, a0, d0.2*2],123){8:8}, d2

These instructions didn't complete in 1 cycle, while the new RISCies do.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
