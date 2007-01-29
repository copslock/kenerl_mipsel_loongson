Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 18:06:39 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:9679 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20038660AbXA2SGe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2007 18:06:34 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 6808DB924B;
	Mon, 29 Jan 2007 19:05:56 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HBauX-0004OG-2U; Mon, 29 Jan 2007 18:07:21 +0000
Date:	Mon, 29 Jan 2007 18:07:21 +0000
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	macro@linux-mips.org, vagabon.xyz@gmail.com, dan@debian.org,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
Message-ID: <20070129180720.GC13923@networkno.de>
References: <20070128180807.GA18890@nevyn.them.org> <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com> <Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl> <20070130.011442.21365159.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070130.011442.21365159.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 29 Jan 2007 15:46:20 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> >  Well, the option used to select between 64-bit and 32-bit ELF for 
> > building 64-bit configurations.  I can see it has been changed from its 
> > original meaning and it now only controls whether "-mno-explicit-relocs" 
> > is passed to the compiler or not, which is sort of useless and certainly 
> > does not match the intent nor what the description says.  The 64-bit 
> > format is now used unconditionally and you can always pass such obscure 
> > options to the compiler on the make's command line, so instead of this fix 
> > I vote for complete removal of the BUILD_ELF64 option.
> 
> Though I do not know much about -mno-explicit-relocs,
> CONFIG_BUILD_ELF64 controls -msym32 option and this is the reason of
> the tweak in __pa_page_offset().
> 
> I thought -msym32 can not be used for 64-bit kernels which do not have
> CKSEG load address, but apparently IP27 is using -msym32 with XKPHYS
> load address.  Hmm...

IP27 kernels get objcopied to a CKSEG0 address.


Thiemo
