Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2003 21:55:02 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:52128 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225073AbTBYVzB>;
	Tue, 25 Feb 2003 21:55:01 +0000
Received: (qmail 23932 invoked by uid 6180); 25 Feb 2003 21:54:53 -0000
Date: Tue, 25 Feb 2003 13:54:53 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: Pete Popov <ppopov@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: fixup_bigphys_addr and DBAu1500 dev board
Message-ID: <20030225135453.O20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <200302201135.09154.krishnakumar@naturesoft.net> <20030221.112456.41627052.nemoto@toshiba-tops.co.jp> <20030221122515.E20129@luca.pas.lab> <3E568ECC.2090601@embeddededge.com> <20030221195031.I20129@luca.pas.lab> <1046108783.16540.512.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1046108783.16540.512.camel@zeus.mvista.com>; from ppopov@mvista.com on Mon, Feb 24, 2003 at 09:46:24AM -0800
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1559
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Yes, the DBAu1500 board does not have CardBus support. We want to support
802.11A/G, so at the moment I have a 3.3V PCI card with a Texas Instruments
1510 CardBus bridge. A lot of modern wireless cards are CardBus-only, so that's
why we have decided to incorporate the TI bridge into our boards.

If someone out there has some notes or tips concerning getting PCMCIA working
under this architecture, I would greatly appreciate the information.

Take care, and thanks again!

-Jeff


On Mon, Feb 24, 2003 at 09:46:24AM -0800, Pete Popov wrote:
> On Fri, 2003-02-21 at 19:50, Jeff Baitis wrote:
> > Dan & Pete:
> > 
> > Thank you very much for your help!
> > 
> > I've patched things up, and my kernel runs, but the yenta_socket kernel module
> > still locks the system. Time to break out GDB and take a look at everything!
> > Please let me know if ya'll have some suggestions. :*)
> 
> yenta socket? There's no hardware on the board to support this.
> 
> pcmcia is always a pain in the neck to setup, but it does work on the Db
> and Pb boards cause I very recently tested it. Note that I've tested it
> only as a module though. The defconfig-db1500 in linux-mips.org already
> has pcmcia support turned on. The socket driver module you'll end up
> with is drivers/pcmcia/au1x00_ss.o. That's the module you want to load.
> Note also that there is a small patch in my directory for pcmcia.
> 
> I've tested wireless cards in the past, but not recently. Recently I've
> tested ata cards only. You might want to start with that as proof that
> you have everything else working.
> 
> > After the 36-bit PCI patch, I had to alter include/asm-mips/io.h in order to
> > get drivers/net/wireless to compile. Preprocessor expansion of outw_p in the
> > hermes.h -> hermes_enable_interrupt and hermes_set_irqmask inline functions
> > caused some issues; I hope this patch is of some use!
> 
> Only if Ralf applies it :)
> 
> Pete

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
