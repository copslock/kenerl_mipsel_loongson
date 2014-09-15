Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 05:02:14 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:53375 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006940AbaIODCNGYoMF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 05:02:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=QetI6axKlh3zAp/8TOvGpomlK+Iq/67hVEFWqoF+MNE=;
        b=AvR7E7tCXjnBBevFG33H1YTFbxSM+EGo3T//GyYv3aIPWtaBwC2djR5vDRWfZ+UOTcFdXh4xHOQr3Yw20wIh7YxlLDg/VEW5CemZ1SfFWp6VPaNCIUqsqIfAXxJaYLuWZhJ+UAJ5gOKiv4mGnUfzcGyJg1oDXJERq67zAJ6oyNI=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XTMYH-0026kx-Tp
        for linux-mips@linux-mips.org; Mon, 15 Sep 2014 03:02:06 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:39822 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XTMYB-0026ao-7j; Mon, 15 Sep 2014 03:02:00 +0000
Message-ID: <541656A3.8030906@roeck-us.net>
Date:   Sun, 14 Sep 2014 20:01:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS <linux-mips@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC 13/18] watchdog: add Atheros AR2315 watchdog driver
References: <1410723213-22440-1-git-send-email-ryazanov.s.a@gmail.com> <1410723213-22440-14-git-send-email-ryazanov.s.a@gmail.com>
In-Reply-To: <1410723213-22440-14-git-send-email-ryazanov.s.a@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A02020A.541656AD.00E4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 3
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42562
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

On 09/14/2014 12:33 PM, Sergey Ryazanov wrote:
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: linux-watchdog@vger.kernel.org
> ---
>   arch/mips/ar231x/ar2315.c     |  26 +++++-
>   drivers/watchdog/Kconfig      |   7 ++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/ar2315-wtd.c | 202 ++++++++++++++++++++++++++++++++++++++++++

This should be two patches: One to instantiate the watchdog,
the second the watchdog driver itself. The weatchdog driver
should use the watchdog infrastructure.

Guenter

>   4 files changed, 235 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/watchdog/ar2315-wtd.c
>
> diff --git a/arch/mips/ar231x/ar2315.c b/arch/mips/ar231x/ar2315.c
> index cab3b76..62cf548 100644
> --- a/arch/mips/ar231x/ar2315.c
> +++ b/arch/mips/ar231x/ar2315.c
> @@ -62,7 +62,10 @@ static void ar2315_misc_irq_handler(unsigned irq, struct irq_desc *desc)
>   		generic_handle_irq(AR2315_MISC_IRQ_GPIO);
>   	} else if (pending & AR2315_ISR_UART0)
>   		generic_handle_irq(AR2315_MISC_IRQ_UART0);
> -	else
> +	else if (pending & AR2315_ISR_WD) {
> +		ar231x_write_reg(AR2315_ISR, AR2315_ISR_WD);
> +		generic_handle_irq(AR2315_MISC_IRQ_WATCHDOG);
> +	} else
>   		spurious_interrupt();
>   }
>
> @@ -148,6 +151,26 @@ static struct platform_device ar2315_spiflash = {
>   	.num_resources = ARRAY_SIZE(ar2315_spiflash_res)
>   };
>
> +static struct resource ar2315_wdt_res[] = {
> +	{
> +		.flags = IORESOURCE_MEM,
> +		.start = AR2315_WD,
> +		.end = AR2315_WD + 8 - 1,
> +	},
> +	{
> +		.flags = IORESOURCE_IRQ,
> +		.start = AR2315_MISC_IRQ_WATCHDOG,
> +		.end = AR2315_MISC_IRQ_WATCHDOG,
> +	}
> +};
> +
> +static struct platform_device ar2315_wdt = {
> +	.id = -1,
> +	.name = "ar2315-wdt",
> +	.resource = ar2315_wdt_res,
> +	.num_resources = ARRAY_SIZE(ar2315_wdt_res)
> +};
> +
>   static struct resource ar2315_gpio_res[] = {
>   	{
>   		.name = "ar2315-gpio",
> @@ -193,6 +216,7 @@ void __init ar2315_init_devices(void)
>   	ar231x_find_config(ar2315_flash_limit);
>
>   	platform_device_register(&ar2315_gpio);
> +	platform_device_register(&ar2315_wdt);
>   	platform_device_register(&ar2315_spiflash);
>   }
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f57312f..0e84f3a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1186,6 +1186,13 @@ config RALINK_WDT
>   	help
>   	  Hardware driver for the Ralink SoC Watchdog Timer.
>
> +config AR2315_WDT
> +	tristate "Atheros AR2315+ WiSoCs Watchdog Timer"
> +	depends on SOC_AR2315
> +	help
> +	  Hardware driver for the built-in watchdog timer on the Atheros
> +	  AR2315/AR2316 WiSoCs.
> +
>   # PARISC Architecture
>
>   # POWERPC Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 468c320..ef7f83b 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -133,6 +133,7 @@ obj-$(CONFIG_WDT_MTX1) += mtx-1_wdt.o
>   obj-$(CONFIG_PNX833X_WDT) += pnx833x_wdt.o
>   obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
>   obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
> +obj-$(CONFIG_AR2315_WDT) += ar2315-wtd.o
>   obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
>   obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
>   octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
> diff --git a/drivers/watchdog/ar2315-wtd.c b/drivers/watchdog/ar2315-wtd.c
> new file mode 100644
> index 0000000..8e1687a
> --- /dev/null
> +++ b/drivers/watchdog/ar2315-wtd.c
> @@ -0,0 +1,202 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * Copyright (C) 2008 John Crispin <blogic@openwrt.org>
> + * Based on EP93xx and ifxmips wdt driver

2008 ?

> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/types.h>
> +#include <linux/miscdevice.h>
> +#include <linux/watchdog.h>
> +#include <linux/fs.h>
> +#include <linux/ioport.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +
> +#define DRIVER_NAME	"ar2315-wdt"
> +
> +#define CLOCK_RATE 40000000
> +#define HEARTBEAT(x) (x < 1 || x > 90 ? 20 : x)
> +
Whatever the logic is here, it does not make much sense to me.

> +#define WDT_REG_TIMER		0x00
> +#define WDT_REG_CTRL		0x04
> +
> +#define WDT_CTRL_ACT_NONE	0x00000000	/* No action */
> +#define WDT_CTRL_ACT_NMI	0x00000001	/* NMI on watchdog */
> +#define WDT_CTRL_ACT_RESET	0x00000002	/* reset on watchdog */
> +
> +static int wdt_timeout = 20;
> +static int started;
> +static int in_use;
> +static void __iomem *wdt_base;
> +
> +static inline void ar2315_wdt_wr(unsigned reg, u32 val)
> +{
> +	iowrite32(val, wdt_base + reg);
> +}
> +
> +static void ar2315_wdt_enable(void)
> +{
> +	ar2315_wdt_wr(WDT_REG_TIMER, wdt_timeout * CLOCK_RATE);
> +}
> +
> +static ssize_t ar2315_wdt_write(struct file *file, const char __user *data,
> +				size_t len, loff_t *ppos)
> +{
> +	if (len)
> +		ar2315_wdt_enable();
> +	return len;
> +}
> +
> +static int ar2315_wdt_open(struct inode *inode, struct file *file)
> +{
> +	if (in_use)
> +		return -EBUSY;
> +	ar2315_wdt_enable();
> +	in_use = 1;
> +	started = 1;
> +	return nonseekable_open(inode, file);
> +}
> +
> +static int ar2315_wdt_release(struct inode *inode, struct file *file)
> +{
> +	in_use = 0;
> +	return 0;
> +}
> +
> +static irqreturn_t ar2315_wdt_interrupt(int irq, void *dev)
> +{
> +	struct platform_device *pdev = (struct platform_device *)dev;
> +
> +	if (started) {
> +		dev_crit(&pdev->dev, "watchdog expired, rebooting system\n");
> +		emergency_restart();
> +	} else {
> +		ar2315_wdt_wr(WDT_REG_CTRL, 0);
> +		ar2315_wdt_wr(WDT_REG_TIMER, 0);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static struct watchdog_info ident = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity = "ar2315 Watchdog",
> +};
> +
> +static long ar2315_wdt_ioctl(struct file *file, unsigned int cmd,
> +			     unsigned long arg)
> +{
> +	int new_wdt_timeout;
> +	int ret = -ENOIOCTLCMD;
> +
> +	switch (cmd) {
> +	case WDIOC_GETSUPPORT:
> +		ret = copy_to_user((void __user *)arg, &ident, sizeof(ident)) ?
> +		      -EFAULT : 0;
> +		break;
> +	case WDIOC_KEEPALIVE:
> +		ar2315_wdt_enable();
> +		ret = 0;
> +		break;
> +	case WDIOC_SETTIMEOUT:
> +		ret = get_user(new_wdt_timeout, (int __user *)arg);
> +		if (ret)
> +			break;
> +		wdt_timeout = HEARTBEAT(new_wdt_timeout);
> +		ar2315_wdt_enable();
> +		break;
> +	case WDIOC_GETTIMEOUT:
> +		ret = put_user(wdt_timeout, (int __user *)arg);
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static const struct file_operations ar2315_wdt_fops = {
> +	.owner		= THIS_MODULE,
> +	.llseek		= no_llseek,
> +	.write		= ar2315_wdt_write,
> +	.unlocked_ioctl	= ar2315_wdt_ioctl,
> +	.open		= ar2315_wdt_open,
> +	.release	= ar2315_wdt_release,
> +};
> +
> +static struct miscdevice ar2315_wdt_miscdev = {
> +	.minor	= WATCHDOG_MINOR,
> +	.name	= "watchdog",
> +	.fops	= &ar2315_wdt_fops,
> +};
> +
> +static int ar2315_wdt_probe(struct platform_device *dev)
> +{
> +	struct resource *mem_res, *irq_res;
> +	int ret = 0;
> +
> +	if (wdt_base)
> +		return -EBUSY;
> +
> +	irq_res = platform_get_resource(dev, IORESOURCE_IRQ, 0);
> +	if (!irq_res) {
> +		dev_err(&dev->dev, "no IRQ resource\n");
> +		return -ENOENT;
> +	}
> +
> +	mem_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	wdt_base = devm_ioremap_resource(&dev->dev, mem_res);
> +	if (IS_ERR(wdt_base))
> +		return PTR_ERR(wdt_base);
> +
> +	ret = devm_request_irq(&dev->dev, irq_res->start, ar2315_wdt_interrupt,
> +			       IRQF_DISABLED, DRIVER_NAME, dev);
> +	if (ret) {
> +		dev_err(&dev->dev, "failed to register inetrrupt\n");
> +		goto out;
> +	}
> +
> +	ret = misc_register(&ar2315_wdt_miscdev);
> +	if (ret)
> +		dev_err(&dev->dev, "failed to register miscdev\n");
> +
> +out:
> +	return ret;
> +}
> +
> +static int ar2315_wdt_remove(struct platform_device *dev)
> +{
> +	misc_deregister(&ar2315_wdt_miscdev);
> +	return 0;
> +}
> +
> +static struct platform_driver ar2315_wdt_driver = {
> +	.probe = ar2315_wdt_probe,
> +	.remove = ar2315_wdt_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(ar2315_wdt_driver);
> +
> +MODULE_DESCRIPTION("Atheros AR2315 hardware watchdog driver");
> +MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
>
