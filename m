Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 09:53:03 +0100 (BST)
Received: from mx0.towertech.it ([213.215.222.73]:5785 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S20033281AbYHGIwx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Aug 2008 09:52:53 +0100
Received: (qmail 8034 invoked from network); 7 Aug 2008 10:52:50 +0200
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 7 Aug 2008 10:52:50 +0200
Date:	Thu, 7 Aug 2008 10:52:49 +0200
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	rtc-linux@googlegroups.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] DS1286: new RTC driver
Message-ID: <20080807105249.50d6e777@i1501.lan.towertech.it>
In-Reply-To: <20080803174137.AF8071DA6F4@solo.franken.de>
References: <20080803174137.AF8071DA6F4@solo.franken.de>
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
X-archive-position: 20144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Sun,  3 Aug 2008 19:41:37 +0200 (CEST)
Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:


 A few comments below...



> This driver replaces the broken DS1286 driver in drivers/char and
> gives back RTC support for SGI IP22 and IP28 machines.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
> 
>  drivers/rtc/Kconfig      |    6 +
>  drivers/rtc/Makefile     |    1 +
>  drivers/rtc/rtc-ds1286.c |  425 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 432 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 90ab738..934f630 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -352,6 +352,12 @@ config RTC_DRV_DS1216
>  	help
>  	  If you say yes here you get support for the Dallas DS1216 RTC chips.
>  
> +config RTC_DRV_DS1286
> +	tristate "Dallas DS1286"
> +	depends on SGI_HAS_DS1286
> +	help
> +	  If you say yes here you get support for the Dallas DS1286 RTC chips.
> +
>  config RTC_DRV_DS1302
>  	tristate "Dallas DS1302"
>  	depends on SH_SECUREEDGE5410
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 18622ef..e060802 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
>  obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
>  obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
>  obj-$(CONFIG_RTC_DRV_DS1216)	+= rtc-ds1216.o
> +obj-$(CONFIG_RTC_DRV_DS1286)	+= rtc-ds1286.o
>  obj-$(CONFIG_RTC_DRV_DS1302)	+= rtc-ds1302.o
>  obj-$(CONFIG_RTC_DRV_DS1305)	+= rtc-ds1305.o
>  obj-$(CONFIG_RTC_DRV_DS1307)	+= rtc-ds1307.o
> diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
> new file mode 100644
> index 0000000..2f6def0
> --- /dev/null
> +++ b/drivers/rtc/rtc-ds1286.c
> @@ -0,0 +1,425 @@
> +/*
> + * DS1286 Real Time Clock interface for Linux
> + *
> + * Copyright (C) 1998, 1999, 2000 Ralf Baechle
> + * Copyright (C) 2008 Thomas Bogendoerfer
> + *
> + * Based on code written by Paul Gortmaker.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/rtc.h>
> +#include <linux/platform_device.h>
> +#include <linux/bcd.h>
> +#include <linux/ds1286.h>
> +
> +#define DRV_VERSION		"1.0"
> +
> +struct ds1286_priv {
> +	struct rtc_device *rtc;
> +	u32 __iomem *rtcregs;
> +	size_t size;
> +	unsigned long baseaddr;
> +	spinlock_t lock;
> +};
> +
> +static unsigned char days_in_mo[] = {
> +	0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
> +};
> +
> +static inline u8 ds1286_rtc_read(struct ds1286_priv *priv, int reg)
> +{
> +	return __raw_readl(&priv->rtcregs[reg]) & 0xff;
> +}
> +
> +static inline void ds1286_rtc_write(struct ds1286_priv *priv, u8 data, int reg)
> +{
> +	__raw_writel(data, &priv->rtcregs[reg]);
> +}
> +
> +#ifdef CONFIG_RTC_INTF_DEV
> +
> +static int ds1286_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
> +{
> +	struct ds1286_priv *priv = dev_get_drvdata(dev);
> +	unsigned long flags;
> +	unsigned char val;
> +
> +	switch (cmd) {
> +	case RTC_AIE_OFF:
> +		/* Mask alarm int. enab. bit	*/
> +		spin_lock_irqsave(&priv->lock, flags);
> +		val = ds1286_rtc_read(priv, RTC_CMD);
> +		val |=  RTC_TDM;
> +		ds1286_rtc_write(priv, val, RTC_CMD);
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		break;
> +	case RTC_AIE_ON:
> +		/* Allow alarm interrupts.	*/
> +		spin_lock_irqsave(&priv->lock, flags);
> +		val = ds1286_rtc_read(priv, RTC_CMD);
> +		val &=  ~RTC_TDM;
> +		ds1286_rtc_write(priv, val, RTC_CMD);
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		break;
> +	case RTC_WIE_OFF:
> +		/* Mask watchdog int. enab. bit	*/
> +		spin_lock_irqsave(&priv->lock, flags);
> +		val = ds1286_rtc_read(priv, RTC_CMD);
> +		val |= RTC_WAM;
> +		ds1286_rtc_write(priv, val, RTC_CMD);
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		break;
> +	case RTC_WIE_ON:
> +		/* Allow watchdog interrupts.	*/
> +		spin_lock_irqsave(&priv->lock, flags);
> +		val = ds1286_rtc_read(priv, RTC_CMD);
> +		val &= ~RTC_WAM;
> +		ds1286_rtc_write(priv, val, RTC_CMD);
> +		spin_unlock_irqrestore(&priv->lock, flags);
> +		break;
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +	return 0;
> +}
> +
> +#else
> +#define ds1286_ioctl    NULL
> +#endif
> +
> +#ifdef CONFIG_PROC_FS
> +
> +static int ds1286_proc(struct device *dev, struct seq_file *seq)
> +{
> +	struct ds1286_priv *priv = dev_get_drvdata(dev);
> +	unsigned char month, cmd, amode;
> +	const char *s;
> +
> +	month = ds1286_rtc_read(priv, RTC_MONTH);
> +	seq_printf(seq,
> +		   "oscillator\t: %s\n"
> +		   "square_wave\t: %s\n",
> +		   (month & RTC_EOSC) ? "disabled" : "enabled",
> +		   (month & RTC_ESQW) ? "disabled" : "enabled");
> +
> +	amode = ((ds1286_rtc_read(priv, RTC_MINUTES_ALARM) & 0x80) >> 5) |
> +		((ds1286_rtc_read(priv, RTC_HOURS_ALARM) & 0x80) >> 6) |
> +		((ds1286_rtc_read(priv, RTC_DAY_ALARM) & 0x80) >> 7);
> +	switch (amode) {
> +	case 7:
> +		s = "each minute";
> +		break;
> +	case 3:
> +		s = "minutes match";
> +		break;
> +	case 1:
> +		s = "hours and minutes match";
> +		break;
> +	case 0:
> +		s = "days, hours and minutes match";
> +		break;
> +	default:
> +		s = "invalid";
> +		break;
> +	}
> +	seq_printf(seq, "alarm_mode\t: %s\n", s);
> +
> +	cmd = ds1286_rtc_read(priv, RTC_CMD);
> +	seq_printf(seq,
> +		   "alarm_enable\t: %s\n"
> +		   "wdog_alarm\t: %s\n"
> +		   "alarm_mask\t: %s\n"
> +		   "wdog_alarm_mask\t: %s\n"
> +		   "interrupt_mode\t: %s\n"
> +		   "INTB_mode\t: %s_active\n"
> +		   "interrupt_pins\t: %s\n",
> +		   (cmd & RTC_TDF) ? "yes" : "no",
> +		   (cmd & RTC_WAF) ? "yes" : "no",
> +		   (cmd & RTC_TDM) ? "disabled" : "enabled",
> +		   (cmd & RTC_WAM) ? "disabled" : "enabled",
> +		   (cmd & RTC_PU_LVL) ? "pulse" : "level",
> +		   (cmd & RTC_IBH_LO) ? "low" : "high",
> +		   (cmd & RTC_IPSW) ? "unswapped" : "swapped");
> +	return 0;
> +}
> +
> +#else
> +#define ds1286_proc     NULL
> +#endif
> +
> +static int ds1286_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ds1286_priv *priv = dev_get_drvdata(dev);
> +	unsigned char save_control;
> +	unsigned long flags;
> +	unsigned long uip_watchdog = jiffies;
> +
> +	/*
> +	 * read RTC once any update in progress is done. The update
> +	 * can take just over 2ms. We wait 10 to 20ms. There is no need to
> +	 * to poll-wait (up to 1s - eeccch) for the falling edge of RTC_UIP.
> +	 * If you need to know *exactly* when a second has started, enable
> +	 * periodic update complete interrupts, (via ioctl) and then
> +	 * immediately read /dev/rtc which will block until you get the IRQ.
> +	 * Once the read clears, read the RTC time (again via ioctl). Easy.
> +	 */
> +
> +	if (ds1286_rtc_read(priv, RTC_CMD) & RTC_TE)
> +		while (time_before(jiffies, uip_watchdog + 2*HZ/100))
> +			barrier();
> +
> +	/*
> +	 * Only the values that we read from the RTC are set. We leave
> +	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
> +	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
> +	 * by the RTC when initially set to a non-zero value.
> +	 */
> +	spin_lock_irqsave(&priv->lock, flags);
> +	save_control = ds1286_rtc_read(priv, RTC_CMD);
> +	ds1286_rtc_write(priv, (save_control|RTC_TE), RTC_CMD);
> +
> +	tm->tm_sec = ds1286_rtc_read(priv, RTC_SECONDS);
> +	tm->tm_min = ds1286_rtc_read(priv, RTC_MINUTES);
> +	tm->tm_hour = ds1286_rtc_read(priv, RTC_HOURS) & 0x3f;
> +	tm->tm_mday = ds1286_rtc_read(priv, RTC_DATE);
> +	tm->tm_mon = ds1286_rtc_read(priv, RTC_MONTH) & 0x1f;
> +	tm->tm_year = ds1286_rtc_read(priv, RTC_YEAR);
> +
> +	ds1286_rtc_write(priv, save_control, RTC_CMD);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	BCD_TO_BIN(tm->tm_sec);
> +	BCD_TO_BIN(tm->tm_min);
> +	BCD_TO_BIN(tm->tm_hour);
> +	BCD_TO_BIN(tm->tm_mday);
> +	BCD_TO_BIN(tm->tm_mon);
> +	BCD_TO_BIN(tm->tm_year);
> +
> +	/*
> +	 * Account for differences between how the RTC uses the values
> +	 * and how they are defined in a struct rtc_time;
> +	 */
> +	if (tm->tm_year < 45)
> +		tm->tm_year += 30;
> +	tm->tm_year += 40;
> +	if (tm->tm_year < 70)
> +		tm->tm_year += 100;
> +
> +	tm->tm_mon--;
> +
> +	return rtc_valid_tm(tm);
> +}
> +
> +static int ds1286_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ds1286_priv *priv = dev_get_drvdata(dev);
> +	unsigned char mon, day, hrs, min, sec, leap_yr;
> +	unsigned char save_control;
> +	unsigned int yrs;
> +	unsigned long flags;
> +
> +
> +	yrs = tm->tm_year + 1900;
> +	mon = tm->tm_mon + 1;   /* tm_mon starts at zero */
> +	day = tm->tm_mday;
> +	hrs = tm->tm_hour;
> +	min = tm->tm_min;
> +	sec = tm->tm_sec;

> +
> +	if (yrs < 1970)
> +		return -EINVAL;
> +
> +	leap_yr = ((!(yrs % 4) && (yrs % 100)) || !(yrs % 400));
> +
> +	if ((mon > 12) || (day == 0))
> +		return -EINVAL;
> +
> +	if (day > (days_in_mo[mon] + ((mon == 2) && leap_yr)))
> +		return -EINVAL;
> +
> +	if ((hrs >= 24) || (min >= 60) || (sec >= 60))
> +		return -EINVAL;
> +
> +	yrs -= 1940;
> +	if (yrs > 255)    /* They are unsigned */
> +		return -EINVAL;


 please check rtc-lib.c . there are functions that might help
 you to verify boundaries.


> +	if (yrs >= 100)
> +		yrs -= 100;
> +
> +	BIN_TO_BCD(sec);
> +	BIN_TO_BCD(min);
> +	BIN_TO_BCD(hrs);
> +	BIN_TO_BCD(day);
> +	BIN_TO_BCD(mon);
> +	BIN_TO_BCD(yrs);
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +	save_control = ds1286_rtc_read(priv, RTC_CMD);
> +	ds1286_rtc_write(priv, (save_control|RTC_TE), RTC_CMD);
> +
> +	ds1286_rtc_write(priv, yrs, RTC_YEAR);
> +	ds1286_rtc_write(priv, mon, RTC_MONTH);
> +	ds1286_rtc_write(priv, day, RTC_DATE);
> +	ds1286_rtc_write(priv, hrs, RTC_HOURS);
> +	ds1286_rtc_write(priv, min, RTC_MINUTES);
> +	ds1286_rtc_write(priv, sec, RTC_SECONDS);
> +	ds1286_rtc_write(priv, 0, RTC_HUNDREDTH_SECOND);
> +
> +	ds1286_rtc_write(priv, save_control, RTC_CMD);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +	return 0;
> +}
> +
> +static int ds1286_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> +	struct ds1286_priv *priv = dev_get_drvdata(dev);
> +	unsigned char cmd;
> +	unsigned long flags;
> +
> +	/*
> +	 * Only the values that we read from the RTC are set. That
> +	 * means only tm_wday, tm_hour, tm_min.
> +	 */
> +	spin_lock_irqsave(&priv->lock, flags);
> +	alm->time.tm_min = ds1286_rtc_read(priv, RTC_MINUTES_ALARM) & 0x7f;
> +	alm->time.tm_hour = ds1286_rtc_read(priv, RTC_HOURS_ALARM)  & 0x1f;
> +	alm->time.tm_wday = ds1286_rtc_read(priv, RTC_DAY_ALARM)    & 0x07;
> +	cmd = ds1286_rtc_read(priv, RTC_CMD);
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	BCD_TO_BIN(alm->time.tm_min);
> +	BCD_TO_BIN(alm->time.tm_hour);
> +	alm->time.tm_sec = 0;
> +	return 0;
> +}
> +
> +static int ds1286_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> +{
> +	struct ds1286_priv *priv = dev_get_drvdata(dev);
> +	unsigned char hrs, min, sec;
> +
> +	hrs = alm->time.tm_hour;
> +	min = alm->time.tm_min;
> +	sec = alm->time.tm_sec;
> +
> +	if (hrs >= 24)
> +		hrs = 0xff;
> +
> +	if (min >= 60)
> +		min = 0xff;
> +
> +	if (sec != 0)
> +		return -EINVAL;
> +
> +	min = BIN2BCD(min);
> +	hrs = BIN2BCD(hrs);
> +
> +	spin_lock(&priv->lock);
> +	ds1286_rtc_write(priv, hrs, RTC_HOURS_ALARM);
> +	ds1286_rtc_write(priv, min, RTC_MINUTES_ALARM);
> +	spin_unlock(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops ds1286_ops = {
> +	.ioctl   	= ds1286_ioctl,
> +	.proc   	= ds1286_proc,
> +	.read_time	= ds1286_read_time,
> +	.set_time	= ds1286_set_time,
> +	.read_alarm	= ds1286_read_alarm,
> +	.set_alarm	= ds1286_set_alarm,
> +};
> +
> +static int __devinit ds1286_probe(struct platform_device *pdev)
> +{
> +	struct rtc_device *rtc;
> +	struct resource *res;
> +	struct ds1286_priv *priv;
> +	int ret = 0;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	priv = kzalloc(sizeof *priv, GFP_KERNEL);

 sizeof(struct ds1286_priv) is a little bit cleaner.

> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->size = res->end - res->start + 1;
> +	if (!request_mem_region(res->start, priv->size, pdev->name)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +	priv->baseaddr = res->start;
> +	priv->rtcregs = ioremap(priv->baseaddr, priv->size);
> +	if (!priv->rtcregs) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	spin_lock_init(&priv->lock);
> +	rtc = rtc_device_register("ds1286", &pdev->dev,
> +				  &ds1286_ops, THIS_MODULE);
> +	if (IS_ERR(rtc)) {
> +		ret = PTR_ERR(rtc);
> +		goto out;
> +	}
> +	priv->rtc = rtc;
> +	platform_set_drvdata(pdev, priv);
> +	return 0;
> +
> +out:
> +	if (priv->rtc)
> +		rtc_device_unregister(priv->rtc);
> +	if (priv->rtcregs)
> +		iounmap(priv->rtcregs);
> +	if (priv->baseaddr)
> +		release_mem_region(priv->baseaddr, priv->size);
> +	kfree(priv);
> +	return ret;
> +}
> +
> +static int __devexit ds1286_remove(struct platform_device *pdev)
> +{
> +	struct ds1286_priv *priv = platform_get_drvdata(pdev);
> +
> +	rtc_device_unregister(priv->rtc);
> +	iounmap(priv->rtcregs);
> +	release_mem_region(priv->baseaddr, priv->size);
> +	kfree(priv);
> +	return 0;
> +}
> +
> +static struct platform_driver ds1286_platform_driver = {
> +	.driver		= {
> +		.name	= "rtc-ds1286",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= ds1286_probe,
> +	.remove		= __devexit_p(ds1286_remove),
> +};
> +
> +static int __init ds1286_init(void)
> +{
> +	return platform_driver_register(&ds1286_platform_driver);
> +}
> +
> +static void __exit ds1286_exit(void)
> +{
> +	platform_driver_unregister(&ds1286_platform_driver);
> +}
> +
> +MODULE_AUTHOR("Thomas Bogendoerfer <tsbogend@alpha.franken.de>");
> +MODULE_DESCRIPTION("DS1286 RTC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_ALIAS("platform:rtc-ds1286");
> +
> +module_init(ds1286_init);
> +module_exit(ds1286_exit);


-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
