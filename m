Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 10:00:56 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:48002 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8226129AbVGAJAj>;
	Fri, 1 Jul 2005 10:00:39 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j6190Qpr024687;
	Fri, 1 Jul 2005 11:00:26 +0200 (MEST)
Date:	Fri, 1 Jul 2005 11:00:20 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
cc:	David Daney <ddaney@avtrex.com>,
	Michael Stickel <michael@cubic.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: Problems with Intel e100 driver on new MIPS port, was: Advice
 needed WRT very slow nfs in new port...
In-Reply-To: <Pine.LNX.4.61L.0507010953420.30138@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.62.0507011059420.5245@numbat.sonytel.be>
References: <01049E563C8ECC43AD6B53A5AF419B38098BD1@avtrex-server2.hq2.avtrex.com>
 <Pine.LNX.4.61L.0507010953420.30138@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 1 Jul 2005, Maciej W. Rozycki wrote:
> On Thu, 30 Jun 2005, David Daney wrote:
> > It seems that it is a memory consistancy problem of some sort.  By 
> > placing wbflush() after all writes to NIC registers it works.  This 
> > leads me to think that either the driver is buggy WRT processors that 
> > have write-back queues or my implementation (the default implementation) 
> > of writeb() and friends is buggy on this processor.  Now it could be 
> > that all that is needed is wmb() before some of the register writes, but 
> > since on my processor they both do the same thing (sync) it is hard to 
> > tell.
> 
>  Most likely that code has only been ever used on i386 systems (who'd want 
> to use such a weird Ethernet chip elsewhere?), so don't expect it to be 
> terribly sane.

The e100 is a quite popular card, so I'd expect it to be in use on many
platforms.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
