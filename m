Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B0BfRw025243
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 17:11:41 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B0Bfof025242
	for linux-mips-outgoing; Wed, 10 Jul 2002 17:11:41 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft16-f88.dialo.tiscali.de [62.246.16.88])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B0BXRw025232
	for <linux-mips@oss.sgi.com>; Wed, 10 Jul 2002 17:11:35 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6B0Fs407501;
	Thu, 11 Jul 2002 02:15:54 +0200
Date: Thu, 11 Jul 2002 02:15:54 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jon Burgess <Jon_Burgess@eur.3com.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: mips32_flush_cache routine corrupts CP0_STATUS with gcc-2.96
Message-ID: <20020711021554.A3207@dea.linux-mips.net>
References: <80256BF2.004ECBE6.00@notesmta.eur.3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <80256BF2.004ECBE6.00@notesmta.eur.3com.com>; from Jon_Burgess@eur.3com.com on Wed, Jul 10, 2002 at 03:16:21PM +0100
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jul 10, 2002 at 03:16:21PM +0100, Jon Burgess wrote:

> This may be caused by the cache routines running from the a cached kseg0, it
> looks like it can be fixed by making sure that the are always called via
> KSEG1ADDR(fn) which looks like it could be done with a bit of fiddling of the
> setup_cache_funcs code. I have included a patch below which starts this, but I
> haven't caught all combinations of how the routines are called.

While that could be done it's not a good idea; running code in KSEG1 is
very slow.

> Alternatively it could be a CP0 pipeline interaction of the cache instruction
> and mfc0 but I can't find anything detailed about it. I thought this was the
> problem initially and have included a patch below which adds an extra nop.

Running uncached is so slow that the pipeline will slip and stall basically
every cycle which should get you around the hazard.  Anyway, there's no
hazard for mfc0 documented in the MIPS32 spec so this smells like a silicon
bug.

Which particular CPU and revision are you using?

  Ralf
