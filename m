Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 19:37:32 +0100 (BST)
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:61824
	"EHLO vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20021669AbXHFShP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Aug 2007 19:37:15 +0100
Received: from t000e.t.pppool.de ([89.55.0.14] helo=pbook.local)
	by vs166246.vserver.de with esmtpa (Exim 4.50)
	id 1II7S9-0000ow-I1; Mon, 06 Aug 2007 20:37:17 +0200
From:	Michael Buesch <mb@bu3sch.de>
To:	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH -mm 2/4] MIPS: BCM947xx support
Date:	Mon, 6 Aug 2007 20:37:05 +0200
User-Agent: KMail/1.9.6
Cc:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
References: <20070806150900.GG24308@hall.aurel32.net> <200708062005.29657.mb@bu3sch.de> <20070806183316.GB32465@hall.aurel32.net>
In-Reply-To: <20070806183316.GB32465@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708062037.05995.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Monday 06 August 2007, Aurelien Jarno wrote:
> On Mon, Aug 06, 2007 at 08:05:29PM +0200, Michael Buesch wrote:
> > On Monday 06 August 2007, Aurelien Jarno wrote:
> > > The patch below against 2.6.23-rc1-mm2 adds support for BCM947xx CPUs.
> > > It originally comes from the OpenWrt patches.
> > > 
> > > Cc: Michael Buesch <mb@bu3sch.de>
> > > Cc: Waldemar Brodkorb <wbx@openwrt.org>
> > > Cc: Felix Fietkau <nbd@openwrt.org>
> > > Cc: Florian Schirmer <jolt@tuxbox.org>
> > > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> 
> [snip]
> 
> > > --- a/arch/mips/bcm947xx/setup.c	
> > > +++ b/arch/mips/bcm947xx/setup.c
> > > @@ -0,0 +1,106 @@
> 
> [snip]
> 
> > > +static void bcm947xx_machine_halt(void)
> > > +{
> > > +	/* Disable interrupts and watchdog and spin forever */
> > > +	local_irq_disable();
> > > +	ssb_chipco_watchdog_timer_set(&ssb.chipco, 0);
> > > +	while (1)
> > > +		cpu_relax();
> > > +}
> > > +
> > > +static int bcm947xx_get_invariants(struct ssb_bus *bus, struct ssb_init_invariants *iv)
> > > +{
> > 
> > No reading of NVRAM, yet?
> 
> This requires CFE support, and this part is still a bit problematic now.
> There are already CFE files for SiByte support, and I think it's not a
> good idea to have too different implementations.

Yep, I forgot about that. My CFE stuff should probably partly get
merged into the existing CFE stuff, if neeeded.
So let's leave this out for now.

> I will add a comment here;
> 
> > > +	return 0;
> > > +}
> > > +
> > > +void __init plat_mem_setup(void)
> > > +{
> > > +	int i, err;
> > > +	struct ssb_mipscore *mcore;
> > > +
> > > +	err = ssb_bus_ssbbus_register(&ssb, SSB_ENUM_BASE, bcm947xx_get_invariants);
> > > +	if (err) {
> > > +		const char *msg = "Failed to initialize SSB bus (err %d)\n";
> > > +		panic(msg, err);
> > 
> > We don't need the msg variable anymore.
> 
> I will fix that.
> 
> 
