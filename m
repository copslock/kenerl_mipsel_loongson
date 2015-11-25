Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 03:51:15 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:46448 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007444AbbKYCvMudKXM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 03:51:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=rv4wc/+gOe0SROfMxILR+HlUDWY7IT1oXUvsEpbX+F0=;
        b=x9679GkWjDqc2i68X44nsBIR23h8/CLsPeuHMDtchrCTEuPcUjZQAUTYkGJ/em61U9uhFqmLFXBGnFQwJVK/ijDv/mEAkMYhXtevM5zhDEoOmx1Gy38+i5Y/hbY+1CKBgZmBx9B2JL9GEztI1VGBbAsHeIxmgr7HNK5dz6AXrKw=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:43105 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1a1QAh-000GlO-UZ; Wed, 25 Nov 2015 02:51:05 +0000
Subject: Re: [PATCH (v2) 7/10] watchdog: bcm63xx_wdt: Add get_timeleft
 function
To:     Simon Arlott <simon@fire.lp0.eu>, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CC90.7090402@simon.arlott.org.uk>
 <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <56552214.2050808@roeck-us.net>
Date:   Tue, 24 Nov 2015 18:51:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
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
X-archive-position: 50077
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

On 11/24/2015 02:15 PM, Simon Arlott wrote:
> Return the remaining time from the hardware control register.
>
> Warn when the device is registered if the hardware watchdog is currently
> running and report the remaining time left.

This is really two logical changes, isn't it ?

Nice trick to figure out if the watchdog is running.

What is the impact ? Will this result in interrupts ?
If so, would it make sense to _not_ reset the system after a timeout
in this case, but to keep pinging the watchdog while the watchdog device
is not open ?

Thanks,
Guenter

>
> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
> ---
> Changed "if (timeleft > 0)" to "if (hw->running)" when checking if a
> warning should be printed, in case the time left is truncated down to
> 0 seconds.
>
>   drivers/watchdog/bcm63xx_wdt.c | 37 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 37 insertions(+)
>
> diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
> index 3c7667a..9d099e0 100644
> --- a/drivers/watchdog/bcm63xx_wdt.c
> +++ b/drivers/watchdog/bcm63xx_wdt.c
> @@ -14,6 +14,7 @@
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
>   #include <linux/clk.h>
> +#include <linux/delay.h>
>   #include <linux/errno.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> @@ -75,6 +76,19 @@ static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
>   	return 0;
>   }
>
> +static unsigned int bcm63xx_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&hw->lock, flags);
> +	val = __raw_readl(hw->regs + WDT_CTL_REG);
> +	val /= hw->clock_hz;
> +	raw_spin_unlock_irqrestore(&hw->lock, flags);
> +	return val;
> +}
> +
>   static int bcm63xx_wdt_set_timeout(struct watchdog_device *wdd,
>   	unsigned int timeout)
>   {
> @@ -130,6 +144,7 @@ static struct watchdog_ops bcm63xx_wdt_ops = {
>   	.owner = THIS_MODULE,
>   	.start = bcm63xx_wdt_start,
>   	.stop = bcm63xx_wdt_stop,
> +	.get_timeleft = bcm63xx_wdt_get_timeleft,
>   	.set_timeout = bcm63xx_wdt_set_timeout,
>   };
>
> @@ -144,6 +159,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
>   	struct bcm63xx_wdt_hw *hw;
>   	struct watchdog_device *wdd;
>   	struct resource *r;
> +	u32 timeleft1, timeleft2;
> +	unsigned int timeleft;
>   	int ret;
>
>   	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
> @@ -197,6 +214,23 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
>   	watchdog_init_timeout(wdd, 0, &pdev->dev);
>   	watchdog_set_nowayout(wdd, nowayout);
>
> +	/* Compare two reads of the time left value, 2 clock ticks apart */
> +	rmb();
> +	timeleft1 = __raw_readl(hw->regs + WDT_CTL_REG);
> +	udelay(DIV_ROUND_UP(1000000, hw->clock_hz / 2));
> +	/* Ensure the register is read twice */
> +	rmb();
> +	timeleft2 = __raw_readl(hw->regs + WDT_CTL_REG);
> +
> +	/* If the time left is changing, the watchdog is running */
> +	if (timeleft1 != timeleft2) {
> +		hw->running = true;
> +		timeleft = bcm63xx_wdt_get_timeleft(wdd);
> +	} else {
> +		hw->running = false;
> +		timeleft = 0;
> +	}
> +
>   	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, wdd);
>   	if (ret < 0) {
>   		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
> @@ -214,6 +248,8 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
>   		dev_name(wdd->dev), hw->regs,
>   		wdd->timeout, wdd->max_timeout);
>
> +	if (hw->running)
> +		dev_alert(wdd->dev, "running, reboot in %us\n", timeleft);
>   	return 0;
>
>   unregister_timer:
> @@ -255,6 +291,7 @@ module_platform_driver(bcm63xx_wdt_driver);
>
>   MODULE_AUTHOR("Miguel Gaio <miguel.gaio@efixo.com>");
>   MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
> +MODULE_AUTHOR("Simon Arlott");
>   MODULE_DESCRIPTION("Driver for the Broadcom BCM63xx SoC watchdog");
>   MODULE_LICENSE("GPL");
>   MODULE_ALIAS("platform:bcm63xx-wdt");
>
