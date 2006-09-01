Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2006 22:36:00 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:28330 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038570AbWIAVf6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2006 22:35:58 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 3EC6047443; Fri,  1 Sep 2006 23:34:24 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GJGch-0007XH-FI; Fri, 01 Sep 2006 22:32:23 +0100
Date:	Fri, 1 Sep 2006 22:32:23 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Broadcom SB1 query
Message-ID: <20060901213223.GA24995@networkno.de>
References: <20060901173730.GC4893@networkno.de> <20060901204131.42144.qmail@web31512.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901204131.42144.qmail@web31512.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Jonathan Day wrote:
> --- Thiemo Seufer <ths@networkno.de> wrote:
> 
> > Jonathan Day wrote:
> > > Hi,
> > > 
> > > Can anyone verify that the current kernel in
> > > linux-mips git archive will work on a Broadcom
> > 1250
> > > (SB1), specifically the "Swarm" or the "Sentosa"
> > > flavours of the BCM91250.
> > 
> > A 2.6.18-rc4 from a one week old git checkout works
> > fine on a SWARM
> > here, booted via tftp. The same kernel fails to boot
> > on another
> > SWARM board from the onboard IDE, I guess the
> > swarm-ide is currently
> > broken.
> 
> That might explain it. I've included the output from
> the console at the end of this message, so you can
> take a squint at it and see if that confirms it.

Hm, no. It hangs way too early for that. Looks like it dies on the
first interrupts.

[snip]
> > Current Debian unstable works for me.
> > 
> 
> Well, my machine's already unstable, so I guess Debian
> can't hurt! :) I didn't know they had a big-endian
> 64-bit build, though. I'll have to look that up.

Only the kernel is 64 bit, userland is still 32 bit. This should at
least help to verify the hardware.


Thiemo
