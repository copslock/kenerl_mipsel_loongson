Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 22:01:35 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:9213 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225073AbTBYWBe>;
	Tue, 25 Feb 2003 22:01:34 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id OAA32363;
	Tue, 25 Feb 2003 14:01:28 -0800
Subject: Re: fixup_bigphys_addr and DBAu1500 dev board
From: Pete Popov <ppopov@mvista.com>
To: baitisj@evolution.com
Cc: linux-mips@linux-mips.org
In-Reply-To: <20030225135453.O20129@luca.pas.lab>
References: <200302201135.09154.krishnakumar@naturesoft.net>
	 <20030221.112456.41627052.nemoto@toshiba-tops.co.jp>
	 <20030221122515.E20129@luca.pas.lab> <3E568ECC.2090601@embeddededge.com>
	 <20030221195031.I20129@luca.pas.lab>
	 <1046108783.16540.512.camel@zeus.mvista.com>
	 <20030225135453.O20129@luca.pas.lab>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1046210743.9951.9.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Feb 2003 14:05:43 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-02-25 at 13:54, Jeff Baitis wrote:
> Yes, the DBAu1500 board does not have CardBus support. We want to support
> 802.11A/G, so at the moment I have a 3.3V PCI card with a Texas Instruments
> 1510 CardBus bridge. A lot of modern wireless cards are CardBus-only, so that's
> why we have decided to incorporate the TI bridge into our boards.

Ah, yes, that's true.  Just FYI, I had to debug a cardbus problem months
ago on a different architecture, so I did it on the Pb1500 instead. It
was a pci-cardbus adapter and I did get it to work,eventually, with a
cardbus wireless card. Unfortunately I didn't have time to clean it up
and submit it anywhere, internally or externally, and the bits died at
some point. 

So what you're trying to do is not hopeless but it will require some
debugging :)

Pete

> If someone out there has some notes or tips concerning getting PCMCIA working
> under this architecture, I would greatly appreciate the information.
> 
> Take care, and thanks again!
> 
> -Jeff
> 
> 
> On Mon, Feb 24, 2003 at 09:46:24AM -0800, Pete Popov wrote:
> > On Fri, 2003-02-21 at 19:50, Jeff Baitis wrote:
> > > Dan & Pete:
> > > 
> > > Thank you very much for your help!
> > > 
> > > I've patched things up, and my kernel runs, but the yenta_socket kernel module
> > > still locks the system. Time to break out GDB and take a look at everything!
> > > Please let me know if ya'll have some suggestions. :*)
> > 
> > yenta socket? There's no hardware on the board to support this.
> > 
> > pcmcia is always a pain in the neck to setup, but it does work on the Db
> > and Pb boards cause I very recently tested it. Note that I've tested it
> > only as a module though. The defconfig-db1500 in linux-mips.org already
> > has pcmcia support turned on. The socket driver module you'll end up
> > with is drivers/pcmcia/au1x00_ss.o. That's the module you want to load.
> > Note also that there is a small patch in my directory for pcmcia.
> > 
> > I've tested wireless cards in the past, but not recently. Recently I've
> > tested ata cards only. You might want to start with that as proof that
> > you have everything else working.
> > 
> > > After the 36-bit PCI patch, I had to alter include/asm-mips/io.h in order to
> > > get drivers/net/wireless to compile. Preprocessor expansion of outw_p in the
> > > hermes.h -> hermes_enable_interrupt and hermes_set_irqmask inline functions
> > > caused some issues; I hope this patch is of some use!
> > 
> > Only if Ralf applies it :)
> > 
> > Pete
