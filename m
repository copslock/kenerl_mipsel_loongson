Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 21:57:29 +0100 (BST)
Received: from mx1.redhat.com ([66.187.233.31]:3477 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20045097AbWHKU52 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2006 21:57:28 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7BKvIEB007866;
	Fri, 11 Aug 2006 16:57:18 -0400
Received: from nwo.kernelslacker.org (vpn-248-3.boston.redhat.com [10.13.248.3])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k7BKv3O6018056;
	Fri, 11 Aug 2006 16:57:06 -0400
Received: from nwo.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by nwo.kernelslacker.org (8.13.7/8.13.5) with ESMTP id k7BKumW6017850;
	Fri, 11 Aug 2006 16:56:54 -0400
Received: (from davej@localhost)
	by nwo.kernelslacker.org (8.13.7/8.13.7/Submit) id k7BKudpF017805;
	Fri, 11 Aug 2006 16:56:39 -0400
X-Authentication-Warning: nwo.kernelslacker.org: davej set sender to davej@redhat.com using -f
Date:	Fri, 11 Aug 2006 16:56:39 -0400
From:	Dave Jones <davej@redhat.com>
To:	thomas@koeller.dyndns.org
Cc:	wim@iguana.be, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060811205639.GK26930@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, thomas@koeller.dyndns.org,
	wim@iguana.be, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <200608102319.13679.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608102319.13679.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <davej@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davej@redhat.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 10, 2006 at 11:19:13PM +0200, thomas@koeller.dyndns.org wrote:
 > This is a driver for the on-chip watchdog device found on some
 > MIPS RM9000 processors.
 > 
 > Signed-off-by: Thomas Koeller <thomas.koeller@baslerweb.com>

Mostly same nit-picking comments as your other driver..

 > +++ b/drivers/char/watchdog/rm9k_wdt.c
 > ... 
 > + 
 > +#include <linux/config.h>

not needed.

 > +/* Function prototypes */
 > +static int __init wdt_gpi_probe(struct device *);
 > +static int __exit wdt_gpi_remove(struct device *);
 > +static void wdt_gpi_set_timeout(unsigned int);
 > +static int wdt_gpi_open(struct inode *, struct file *);
 > +static int wdt_gpi_release(struct inode *, struct file *);
 > +static ssize_t wdt_gpi_write(struct file *, const char __user *, size_t, 
 > loff_t *);
 > +static long wdt_gpi_ioctl(struct file *, unsigned int, unsigned long);
 > +static const struct resource *wdt_gpi_get_resource(struct platform_device *, 
 > const char *, unsigned int);
 > +static int wdt_gpi_notify(struct notifier_block *, unsigned long, void *);
 > +static irqreturn_t wdt_gpi_irqhdl(int, void *, struct pt_regs *);

Can probably (mostly?) go away with some creative reordering.

 > +static int locked = 0;

unneeded initialisation.

 > +static int nowayout =
 > +#if defined(CONFIG_WATCHDOG_NOWAYOUT)
 > +	1;
 > +#else
 > +	0;
 > +#endif

static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;

should work.

 > +static void wdt_gpi_set_timeout(unsigned int to)
 > +{
 > +	u32 reg;
 > +	const u32 wdval = (to * CLOCK) & ~0x0000000f;
 > +
 > +	lock_titan_regs();
 > +	reg = titan_readl(CPCCR) & ~(0xf << (wd_ctr * 4));
 > +	titan_writel(reg, CPCCR);
 > +	wmb();
 > +	__raw_writel(wdval, wd_regs + 0x0000);
 > +	wmb();
 > +	titan_writel(reg | (0x2 << (wd_ctr * 4)), CPCCR);
 > +	wmb();
 > +	titan_writel(reg | (0x5 << (wd_ctr * 4)), CPCCR);
 > +	iob();
 > +	unlock_titan_regs();
 > +}

As in the previous driver, are these barriers strong enough?
Or do they need explicit reads of the written addresses to flush the write?
 
		Dave

-- 
http://www.codemonkey.org.uk
