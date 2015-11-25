Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 03:44:58 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:45398 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007444AbbKYCoz7g-rM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 03:44:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=3CQH3a7GSC3AQW/ASar1FuY8d59PdPPcKvAUPCedOss=;
        b=ifby1Uw4nQtEUZ9yBqVKxTtwX7WWNW6iial/U3TsNdWtfrjKgLH3hoEIB/pAwTplpDM7y1+fnga2S2usxwZtusba++DBT3OpwQxIKmwv7tZh+9BDJlTWsiisSE9Qdc8HWM6HN3EnHw7SSp994fFNRCPeM5m6oCN0y6Q4XMhecEE=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43083 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1a1Q4b-003z4U-98; Wed, 25 Nov 2015 02:44:46 +0000
Subject: Re: [PATCH 5/10] watchdog: bcm63xx_wdt: Use WATCHDOG_CORE
To:     Simon Arlott <simon@fire.lp0.eu>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CBF0.30904@simon.arlott.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <56552099.7070709@roeck-us.net>
Date:   Tue, 24 Nov 2015 18:44:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5651CBF0.30904@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Simon,

On 11/22/2015 06:06 AM, Simon Arlott wrote:
> Convert bcm63xx_wdt to use WATCHDOG_CORE.
>
> The default and maximum time constants that are only used once have been
> moved to the initialisation of the struct watchdog_device.
>
Comments inline.

Thanks,
Guenter

> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
>   drivers/watchdog/Kconfig       |   1 +
>   drivers/watchdog/bcm63xx_wdt.c | 249 ++++++++++++-----------------------------
>   2 files changed, 74 insertions(+), 176 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7a8a6c6..6815b74 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1273,6 +1273,7 @@ config OCTEON_WDT
>   config BCM63XX_WDT
>   	tristate "Broadcom BCM63xx hardware watchdog"
>   	depends on BCM63XX
> +	select WATCHDOG_CORE
>   	help
>   	  Watchdog driver for the built in watchdog hardware in Broadcom
>   	  BCM63xx SoC.
> diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
> index f88fc97..1d2a501 100644
> --- a/drivers/watchdog/bcm63xx_wdt.c
> +++ b/drivers/watchdog/bcm63xx_wdt.c
> @@ -13,20 +13,15 @@
>
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> -#include <linux/bitops.h>
>   #include <linux/errno.h>
> -#include <linux/fs.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> -#include <linux/miscdevice.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
> -#include <linux/uaccess.h>
>   #include <linux/watchdog.h>
>   #include <linux/interrupt.h>
> -#include <linux/ptrace.h>
>   #include <linux/resource.h>
>   #include <linux/platform_device.h>
>
> @@ -38,53 +33,57 @@
>   #define PFX KBUILD_MODNAME
>
>   #define WDT_HZ			50000000		/* Fclk */
> -#define WDT_DEFAULT_TIME	30			/* seconds */
> -#define WDT_MAX_TIME		(0xffffffff / WDT_HZ)	/* seconds */
>
>   struct bcm63xx_wdt_hw {
>   	raw_spinlock_t lock;
>   	void __iomem *regs;
> -	unsigned long inuse;
>   	bool running;

The "running" flag should no longer be needed. watchdog_active()
should provide that information.

>   };
> -static struct bcm63xx_wdt_hw bcm63xx_wdt_device;
>
> -static int expect_close;
> -
> -static int wdt_time = WDT_DEFAULT_TIME;
>   static bool nowayout = WATCHDOG_NOWAYOUT;
>   module_param(nowayout, bool, 0);
>   MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>   	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>
> -/* HW functions */
> -static void bcm63xx_wdt_hw_start(void)
> +static int bcm63xx_wdt_start(struct watchdog_device *wdd)
>   {
> +	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
>   	unsigned long flags;
>
> -	raw_spin_lock_irqsave(&bcm63xx_wdt_device.lock, flags);
> -	bcm_writel(wdt_time * WDT_HZ, bcm63xx_wdt_device.regs + WDT_DEFVAL_REG);
> -	bcm_writel(WDT_START_1, bcm63xx_wdt_device.regs + WDT_CTL_REG);
> -	bcm_writel(WDT_START_2, bcm63xx_wdt_device.regs + WDT_CTL_REG);
> -	bcm63xx_wdt_device.running = true;
> -	raw_spin_unlock_irqrestore(&bcm63xx_wdt_device.lock, flags);
> +	raw_spin_lock_irqsave(&hw->lock, flags);
> +	bcm_writel(wdd->timeout * WDT_HZ, hw->regs + WDT_DEFVAL_REG);
> +	bcm_writel(WDT_START_1, hw->regs + WDT_CTL_REG);
> +	bcm_writel(WDT_START_2, hw->regs + WDT_CTL_REG);
> +	hw->running = true;
> +	raw_spin_unlock_irqrestore(&hw->lock, flags);
> +	return 0;
>   }
>
> -static void bcm63xx_wdt_hw_stop(void)
> +static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
>   {
> +	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
>   	unsigned long flags;
>
> -	raw_spin_lock_irqsave(&bcm63xx_wdt_device.lock, flags);
> -	bcm_writel(WDT_STOP_1, bcm63xx_wdt_device.regs + WDT_CTL_REG);
> -	bcm_writel(WDT_STOP_2, bcm63xx_wdt_device.regs + WDT_CTL_REG);
> -	bcm63xx_wdt_device.running = false;
> -	raw_spin_unlock_irqrestore(&bcm63xx_wdt_device.lock, flags);
> +	raw_spin_lock_irqsave(&hw->lock, flags);
> +	bcm_writel(WDT_STOP_1, hw->regs + WDT_CTL_REG);
> +	bcm_writel(WDT_STOP_2, hw->regs + WDT_CTL_REG);
> +	hw->running = false;
> +	raw_spin_unlock_irqrestore(&hw->lock, flags);
> +	return 0;
> +}
> +
> +static int bcm63xx_wdt_set_timeout(struct watchdog_device *wdd,
> +	unsigned int timeout)
> +{
> +	wdd->timeout = timeout;
> +	return bcm63xx_wdt_start(wdd);

If I see correctly, there is no ping function. In that case, the watchdog core
will call the start function after updating the timeout, so there is no need
to do it here.

>   }
>
>   /* The watchdog interrupt occurs when half the timeout is remaining */
>   static void bcm63xx_wdt_isr(void *data)
>   {
> -	struct bcm63xx_wdt_hw *hw = &bcm63xx_wdt_device;
> +	struct watchdog_device *wdd = data;
> +	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
>   	unsigned long flags;
>
>   	raw_spin_lock_irqsave(&hw->lock, flags);
> @@ -118,147 +117,36 @@ static void bcm63xx_wdt_isr(void *data)
>   		}
>
>   		ms = timeleft / (WDT_HZ / 1000);
> -		pr_alert("warning timer fired, reboot in %ums\n", ms);
> +		dev_alert(wdd->dev,
> +			"warning timer fired, reboot in %ums\n", ms);
>   	}
>   	raw_spin_unlock_irqrestore(&hw->lock, flags);
>   }
>
> -static int bcm63xx_wdt_settimeout(int new_time)
> -{
> -	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
> -		return -EINVAL;
> -
> -	wdt_time = new_time;
> -
> -	return 0;
> -}
> -
> -static int bcm63xx_wdt_open(struct inode *inode, struct file *file)
> -{
> -	if (test_and_set_bit(0, &bcm63xx_wdt_device.inuse))
> -		return -EBUSY;
> -
> -	bcm63xx_wdt_hw_start();
> -	return nonseekable_open(inode, file);
> -}
> -
> -static int bcm63xx_wdt_release(struct inode *inode, struct file *file)
> -{
> -	if (expect_close == 42)
> -		bcm63xx_wdt_hw_stop();
> -	else {
> -		pr_crit("Unexpected close, not stopping watchdog!\n");
> -		bcm63xx_wdt_hw_start();
> -	}
> -	clear_bit(0, &bcm63xx_wdt_device.inuse);
> -	expect_close = 0;
> -	return 0;
> -}
> -
> -static ssize_t bcm63xx_wdt_write(struct file *file, const char *data,
> -				size_t len, loff_t *ppos)
> -{
> -	if (len) {
> -		if (!nowayout) {
> -			size_t i;
> -
> -			/* In case it was set long ago */
> -			expect_close = 0;
> -
> -			for (i = 0; i != len; i++) {
> -				char c;
> -				if (get_user(c, data + i))
> -					return -EFAULT;
> -				if (c == 'V')
> -					expect_close = 42;
> -			}
> -		}
> -		bcm63xx_wdt_hw_start();
> -	}
> -	return len;
> -}
> -
> -static struct watchdog_info bcm63xx_wdt_info = {
> -	.identity       = PFX,
> -	.options        = WDIOF_SETTIMEOUT |
> -				WDIOF_KEEPALIVEPING |
> -				WDIOF_MAGICCLOSE,
> -};
> -
> -
> -static long bcm63xx_wdt_ioctl(struct file *file, unsigned int cmd,
> -				unsigned long arg)
> -{
> -	void __user *argp = (void __user *)arg;
> -	int __user *p = argp;
> -	int new_value, retval = -EINVAL;
> -
> -	switch (cmd) {
> -	case WDIOC_GETSUPPORT:
> -		return copy_to_user(argp, &bcm63xx_wdt_info,
> -			sizeof(bcm63xx_wdt_info)) ? -EFAULT : 0;
> -
> -	case WDIOC_GETSTATUS:
> -	case WDIOC_GETBOOTSTATUS:
> -		return put_user(0, p);
> -
> -	case WDIOC_SETOPTIONS:
> -		if (get_user(new_value, p))
> -			return -EFAULT;
> -
> -		if (new_value & WDIOS_DISABLECARD) {
> -			bcm63xx_wdt_hw_stop();
> -			retval = 0;
> -		}
> -		if (new_value & WDIOS_ENABLECARD) {
> -			bcm63xx_wdt_hw_start();
> -			retval = 0;
> -		}
> -
> -		return retval;
> -
> -	case WDIOC_KEEPALIVE:
> -		bcm63xx_wdt_hw_start();
> -		return 0;
> -
> -	case WDIOC_SETTIMEOUT:
> -		if (get_user(new_value, p))
> -			return -EFAULT;
> -
> -		if (bcm63xx_wdt_settimeout(new_value))
> -			return -EINVAL;
> -
> -		bcm63xx_wdt_hw_start();
> -
> -	case WDIOC_GETTIMEOUT:
> -		return put_user(wdt_time, p);
> -
> -	default:
> -		return -ENOTTY;
> -
> -	}
> -}
> -
> -static const struct file_operations bcm63xx_wdt_fops = {
> -	.owner		= THIS_MODULE,
> -	.llseek		= no_llseek,
> -	.write		= bcm63xx_wdt_write,
> -	.unlocked_ioctl	= bcm63xx_wdt_ioctl,
> -	.open		= bcm63xx_wdt_open,
> -	.release	= bcm63xx_wdt_release,
> +static struct watchdog_ops bcm63xx_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = bcm63xx_wdt_start,
> +	.stop = bcm63xx_wdt_stop,
> +	.set_timeout = bcm63xx_wdt_set_timeout,
>   };
>
> -static struct miscdevice bcm63xx_wdt_miscdev = {
> -	.minor	= WATCHDOG_MINOR,
> -	.name	= "watchdog",
> -	.fops	= &bcm63xx_wdt_fops,
> +static const struct watchdog_info bcm63xx_wdt_info = {
> +	.options = WDIOC_GETTIMELEFT | WDIOF_SETTIMEOUT |

Where is the gettimeleft function ? I think you are adding it with a later patch,
but then you should set the flag there, not here.

> +			WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "BCM63xx Watchdog",
>   };
>
> -
>   static int bcm63xx_wdt_probe(struct platform_device *pdev)
>   {
> -	int ret;
> +	struct bcm63xx_wdt_hw *hw;
> +	struct watchdog_device *wdd;
>   	struct resource *r;
> +	int ret;
> +
> +	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
> +	wdd = devm_kzalloc(&pdev->dev, sizeof(*wdd), GFP_KERNEL);

It would be better to allocate wdd as part of struct bcm63xx_wdt_hw.
Then you only need a single allocation. You can still use
	wdd = &hw->wdd;
to simplify the rest of this function.

> +	if (!hw || !wdd)
> +		return -ENOMEM;
>
>   	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	if (!r) {
> @@ -266,36 +154,44 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>
> -	bcm63xx_wdt_device.regs = devm_ioremap_nocache(&pdev->dev, r->start,
> -							resource_size(r));
> -	if (!bcm63xx_wdt_device.regs) {
> +	hw->regs = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
> +	if (!hw->regs) {
>   		dev_err(&pdev->dev, "failed to remap I/O resources\n");
>   		return -ENXIO;
>   	}
>
> -	raw_spin_lock_init(&bcm63xx_wdt_device.lock);
> +	raw_spin_lock_init(&hw->lock);
> +	hw->running = false;
> +
> +	wdd->parent = &pdev->dev;
> +	wdd->ops = &bcm63xx_wdt_ops;
> +	wdd->info = &bcm63xx_wdt_info;
> +	wdd->min_timeout = 1;
> +	wdd->max_timeout = 0xffffffff / WDT_HZ;
> +	wdd->timeout = min(30U, wdd->max_timeout);
> +
> +	watchdog_set_drvdata(wdd, hw);
> +	platform_set_drvdata(pdev, wdd);
> +
> +	watchdog_init_timeout(wdd, 0, &pdev->dev);
> +	watchdog_set_nowayout(wdd, nowayout);
>
> -	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, NULL);
> +	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, wdd);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
>   		return ret;
>   	}
>
> -	if (bcm63xx_wdt_settimeout(wdt_time)) {
> -		bcm63xx_wdt_settimeout(WDT_DEFAULT_TIME);
> -		dev_info(&pdev->dev,
> -			": wdt_time value must be 1 <= wdt_time <= %d, using %d\n",
> -			WDT_MAX_TIME, wdt_time);
> -	}
> -
> -	ret = misc_register(&bcm63xx_wdt_miscdev);
> +	ret = watchdog_register_device(wdd);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to register watchdog device\n");
>   		goto unregister_timer;
>   	}
>
> -	dev_info(&pdev->dev, " started, timer margin: %d sec\n",
> -						WDT_DEFAULT_TIME);
> +	dev_info(&pdev->dev,
> +		"%s at MMIO 0x%p (timeout = %us, max_timeout = %us)",
> +		dev_name(wdd->dev), hw->regs,
> +		wdd->timeout, wdd->max_timeout);
>
>   	return 0;
>
> @@ -306,17 +202,18 @@ unregister_timer:
>
>   static int bcm63xx_wdt_remove(struct platform_device *pdev)
>   {
> -	if (!nowayout)
> -		bcm63xx_wdt_hw_stop();
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
>
> -	misc_deregister(&bcm63xx_wdt_miscdev);
>   	bcm63xx_timer_unregister(TIMER_WDT_ID);
> +	watchdog_unregister_device(wdd);

Shouldn't that come first, before unregistering the timer ?

>   	return 0;
>   }
>
>   static void bcm63xx_wdt_shutdown(struct platform_device *pdev)
>   {
> -	bcm63xx_wdt_hw_stop();
> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
> +
> +	bcm63xx_wdt_stop(wdd);
>   }
>
>   static struct platform_driver bcm63xx_wdt_driver = {
>
