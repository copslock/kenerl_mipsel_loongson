Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2008 00:54:00 +0000 (GMT)
Received: from mx0.towertech.it ([213.215.222.73]:53989 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S23157044AbYKEAx5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 5 Nov 2008 00:53:57 +0000
Received: (qmail 13864 invoked from network); 5 Nov 2008 01:53:56 +0100
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 5 Nov 2008 01:53:56 +0100
Date:	Wed, 5 Nov 2008 01:53:53 +0100
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	rtc-linux@googlegroups.com
Cc:	mano@roarinelk.homelinux.net,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [rtc-linux] Re: [RFC PATCH] Au1xxx on-chip counter-as-RTC
 driver
Message-ID: <20081105015353.18130dbc@i1501.lan.towertech.it>
In-Reply-To: <20081028105220.GA1235@roarinelk.homelinux.net>
References: <20080809161402.15e24b2e@flagship.roarinelk.net>
	<20081021203815.1a0a246d@i1501.lan.towertech.it>
	<20081022073114.GA11169@roarinelk.homelinux.net>
	<20081028111704.2feb3b53@i1501.lan.towertech.it>
	<20081028105220.GA1235@roarinelk.homelinux.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
X-This-Is-A-Real-Message: Yes
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alessandro.zummo@towertech.it>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Tue, 28 Oct 2008 11:52:20 +0100
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

 Hi Manuel, some more comments


> --- 
> Subject: [PATCH] RTC: Au1000 On-Chip Counter0-as-RTC driver.
> 
> Simple driver which uses the Au1xxx Time-Of-Year counter (counter0)
> as a 1Hz RTC.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
>  drivers/rtc/Kconfig      |    9 +++
>  drivers/rtc/Makefile     |    1 +
>  drivers/rtc/rtc-au1xxx.c |  161 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-au1xxx.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 8abbb20..8431fda 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -604,6 +604,15 @@ config RTC_DRV_AT91SAM9_GPBR
>  	  will be used.  The default of zero is normally OK to use, but
>  	  on some systems other software needs to use that register.
>  
> +config RTC_DRV_AU1XXX
> +	tristate "Au1xxx TOY-as-RTC support"
> +	depends on SOC_AU1X00
> +	help
> +	  This driver uses Au1000 on-chip Counter0 as a Real Time Clock.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-au1xxx.
> +
>  config RTC_DRV_BFIN
>  	tristate "Blackfin On-Chip RTC"
>  	depends on BLACKFIN && !BF561
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index e9e8474..cc213ab 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -20,6 +20,7 @@ rtc-core-$(CONFIG_RTC_INTF_SYSFS) += rtc-sysfs.o
>  obj-$(CONFIG_RTC_DRV_AT32AP700X)+= rtc-at32ap700x.o
>  obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
>  obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
> +obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
>  obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
>  obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
>  obj-$(CONFIG_RTC_DRV_DS1216)	+= rtc-ds1216.o
> diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
> new file mode 100644
> index 0000000..62e5c9b
> --- /dev/null
> +++ b/drivers/rtc/rtc-au1xxx.c
> @@ -0,0 +1,161 @@
> +/*
> + * Au1xxx counter0 (aka Time-of-year counter) RTC interface driver.
> + *
> + * Copyright (C) 2008 Manuel Lauss <mano@roarinelk.homelinux.net>
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +/* All current Au1xxx SoCs have 2 counters fed by an external 32.768 kHz
> + * crystal. Counter 0, which keeps counting during sleep/powerdown, is
> + * used to count seconds since the beginning of the unix epoch.
> + *
> + * The counters must be configured and enabled by bootloader/board code;
> + * no checks as to whether they really get a proper 32.768kHz clock are
> + * made.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/rtc.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <asm/mach-au1x00/au1000.h>
> +
> +/* 32kHz clock enabled and detected */
> +#define CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
> +
> +static int au1xtoy_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	unsigned long t;
> +
> +	t = au_readl(SYS_TOYREAD);
> +
> +	rtc_time_to_tm(t, tm);
> +
> +	if (rtc_valid_tm(tm) < 0) {
> +		dev_err(dev, "invalid date stored in counter0\n");
> +		rtc_time_to_tm(0, tm);
> +	}
> +
> +	return 0;
> +}


 you should return an error if the date is invalid.
 return rtc_valid_tm(tm) would do


> +static int au1xtoy_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	unsigned long t;
> +
> +	rtc_tm_to_time(tm, &t);
> +
> +	au_writel(t, SYS_TOYWRITE);
> +	au_sync();
> +
> +	/* wait for the pending register write to succeed.  This can
> +	 * take up to 6 seconds...
> +	 */
> +	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
> +		schedule();
> +
> +	return 0;
> +}
> +
> +static struct rtc_class_ops au1xtoy_rtc_ops = {
> +	.read_time	= au1xtoy_rtc_read_time,
> +	.set_time	= au1xtoy_rtc_set_time,
> +};
> +
> +static int __devinit au1xtoy_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rtc_device *rtcdev;
> +	unsigned long t;
> +	int ret;
> +
> +	t = au_readl(SYS_COUNTER_CNTRL);
> +	if (!(t & CNTR_OK)) {
> +		dev_err(&pdev->dev, "counters not working; aborting.\n");
> +		ret = -ENODEV;
> +		goto out_err;
> +	}
> +
> +	ret = -ETIMEDOUT;
> +
> +	/* set counter0 tickrate to 1Hz if necessary */
> +	if (au_readl(SYS_TOYTRIM) != 32767) {
> +		/* wait until hardware gives access to TRIM register */
> +		t = 0x00100000;
> +		while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T0S) && t--)
> +			schedule();
> +
> +		if (!t) {
> +			/* timed out waiting for register access; assume
> +			 * counters are unusable.
> +			 */
> +			dev_err(&pdev->dev, "timeout waiting for access\n");
> +			goto out_err;
> +		}
> +
> +		/* set 1Hz TOY tick rate */
> +		au_writel(32767, SYS_TOYTRIM);
> +		au_sync();
> +	}
> +
> +	/* wait until the hardware allows writes to the counter reg */
> +	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
> +		schedule();
> +
> +	rtcdev = rtc_device_register("rtc-au1xxx", &pdev->dev,
> +				     &au1xtoy_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtcdev)) {
> +		ret = PTR_ERR(rtcdev);
> +		goto out_err;
> +	}
> +
> +	platform_set_drvdata(pdev, rtcdev);
> +
> +	return 0;
> +
> +out_err:
> +	return ret;
> +}
> +
> +static int __devexit au1xtoy_rtc_remove(struct platform_device *pdev)
> +{
> +	struct rtc_device *rtcdev = platform_get_drvdata(pdev);
> +
> +	if (likely(rtcdev))

 no need to check

> +		rtc_device_unregister(rtcdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}
> +
> +static struct platform_driver au1xtoy_rtc_platform_driver = {
> +	.driver		= {
> +		.name	= "rtc-au1xxx",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= au1xtoy_rtc_probe,
> +	.remove		= __devexit_p(au1xtoy_rtc_remove),
> +};
> +
> +static int __init au1xtoy_rtc_init(void)
> +{
> +	return platform_driver_register(&au1xtoy_rtc_platform_driver);

 you should be using platform_driver_probe here which will require
 __init/__exit instead of __devinit __devexit

> +}
> +
> +static void __exit au1xtoy_rtc_exit(void)
> +{
> +	platform_driver_unregister(&au1xtoy_rtc_platform_driver);
> +}
> +
> +module_init(au1xtoy_rtc_init);
> +module_exit(au1xtoy_rtc_exit);
> +
> +MODULE_DESCRIPTION("Au1xxx TOY-counter-based RTC driver");
> +MODULE_AUTHOR("Manuel Lauss");

 email here please

> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:rtc-au1xxx");
> -- 
> 1.6.0.2
> 
> 
> --~--~---------~--~----~------------~-------~--~----~
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.
> -~----------~----~----~----~------~----~------~--~---
> 


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
