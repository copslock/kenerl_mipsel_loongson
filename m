Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 18:16:43 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:12255 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20038656AbXA2SQh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2007 18:16:37 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id B16BCB956F;
	Mon, 29 Jan 2007 19:08:28 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HBawz-0004OY-Im; Mon, 29 Jan 2007 18:09:53 +0000
Date:	Mon, 29 Jan 2007 18:09:53 +0000
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: RFC: Sentosa boot fix
Message-ID: <20070129180953.GD13923@networkno.de>
References: <20070128180807.GA18890@nevyn.them.org> <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com> <Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Mon, 29 Jan 2007, Franck Bui-Huu wrote:
> 
> > > The problem is __pa_symbol(&_end); the kernel is linked at
> > > 0xffffffff80xxxxxx, so subtracting a PAGE_OFFSET of 0xa800000000000000
> > > does not do anything useful to this address at all.
> > >
> > 
> > In my understanding, if your kernel is linked at 0xffffffff80xxxxxx,
> > you shouldn't have CONFIG_BUILD_ELF64 set.
> 
>  Well, the option used to select between 64-bit and 32-bit ELF for 
> building 64-bit configurations.  I can see it has been changed from its 
> original meaning and it now only controls whether "-mno-explicit-relocs" 
> is passed to the compiler or not, which is sort of useless and certainly 
> does not match the intent nor what the description says.  The 64-bit 
> format is now used unconditionally and you can always pass such obscure 
> options to the compiler on the make's command line, so instead of this fix 
> I vote for complete removal of the BUILD_ELF64 option.

AFAIR at some point in gcc development the compiler expanded explicit
relocs to 32bit sequences unless -mno-xplicit-relocs was specified.


Thiemo
