Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 19:36:35 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:23684 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20021656AbXHFSgc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 19:36:32 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1II7OH-0008Tk-0v; Mon, 06 Aug 2007 20:33:17 +0200
Date:	Mon, 6 Aug 2007 20:33:16 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Michael Buesch <mb@bu3sch.de>
Cc:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: Re: [PATCH -mm 2/4] MIPS: BCM947xx support
Message-ID: <20070806183316.GB32465@hall.aurel32.net>
References: <20070806150900.GG24308@hall.aurel32.net> <200708062005.29657.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200708062005.29657.mb@bu3sch.de>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

On Mon, Aug 06, 2007 at 08:05:29PM +0200, Michael Buesch wrote:
> On Monday 06 August 2007, Aurelien Jarno wrote:
> > The patch below against 2.6.23-rc1-mm2 adds support for BCM947xx CPUs.
> > It originally comes from the OpenWrt patches.
> > 
> > Cc: Michael Buesch <mb@bu3sch.de>
> > Cc: Waldemar Brodkorb <wbx@openwrt.org>
> > Cc: Felix Fietkau <nbd@openwrt.org>
> > Cc: Florian Schirmer <jolt@tuxbox.org>
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

[snip]

> > --- a/arch/mips/bcm947xx/setup.c	
> > +++ b/arch/mips/bcm947xx/setup.c
> > @@ -0,0 +1,106 @@

[snip]

> > +static void bcm947xx_machine_halt(void)
> > +{
> > +	/* Disable interrupts and watchdog and spin forever */
> > +	local_irq_disable();
> > +	ssb_chipco_watchdog_timer_set(&ssb.chipco, 0);
> > +	while (1)
> > +		cpu_relax();
> > +}
> > +
> > +static int bcm947xx_get_invariants(struct ssb_bus *bus, struct ssb_init_invariants *iv)
> > +{
> 
> No reading of NVRAM, yet?

This requires CFE support, and this part is still a bit problematic now.
There are already CFE files for SiByte support, and I think it's not a
good idea to have too different implementations.

I will add a comment here;

> > +	return 0;
> > +}
> > +
> > +void __init plat_mem_setup(void)
> > +{
> > +	int i, err;
> > +	struct ssb_mipscore *mcore;
> > +
> > +	err = ssb_bus_ssbbus_register(&ssb, SSB_ENUM_BASE, bcm947xx_get_invariants);
> > +	if (err) {
> > +		const char *msg = "Failed to initialize SSB bus (err %d)\n";
> > +		panic(msg, err);
> 
> We don't need the msg variable anymore.

I will fix that.


-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
