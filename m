Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 May 2009 18:01:25 +0100 (BST)
Received: from waste.org ([66.93.16.53]:33292 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023855AbZEaRBT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 31 May 2009 18:01:19 +0100
Received: from [192.168.1.100] ([10.0.0.101])
	(authenticated bits=0)
	by waste.org (8.13.8/8.13.8/Debian-3) with ESMTP id n4VH0Flr022422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 31 May 2009 12:00:16 -0500
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver
From:	Matt Mackall <mpm@selenic.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	akpm@linux-foundation.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, linux-kernel@vger.kernel.org,
	herbert@gondor.apana.org.au
In-Reply-To: <20090601.014517.169682203.anemo@mba.ocn.ne.jp>
References: <1243350141-883-1-git-send-email-anemo@mba.ocn.ne.jp>
	 <20090529162907.9cb1bba2.akpm@linux-foundation.org>
	 <20090601.014517.169682203.anemo@mba.ocn.ne.jp>
Content-Type: text/plain
Date:	Sun, 31 May 2009 12:00:09 -0500
Message-Id: <1243789210.22069.23.camel@calx>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new
Return-Path: <mpm@selenic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpm@selenic.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-06-01 at 01:45 +0900, Atsushi Nemoto wrote:
> On Fri, 29 May 2009 16:29:07 -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> > I assume that the MIPS patch "[PATCH] TXx9: Add TX4939 RNG support"
> > depends upon this patch?
> 
> To build kernel or driver, no dependencies.  To use this device
> actually, both patches are needed.
> 
> > > +static u64 read_rng(void __iomem *base, unsigned int offset)
> > > +{
> > > +	/* Caller must disable interrupts */
> > > +	return ____raw_readq(base + offset);
> > > +}
> > 
> > What is the reasoning behind the local_irq_disable() requirement?
> > 
> > Because I'm wondering whether this is safe on SMP?
> 
> As Ralf replied, These local_irq_disable stuff are just for 64-bit
> access on 32-bit kernel.  Maybe something like this is preferred?
> 
> static void ____raw_io_start(void)
> {
> #ifndef CONFIG_64BIT
> 	/* some comments... */
> 	local_irq_enable();
> #endif
> }
> 
> static void ____raw_io_end(void)
> {
> #ifndef CONFIG_64BIT
> 	/* see above */
> 	local_irq_disable();
> #endif
> }
> 
> For SMP concurrent access, these rountines are protected by mutex in
> rng-core.  Also this SoC does not support SMP.  There should be no
> problem here.
> 
> > > +	for (i = 0; i < 20; i++) {
> ...
> > > +		udelay(1);
> > > +	}
> > > +	return rngdev->data_avail;
> > > +}
> > 
> > The mysterious udelay() needs a comment, because there is no way in
> > which the reader can otherwise work out why it is there.
> 
> Well, this comments can be applied most RNG drivers ;)
> 
> Anyway, I will add some comment here.  I take this loop (20 loops with
> udelay) from other drivers and changed to udelay(1) because the
> datasheed states "90 bus clock cycles by default" for generation
> (typically 450ns for this SoC).
> 
> > > +static int tx4939_rng_data_read(struct hwrng *rng, u32 *buffer)
> > > +{
> > > +	struct tx4939_rng *rngdev = container_of(rng, struct tx4939_rng, rng);
> > > +
> > > +	rngdev->data_avail--;
> > > +	*buffer = *((u32 *)&rngdev->databuf + rngdev->data_avail);
> > > +	return sizeof(u32);
> > > +}
> > 
> > Concurrent callers can corrupt rngdev->data_avail ?
> 
> This is protected by rng_mutex in rng-core.
> 
> > > +	/* Start RNG */
> > > +	write_rng(TX4939_RNG_RCSR_ST, rngdev->base, TX4939_RNG_RCSR);
> > > +	local_irq_enable();
> > > +	/* drop first two results */
> > 
> > The comment doesn't provide the reason for doing this?
> 
> >From the datasheet:
> 
> 	The quality of the random numbers generated immediately after
> 	reset can be insufficient.  Therefore, do not use random
> 	numbers obtained from the first and second generations; use
> 	the ones from the third or subsequent generation.

Does the datasheet say anything about -how- the random numbers are
produced? Most physical sources that I'm aware of don't have this sort
of issue. But some pseudo-RNGs do. So this looks a little worrisome.

-- 
http://selenic.com : development and support for Mercurial and Linux
