Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 20:48:48 +0100 (WEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57244 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023146AbZFETsk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2009 20:48:40 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n55JmFr7018324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Jun 2009 12:48:16 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id n55JmDQV031354;
	Fri, 5 Jun 2009 12:48:13 -0700
Date:	Fri, 5 Jun 2009 12:48:13 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	matthieu castet <castet.matthieu@free.fr>
Cc:	wim@iguana.be, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, biblbroks@sezampro.rs
Subject: Re: add bcm47xx watchdog driver
Message-Id: <20090605124813.d7666ed0.akpm@linux-foundation.org>
In-Reply-To: <4A282D98.6020004@free.fr>
References: <4A282D98.6020004@free.fr>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Thu, 04 Jun 2009 22:24:56 +0200
matthieu castet <castet.matthieu@free.fr> wrote:

> 
>
> This add watchdog driver for broadcom 47xx device.
> It uses the ssb subsytem to access embeded watchdog device.
> 
> Because the watchdog timeout is very short (about 2s), a soft timer is used
> to increase the watchdog period.
> 
> Note : A patch for exporting the ssb_watchdog_timer_set will
> be submitted on next linux-mips merge. Without this patch it can't 
> be build as a module.
> 
>
> ...
>
> --- linux-2.6.orig/drivers/watchdog/Kconfig	2009-05-25 22:22:02.000000000 +0200
> +++ linux-2.6/drivers/watchdog/Kconfig	2009-05-25 22:26:06.000000000 +0200
> @@ -764,6 +764,12 @@
>  	help
>  	  Hardware driver for the built-in watchdog timer on TXx9 MIPS SoCs.
>  
> +config BCM47XX_WDT
> +    tristate "Broadcom BCM47xx Watchdog Timer"
> +    depends on BCM47XX
> +    help
> +      Hardware driver for the Broadcom BCM47xx Watchog Timer.
> +

Please indent the kconfig body with a single tab character.

>
> ...
>
> +#define DRV_NAME		"bcm47xx_wdt"
> +
> +#define WDT_DEFAULT_TIME	30	/* seconds */
> +#define WDT_MAX_TIME		256	/* seconds */
> +
> +static int wdt_time = WDT_DEFAULT_TIME;
> +static int nowayout = WATCHDOG_NOWAYOUT;
> +
> +module_param(wdt_time, int, 0);
> +MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
> +				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
> +
> +#ifdef CONFIG_WATCHDOG_NOWAYOUT
> +module_param(nowayout, int, 0);
> +MODULE_PARM_DESC(nowayout,
> +		"Watchdog cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +#endif

hm, now what's happening with the third arg to module_param()?

> +static struct platform_device *bcm47xx_wdt_platform_device;
> +
> +static unsigned long bcm47xx_wdt_busy;
> +static char expect_release;
> +static struct timer_list wdt_timer;
> +static atomic_t ticks;
> +
> +static inline void bcm47xx_wdt_hw_start(void)
> +{
> +	/* this is 2,5s on 100Mhz clock  and 2s on 133 Mhz */
> +	ssb_watchdog_timer_set(&ssb_bcm47xx, 0xfffffff);
> +}
> +
> +static inline int bcm47xx_wdt_hw_stop(void)
> +{
> +	return ssb_watchdog_timer_set(&ssb_bcm47xx, 0);
> +}
> +
> +static void bcm47xx_timer_tick(unsigned long unused)
> +{
> +	if(!atomic_dec_and_test(&ticks)) {

Please pass this patch (and all others) through scripts/checkpatch.pl
and review the resulting output.

> +		bcm47xx_wdt_hw_start();
> +		mod_timer(&wdt_timer, jiffies + HZ);
> +	}
> +	else {
> +		printk(KERN_CRIT PFX "Watchdog will fire soon!!!.\n");
> +	}
> +}
> +
> +static inline void bcm47xx_wdt_pet(void)
> +{
> +	atomic_set(&ticks, wdt_time);
> +}

What does "pet" stand for?

> +static void bcm47xx_wdt_start(void)
> +{
> +	bcm47xx_wdt_pet();
> +	bcm47xx_timer_tick(0);
> +}
> +
> +static void bcm47xx_wdt_pause(void)
> +{
> +	del_timer(&wdt_timer);

Should this be del_timer_sync()?  The timer callback can still be
executing after del_timer() returns.

> +	bcm47xx_wdt_hw_stop();
> +}
> +
> +static void bcm47xx_wdt_stop(void)
> +{
> +	bcm47xx_wdt_pause();
> +}
> +
> +static int bcm47xx_wdt_settimeout(int new_time)
> +{
> +	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
> +		return -EINVAL;
> +
> +	wdt_time = new_time;
> +	return 0;
> +}
> +
> +static int bcm47xx_wdt_open(struct inode *inode, struct file *file)
> +{
> +	if (test_and_set_bit(0, &bcm47xx_wdt_busy))
> +		return -EBUSY;
> +
> +	bcm47xx_wdt_start();
> +	return nonseekable_open(inode, file);
> +}
> +
> +static int bcm47xx_wdt_release(struct inode *inode, struct file *file)
> +{
> +	if (expect_release == 42) {
> +		bcm47xx_wdt_stop();
> +	} else {
> +		printk(KERN_CRIT DRV_NAME ": Unexpected close, not stopping watchdog!\n");

Can this happen?

> +		bcm47xx_wdt_start();
> +	}
> +
> +	clear_bit(0, &bcm47xx_wdt_busy);
> +	expect_release = 0;
> +	return 0;
> +}
> +
>
> ...
>
