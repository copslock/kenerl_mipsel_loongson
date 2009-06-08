Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 15:16:01 +0100 (WEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:58978 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023619AbZFHOPy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jun 2009 15:15:54 +0100
Received: by fxm25 with SMTP id 25so2893918fxm.20
        for <linux-mips@linux-mips.org>; Mon, 08 Jun 2009 07:15:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Qp8U+D3YMby2wobugaBTxBAX8IsS2yVWkymOjEyJL2U=;
        b=XTotPh8WeOjhMGFyylQJy+0amPqunTeeWOFPNdgR/U7X5rhY4qJqSaWWUWTRXJaO6U
         3mIr6LtRwgRQapuY2Ftd4lPRuExA50ZosrKVr8XHZ1q4wFgXJHvfx7ggSMBRKyafqIy9
         MZdS2giZaBac4DDyWZtoIM1gmkWCIxqJU+dzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DBOzWIcR1mGXU7DMV9aDVMeMnpIrwZccb9h106hO5X87XQAuKtF8UY8H8RkZNi8+sA
         gJsystcwqHfamCznMWERPdfSDcM83xTm7lPFFznv7lKR18Tija9Zv1nyg8186hyUmITl
         zXogMZr5PXJmn3f41Row81RDLXLYduJkfVOCQ=
Received: by 10.223.117.14 with SMTP id o14mr4213730faq.21.1244470548369;
        Mon, 08 Jun 2009 07:15:48 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id e17sm3721502fke.48.2009.06.08.07.15.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Jun 2009 07:15:48 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	matthieu castet <castet.matthieu@free.fr>
Subject: Re: add bcm47xx watchdog driver
Date:	Mon, 8 Jun 2009 16:15:44 +0200
User-Agent: KMail/1.9.9
Cc:	Andrew Morton <akpm@linux-foundation.org>, wim@iguana.be,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	biblbroks@sezampro.rs
References: <4A282D98.6020004@free.fr> <20090605124813.d7666ed0.akpm@linux-foundation.org> <4A29805D.60205@free.fr>
In-Reply-To: <4A29805D.60205@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906081615.45889.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Le Friday 05 June 2009 22:30:21 matthieu castet, vous avez écrit :
> Andrew Morton wrote:
> > On Thu, 04 Jun 2009 22:24:56 +0200
> >
> > matthieu castet <castet.matthieu@free.fr> wrote:
> >> This add watchdog driver for broadcom 47xx device.
> >> It uses the ssb subsytem to access embeded watchdog device.
> >>
> >> Because the watchdog timeout is very short (about 2s), a soft timer is
> >> used to increase the watchdog period.
> >>
> >> Note : A patch for exporting the ssb_watchdog_timer_set will
> >> be submitted on next linux-mips merge. Without this patch it can't
> >> be build as a module.

It works very well on my Netgear WGT634U, thanks !

Tested-by: Florian Fainelli <florian@openwrt.org>

> >>
> >>
> >> ...
> >>
> >> --- linux-2.6.orig/drivers/watchdog/Kconfig	2009-05-25
> >> 22:22:02.000000000 +0200 +++
> >> linux-2.6/drivers/watchdog/Kconfig	2009-05-25 22:26:06.000000000 +0200
> >> @@ -764,6 +764,12 @@
> >>  	help
> >>  	  Hardware driver for the built-in watchdog timer on TXx9 MIPS SoCs.
> >>
> >> +config BCM47XX_WDT
> >> +    tristate "Broadcom BCM47xx Watchdog Timer"
> >> +    depends on BCM47XX
> >> +    help
> >> +      Hardware driver for the Broadcom BCM47xx Watchog Timer.
> >> +
> >
> > Please indent the kconfig body with a single tab character.
>
> Done
>
> >> ...
> >>
> >> +#define DRV_NAME		"bcm47xx_wdt"
> >> +
> >> +#define WDT_DEFAULT_TIME	30	/* seconds */
> >> +#define WDT_MAX_TIME		256	/* seconds */
> >> +
> >> +static int wdt_time = WDT_DEFAULT_TIME;
> >> +static int nowayout = WATCHDOG_NOWAYOUT;
> >> +
> >> +module_param(wdt_time, int, 0);
> >> +MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
> >> +				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
> >> +
> >> +#ifdef CONFIG_WATCHDOG_NOWAYOUT
> >> +module_param(nowayout, int, 0);
> >> +MODULE_PARM_DESC(nowayout,
> >> +		"Watchdog cannot be stopped once started (default="
> >> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> >> +#endif
> >
> > hm, now what's happening with the third arg to module_param()?
>
> I don't understand what you mean.
> This thing is common in watchdog drivers. For example
> drivers/watchdog/at91rm9200_wdt.c does the same thing.
>
> >> +static struct platform_device *bcm47xx_wdt_platform_device;
> >> +
> >> +static unsigned long bcm47xx_wdt_busy;
> >> +static char expect_release;
> >> +static struct timer_list wdt_timer;
> >> +static atomic_t ticks;
> >> +
> >> +static inline void bcm47xx_wdt_hw_start(void)
> >> +{
> >> +	/* this is 2,5s on 100Mhz clock  and 2s on 133 Mhz */
> >> +	ssb_watchdog_timer_set(&ssb_bcm47xx, 0xfffffff);
> >> +}
> >> +
> >> +static inline int bcm47xx_wdt_hw_stop(void)
> >> +{
> >> +	return ssb_watchdog_timer_set(&ssb_bcm47xx, 0);
> >> +}
> >> +
> >> +static void bcm47xx_timer_tick(unsigned long unused)
> >> +{
> >> +	if(!atomic_dec_and_test(&ticks)) {
> >
> > Please pass this patch (and all others) through scripts/checkpatch.pl
> > and review the resulting output.
>
> Done, everything is ok, expect a printk line over 80 characters.
>
> >> +		bcm47xx_wdt_hw_start();
> >> +		mod_timer(&wdt_timer, jiffies + HZ);
> >> +	}
> >> +	else {
> >> +		printk(KERN_CRIT PFX "Watchdog will fire soon!!!.\n");
> >> +	}
> >> +}
> >> +
> >> +static inline void bcm47xx_wdt_pet(void)
> >> +{
> >> +	atomic_set(&ticks, wdt_time);
> >> +}
> >
> > What does "pet" stand for?
>
> A watchdog timer is a computer hardware timing device that triggers a
> system reset if the main program, due to some fault condition, such as a
> hang, neglects to regularly service the watchdog (writing a “service
> pulse” to it, also referred to as “petting the dog” [1]
>
> [1] http://en.wikipedia.org/wiki/Watchdog_timer
>
> But I can change the name if you want. Note that pet appear in
> drivers/watchdog/sb_wdog.c and drivers/watchdog/sbc_epx_c3.c
>
> >> +static void bcm47xx_wdt_start(void)
> >> +{
> >> +	bcm47xx_wdt_pet();
> >> +	bcm47xx_timer_tick(0);
> >> +}
> >> +
> >> +static void bcm47xx_wdt_pause(void)
> >> +{
> >> +	del_timer(&wdt_timer);
> >
> > Should this be del_timer_sync()?  The timer callback can still be
> > executing after del_timer() returns.
>
> Yes, changed to del_timer_sync()
>
> >> +static int bcm47xx_wdt_release(struct inode *inode, struct file *file)
> >> +{
> >> +	if (expect_release == 42) {
> >> +		bcm47xx_wdt_stop();
> >> +	} else {
> >> +		printk(KERN_CRIT DRV_NAME ": Unexpected close, not stopping
> >> watchdog!\n");
> >
> > Can this happen?
>
> yes : this is a common pattern in watchdog driver (check for example
> softdog) :
> - expect_release is in bss (set to 0)
> - we set expect_release to this magic value, only if we get a write with
> a special character and we are not in nowayout.
> - So for example doing a "cat /dev/watchdog" should go in this path.
>
> >> +		bcm47xx_wdt_start();
> >> +	}
> >> +
> >> +	clear_bit(0, &bcm47xx_wdt_busy);
> >> +	expect_release = 0;
> >> +	return 0;
> >> +}
> >> +
>
> Thanks for the review.
>
> I attach a new version.



-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
