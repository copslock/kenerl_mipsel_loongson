Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jun 2009 01:29:09 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55995 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492777AbZFZX3B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Jun 2009 01:29:01 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5QNOXFh028590;
	Sat, 27 Jun 2009 00:24:33 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5QNOWps028584;
	Sat, 27 Jun 2009 00:24:32 +0100
Date:	Sat, 27 Jun 2009 00:24:32 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <KKylheku@zeugmasystems.com>
Cc:	Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org
Subject: Re: Broadcom Swarm support
Message-ID: <20090626232432.GB3235@linux-mips.org>
References: <20090624063453.GA16846@volta.aurel32.net> <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C501C3539B@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 24, 2009 at 03:18:24PM -0700, Kaz Kylheku wrote:
> From: Kaz Kylheku <KKylheku@zeugmasystems.com>
> Date: Wed, 24 Jun 2009 15:18:24 -0700
> To: Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org
> Subject: RE: Broadcom Swarm support
> Content-Type: text/plain;
> 	charset="us-ascii"
> 
> Aurelien Jarno wrote:
> > Hi all,
> > 
> > I am still trying to get a Broadcom Swarm boot on a recent kernel. I
> > have made some progress, but I am now stuck on another problem.
> > 
> > I am using a lmo 2.6.30 kernel, using the defconfig 
> 
> [ snip ]
> 
> > | Kernel panic - not syncing: Attempted to kill init!
> > | Rebooting in 5 seconds..Passing control back to CFE...
> 
> What kernel were you running prior to trying 30?
> 
> When I migrated from 2.6.17 to 2.6.26, on a Broadcom
> 1480 based board, I discovered that there is some kind
> of instruction cache problem, which causes userland to
> fetch garbage instead of code from its mmap-ped executables.
> I could not get init to execute successfully.
> 
> Sorry, I can no longer remember whether this problem was
> SMP specific or not (like what you're experiencing);
> it might have been.
> 
> At some point in the kernel history, Ralfie decided that
> the flush_icache_page function is unnecessary and
> turned it into a MIPS-wide noop. But the SB1 core, which has
> a VIVT instruction cache, it appears that there
> is some kind of issue whereby when it
> is handling a fault for a not-present virtual page,
> it somehow ends up with bad data in the instruction
> cache---perhaps an inconsistent state due to not having
> been able to complete the fetch, but having initiated
> a cache update on the expectation that the fetch
> will complete. It seems that the the fault handler
> is expected to do a flush.
> 
> Anyway, see if you can work this patch (based on 2.6.26)
> into your kernel, and report whether it makes any difference.

The functionality of flush_icache_page() is being handled update_mmu_cache.

The SB1 isn't the only MIPS CPU featuring VIVT caches - there are also
the MIPS 20K and 25K CPUs and the virtually identical SB1A core.  I've
tested Linux on 20K and 25K just days ago and I get months of uptime on my
BCM1480 box.

What type of boot devices are you using, is it the onboard IDE controller
by any chance?

  Ralf
