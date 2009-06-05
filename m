Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2009 21:30:38 +0100 (WEST)
Received: from smtp6-g21.free.fr ([212.27.42.6]:58811 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022523AbZFEUab (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Jun 2009 21:30:31 +0100
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 16E2DE08092;
	Fri,  5 Jun 2009 22:30:24 +0200 (CEST)
Received: from [192.168.1.189] (cac94-1-81-57-151-96.fbx.proxad.net [81.57.151.96])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 837B0E080F7;
	Fri,  5 Jun 2009 22:30:21 +0200 (CEST)
Message-ID: <4A29805D.60205@free.fr>
Date:	Fri, 05 Jun 2009 22:30:21 +0200
From:	matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20081204 Iceape/1.1.14 (Debian-1.1.14-1)
MIME-Version: 1.0
To:	Andrew Morton <akpm@linux-foundation.org>
CC:	wim@iguana.be, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, biblbroks@sezampro.rs
Subject: Re: add bcm47xx watchdog driver
References: <4A282D98.6020004@free.fr> <20090605124813.d7666ed0.akpm@linux-foundation.org>
In-Reply-To: <20090605124813.d7666ed0.akpm@linux-foundation.org>
Content-Type: multipart/mixed;
 boundary="------------050009010201040002080707"
Return-Path: <castet.matthieu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: castet.matthieu@free.fr
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050009010201040002080707
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Andrew Morton wrote:
> On Thu, 04 Jun 2009 22:24:56 +0200
> matthieu castet <castet.matthieu@free.fr> wrote:
> 
>>
>> This add watchdog driver for broadcom 47xx device.
>> It uses the ssb subsytem to access embeded watchdog device.
>>
>> Because the watchdog timeout is very short (about 2s), a soft timer is used
>> to increase the watchdog period.
>>
>> Note : A patch for exporting the ssb_watchdog_timer_set will
>> be submitted on next linux-mips merge. Without this patch it can't 
>> be build as a module.
>>
>>
>> ...
>>
>> --- linux-2.6.orig/drivers/watchdog/Kconfig	2009-05-25 22:22:02.000000000 +0200
>> +++ linux-2.6/drivers/watchdog/Kconfig	2009-05-25 22:26:06.000000000 +0200
>> @@ -764,6 +764,12 @@
>>  	help
>>  	  Hardware driver for the built-in watchdog timer on TXx9 MIPS SoCs.
>>  
>> +config BCM47XX_WDT
>> +    tristate "Broadcom BCM47xx Watchdog Timer"
>> +    depends on BCM47XX
>> +    help
>> +      Hardware driver for the Broadcom BCM47xx Watchog Timer.
>> +
> 
> Please indent the kconfig body with a single tab character.
> 
Done

>> ...
>>
>> +#define DRV_NAME		"bcm47xx_wdt"
>> +
>> +#define WDT_DEFAULT_TIME	30	/* seconds */
>> +#define WDT_MAX_TIME		256	/* seconds */
>> +
>> +static int wdt_time = WDT_DEFAULT_TIME;
>> +static int nowayout = WATCHDOG_NOWAYOUT;
>> +
>> +module_param(wdt_time, int, 0);
>> +MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
>> +				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
>> +
>> +#ifdef CONFIG_WATCHDOG_NOWAYOUT
>> +module_param(nowayout, int, 0);
>> +MODULE_PARM_DESC(nowayout,
>> +		"Watchdog cannot be stopped once started (default="
>> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +#endif
> 
> hm, now what's happening with the third arg to module_param()?
I don't understand what you mean.
This thing is common in watchdog drivers. For example 
drivers/watchdog/at91rm9200_wdt.c does the same thing.

> 
>> +static struct platform_device *bcm47xx_wdt_platform_device;
>> +
>> +static unsigned long bcm47xx_wdt_busy;
>> +static char expect_release;
>> +static struct timer_list wdt_timer;
>> +static atomic_t ticks;
>> +
>> +static inline void bcm47xx_wdt_hw_start(void)
>> +{
>> +	/* this is 2,5s on 100Mhz clock  and 2s on 133 Mhz */
>> +	ssb_watchdog_timer_set(&ssb_bcm47xx, 0xfffffff);
>> +}
>> +
>> +static inline int bcm47xx_wdt_hw_stop(void)
>> +{
>> +	return ssb_watchdog_timer_set(&ssb_bcm47xx, 0);
>> +}
>> +
>> +static void bcm47xx_timer_tick(unsigned long unused)
>> +{
>> +	if(!atomic_dec_and_test(&ticks)) {
> 
> Please pass this patch (and all others) through scripts/checkpatch.pl
> and review the resulting output.
Done, everything is ok, expect a printk line over 80 characters.

> 
>> +		bcm47xx_wdt_hw_start();
>> +		mod_timer(&wdt_timer, jiffies + HZ);
>> +	}
>> +	else {
>> +		printk(KERN_CRIT PFX "Watchdog will fire soon!!!.\n");
>> +	}
>> +}
>> +
>> +static inline void bcm47xx_wdt_pet(void)
>> +{
>> +	atomic_set(&ticks, wdt_time);
>> +}
> 
> What does "pet" stand for?
> 
A watchdog timer is a computer hardware timing device that triggers a 
system reset if the main program, due to some fault condition, such as a 
hang, neglects to regularly service the watchdog (writing a �service 
pulse� to it, also referred to as �petting the dog� [1]

[1] http://en.wikipedia.org/wiki/Watchdog_timer

But I can change the name if you want. Note that pet appear in 
drivers/watchdog/sb_wdog.c and drivers/watchdog/sbc_epx_c3.c

>> +static void bcm47xx_wdt_start(void)
>> +{
>> +	bcm47xx_wdt_pet();
>> +	bcm47xx_timer_tick(0);
>> +}
>> +
>> +static void bcm47xx_wdt_pause(void)
>> +{
>> +	del_timer(&wdt_timer);
> 
> Should this be del_timer_sync()?  The timer callback can still be
> executing after del_timer() returns.
Yes, changed to del_timer_sync()

>> +static int bcm47xx_wdt_release(struct inode *inode, struct file *file)
>> +{
>> +	if (expect_release == 42) {
>> +		bcm47xx_wdt_stop();
>> +	} else {
>> +		printk(KERN_CRIT DRV_NAME ": Unexpected close, not stopping watchdog!\n");
> 
> Can this happen?
yes : this is a common pattern in watchdog driver (check for example 
softdog) :
- expect_release is in bss (set to 0)
- we set expect_release to this magic value, only if we get a write with 
a special character and we are not in nowayout.
- So for example doing a "cat /dev/watchdog" should go in this path.

> 
>> +		bcm47xx_wdt_start();
>> +	}
>> +
>> +	clear_bit(0, &bcm47xx_wdt_busy);
>> +	expect_release = 0;
>> +	return 0;
>> +}
>> +

Thanks for the review.

I attach a new version.

--------------050009010201040002080707
Content-Type: text/x-diff;
 name="bcm47xx_watchdog_v3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bcm47xx_watchdog_v3.diff"

This add watchdog driver for broadcom 47xx device.
It uses the ssb subsytem to access embeded watchdog device.

Because the watchdog timeout is very short (about 2s), a soft timer is used
to increase the watchdog period.

Note : A patch for exporting the ssb_watchdog_timer_set will
be submitted on next linux-mips merge. Without this patch it can't 
be build as a module.

Signed-off-by: Aleksandar Radovanovic <biblbroks@sezampro.rs>
Signed-off-by: Matthieu CASTET <castet.matthieu@free.fr>
Index: linux-2.6/drivers/watchdog/Kconfig
===================================================================
--- linux-2.6.orig/drivers/watchdog/Kconfig	2009-05-25 22:22:02.000000000 +0200
+++ linux-2.6/drivers/watchdog/Kconfig	2009-06-05 22:05:19.000000000 +0200
@@ -764,6 +764,12 @@
 	help
 	  Hardware driver for the built-in watchdog timer on TXx9 MIPS SoCs.
 
+config BCM47XX_WDT
+	tristate "Broadcom BCM47xx Watchdog Timer"
+	depends on BCM47XX
+	help
+	  Hardware driver for the Broadcom BCM47xx Watchog Timer.
+
 # PARISC Architecture
 
 # POWERPC Architecture
Index: linux-2.6/drivers/watchdog/Makefile
===================================================================
--- linux-2.6.orig/drivers/watchdog/Makefile	2009-05-25 22:22:02.000000000 +0200
+++ linux-2.6/drivers/watchdog/Makefile	2009-05-25 23:02:27.000000000 +0200
@@ -105,6 +105,7 @@
 obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
 obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
 obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
+obj-$(CONFIG_BCM47XX_WDT) += bcm47xx_wdt.o
 
 # PARISC Architecture
 
Index: linux-2.6/drivers/watchdog/bcm47xx_wdt.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/watchdog/bcm47xx_wdt.c	2009-06-05 22:25:37.000000000 +0200
@@ -0,0 +1,286 @@
+/*
+ *  Watchdog driver for Broadcom BCM47XX
+ *
+ *  Copyright (C) 2008 Aleksandar Radovanovic <biblbroks@sezampro.rs>
+ *  Copyright (C) 2009 Matthieu CASTET <castet.matthieu@free.fr>
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/reboot.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/watchdog.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/ssb/ssb_embedded.h>
+#include <asm/mach-bcm47xx/bcm47xx.h>
+
+#define DRV_NAME		"bcm47xx_wdt"
+
+#define WDT_DEFAULT_TIME	30	/* seconds */
+#define WDT_MAX_TIME		256	/* seconds */
+
+static int wdt_time = WDT_DEFAULT_TIME;
+static int nowayout = WATCHDOG_NOWAYOUT;
+
+module_param(wdt_time, int, 0);
+MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
+				__MODULE_STRING(WDT_DEFAULT_TIME) ")");
+
+#ifdef CONFIG_WATCHDOG_NOWAYOUT
+module_param(nowayout, int, 0);
+MODULE_PARM_DESC(nowayout,
+		"Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+#endif
+
+static unsigned long bcm47xx_wdt_busy;
+static char expect_release;
+static struct timer_list wdt_timer;
+static atomic_t ticks;
+
+static inline void bcm47xx_wdt_hw_start(void)
+{
+	/* this is 2,5s on 100Mhz clock  and 2s on 133 Mhz */
+	ssb_watchdog_timer_set(&ssb_bcm47xx, 0xfffffff);
+}
+
+static inline int bcm47xx_wdt_hw_stop(void)
+{
+	return ssb_watchdog_timer_set(&ssb_bcm47xx, 0);
+}
+
+static void bcm47xx_timer_tick(unsigned long unused)
+{
+	if (!atomic_dec_and_test(&ticks)) {
+		bcm47xx_wdt_hw_start();
+		mod_timer(&wdt_timer, jiffies + HZ);
+	} else {
+		printk(KERN_CRIT DRV_NAME "Watchdog will fire soon!!!\n");
+	}
+}
+
+static inline void bcm47xx_wdt_pet(void)
+{
+	atomic_set(&ticks, wdt_time);
+}
+
+static void bcm47xx_wdt_start(void)
+{
+	bcm47xx_wdt_pet();
+	bcm47xx_timer_tick(0);
+}
+
+static void bcm47xx_wdt_pause(void)
+{
+	del_timer_sync(&wdt_timer);
+	bcm47xx_wdt_hw_stop();
+}
+
+static void bcm47xx_wdt_stop(void)
+{
+	bcm47xx_wdt_pause();
+}
+
+static int bcm47xx_wdt_settimeout(int new_time)
+{
+	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
+		return -EINVAL;
+
+	wdt_time = new_time;
+	return 0;
+}
+
+static int bcm47xx_wdt_open(struct inode *inode, struct file *file)
+{
+	if (test_and_set_bit(0, &bcm47xx_wdt_busy))
+		return -EBUSY;
+
+	bcm47xx_wdt_start();
+	return nonseekable_open(inode, file);
+}
+
+static int bcm47xx_wdt_release(struct inode *inode, struct file *file)
+{
+	if (expect_release == 42) {
+		bcm47xx_wdt_stop();
+	} else {
+		printk(KERN_CRIT DRV_NAME
+			": Unexpected close, not stopping watchdog!\n");
+		bcm47xx_wdt_start();
+	}
+
+	clear_bit(0, &bcm47xx_wdt_busy);
+	expect_release = 0;
+	return 0;
+}
+
+static ssize_t bcm47xx_wdt_write(struct file *file, const char __user *data,
+			      size_t len, loff_t *ppos)
+{
+	if (len) {
+		if (!nowayout) {
+			size_t i;
+
+			expect_release = 0;
+
+			for (i = 0; i != len; i++) {
+				char c;
+				if (get_user(c, data + i))
+					return -EFAULT;
+				if (c == 'V')
+					expect_release = 42;
+			}
+		}
+		bcm47xx_wdt_pet();
+	}
+	return len;
+}
+
+static struct watchdog_info bcm47xx_wdt_info = {
+	.identity 	= DRV_NAME,
+	.options 	= WDIOF_SETTIMEOUT |
+				WDIOF_KEEPALIVEPING |
+				WDIOF_MAGICCLOSE,
+};
+
+static long bcm47xx_wdt_ioctl(struct file *file,
+					unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	int __user *p = argp;
+	int new_value, retval = -EINVAL;;
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		return copy_to_user(argp, &bcm47xx_wdt_info,
+				sizeof(bcm47xx_wdt_info)) ? -EFAULT : 0;
+
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, p);
+
+	case WDIOC_SETOPTIONS:
+		if (get_user(new_value, p))
+			return -EFAULT;
+
+		if (new_value & WDIOS_DISABLECARD) {
+			bcm47xx_wdt_stop();
+			retval = 0;
+		}
+
+		if (new_value & WDIOS_ENABLECARD) {
+			bcm47xx_wdt_start();
+			retval = 0;
+		}
+
+		return retval;
+
+	case WDIOC_KEEPALIVE:
+		bcm47xx_wdt_pet();
+		return 0;
+
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_value, p))
+			return -EFAULT;
+
+		if (bcm47xx_wdt_settimeout(new_value))
+			return -EINVAL;
+
+		bcm47xx_wdt_pet();
+
+	case WDIOC_GETTIMEOUT:
+		return put_user(wdt_time, p);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+static int bcm47xx_wdt_notify_sys(struct notifier_block *this,
+	   unsigned long code, void *unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT)
+		bcm47xx_wdt_stop();
+	return NOTIFY_DONE;
+}
+
+static const struct file_operations bcm47xx_wdt_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= no_llseek,
+	.unlocked_ioctl	= bcm47xx_wdt_ioctl,
+	.open		= bcm47xx_wdt_open,
+	.release	= bcm47xx_wdt_release,
+	.write		= bcm47xx_wdt_write,
+};
+
+static struct miscdevice bcm47xx_wdt_miscdev = {
+	.minor		= WATCHDOG_MINOR,
+	.name		= "watchdog",
+	.fops		= &bcm47xx_wdt_fops,
+};
+
+static struct notifier_block bcm47xx_wdt_notifier = {
+	.notifier_call = bcm47xx_wdt_notify_sys,
+};
+
+static int __init bcm47xx_wdt_init(void)
+{
+	int ret;
+
+	if (bcm47xx_wdt_hw_stop() < 0)
+		return -ENODEV;
+
+	setup_timer(&wdt_timer, bcm47xx_timer_tick, 0L);
+
+	if (bcm47xx_wdt_settimeout(wdt_time)) {
+		bcm47xx_wdt_settimeout(WDT_DEFAULT_TIME);
+		printk(KERN_INFO DRV_NAME
+			": wdt_time value must be 1 <= wdt_time <= 256, using %d\n",
+			wdt_time);
+	}
+
+	ret = register_reboot_notifier(&bcm47xx_wdt_notifier);
+	if (ret)
+		return ret;
+
+	ret = misc_register(&bcm47xx_wdt_miscdev);
+	if (ret) {
+		unregister_reboot_notifier(&bcm47xx_wdt_notifier);
+		return ret;
+	}
+
+	printk(KERN_INFO "BCM47xx Watchdog Timer enabled (%d seconds%s)\n",
+				wdt_time, nowayout ? ", nowayout" : "");
+	return 0;
+}
+
+static void __exit bcm47xx_wdt_exit(void)
+{
+	if (!nowayout)
+		bcm47xx_wdt_stop();
+
+	misc_deregister(&bcm47xx_wdt_miscdev);
+
+	unregister_reboot_notifier(&bcm47xx_wdt_notifier);
+}
+
+module_init(bcm47xx_wdt_init);
+module_exit(bcm47xx_wdt_exit);
+
+MODULE_AUTHOR("Aleksandar Radovanovic");
+MODULE_DESCRIPTION("Watchdog driver for Broadcom BCM47xx");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

--------------050009010201040002080707--
