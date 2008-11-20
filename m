Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2008 15:45:59 +0000 (GMT)
Received: from mx0.towertech.it ([213.215.222.73]:9114 "HELO mx0.towertech.it")
	by ftp.linux-mips.org with SMTP id S23792574AbYKTPpr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Nov 2008 15:45:47 +0000
Received: (qmail 30078 invoked from network); 20 Nov 2008 16:45:38 +0100
Received: from unknown (HELO i1501.lan.towertech.it) (81.208.60.204)
  by mx0.towertech.it with SMTP; 20 Nov 2008 16:45:38 +0100
Date:	Thu, 20 Nov 2008 16:45:33 +0100
From:	Alessandro Zummo <alessandro.zummo@towertech.it>
To:	rtc-linux@googlegroups.com
Cc:	anemo@mba.ocn.ne.jp, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [rtc-linux] [PATCH 3/4] rtc: Add rtc-tx4939 driver
Message-ID: <20081120164533.73ba1f7f@i1501.lan.towertech.it>
In-Reply-To: <1227194815-16200-1-git-send-email-anemo@mba.ocn.ne.jp>
References: <1227194815-16200-1-git-send-email-anemo@mba.ocn.ne.jp>
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
X-archive-position: 21344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alessandro.zummo@towertech.it
Precedence: bulk
X-list: linux-mips

On Fri, 21 Nov 2008 00:26:54 +0900
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> 
> Add support for RTC in TX4939 SoC.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

 nack, please see below.


> ---
>  drivers/rtc/Kconfig      |    7 +
>  drivers/rtc/Makefile     |    1 +
>  drivers/rtc/rtc-tx4939.c |  338 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-tx4939.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 123092d..80da08f 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -679,4 +679,11 @@ config RTC_DRV_STARFIRE
>  	  If you say Y here you will get support for the RTC found on
>  	  Starfire systems.
>  
> +config RTC_DRV_TX4939
> +	tristate "TX4939 SoC"
> +	depends on SOC_TX4939
> +	help
> +	  Driver for the internal RTC (Realtime Clock) module found on
> +	  Toshiba TX4939 SoC.
> +
>  endif # RTC_CLASS
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 6e79c91..84dbffd 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -66,6 +66,7 @@ obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
>  obj-$(CONFIG_RTC_DRV_STK17TA8)	+= rtc-stk17ta8.o
>  obj-$(CONFIG_RTC_DRV_TEST)	+= rtc-test.o
>  obj-$(CONFIG_RTC_DRV_TWL4030)	+= rtc-twl4030.o
> +obj-$(CONFIG_RTC_DRV_TX4939)	+= rtc-tx4939.o
>  obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020.o
>  obj-$(CONFIG_RTC_DRV_VR41XX)	+= rtc-vr41xx.o
>  obj-$(CONFIG_RTC_DRV_WM8350)	+= rtc-wm8350.o
> diff --git a/drivers/rtc/rtc-tx4939.c b/drivers/rtc/rtc-tx4939.c
> new file mode 100644
> index 0000000..405790c
> --- /dev/null
> +++ b/drivers/rtc/rtc-tx4939.c
> @@ -0,0 +1,338 @@
> +/*
> + * TX4939 internal RTC driver
> + * Based on RBTX49xx patch from CELF patch archive.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + *
> + * (C) Copyright TOSHIBA CORPORATION 2005-2007
> + */
> +#include <linux/rtc.h>
> +#include <linux/platform_device.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <asm/txx9/tx4939.h>
> +
> +struct tx4939rtc_plat_data {
> +	struct rtc_device *rtc;
> +	struct tx4939_rtc_reg __iomem *rtcreg;
> +	spinlock_t lock;
> +};

 is the additional lock necessary?


> +atic struct tx4939rtc_plat_data *get_tx4939rtc_plat_data(struct device *dev)
> +{
> +	return platform_get_drvdata(to_platform_device(dev));
> +}
> +
> +static int tx4939_rtc_cmd(struct tx4939_rtc_reg __iomem *rtcreg, int cmd)
> +{
> +	int i = 0;
> +
> +	__raw_writel(cmd, &rtcreg->ctl);
> +	/* This might take 30us (next 32.768KHz clock) */
> +	while (__raw_readl(&rtcreg->ctl) & TX4939_RTCCTL_BUSY) {
> +		/* timeout on approx. 100us (@ GBUS200MHz) */
> +		if (i++ > 200 * 100)
> +			return -EBUSY;
> +		cpu_relax();
> +	}
> +	return 0;
> +}
> +
> +static int tx4939_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
> +	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
> +	int i, ret;
> +	unsigned long sec;
> +	unsigned char buf[6];
> +
> +	rtc_tm_to_time(tm, &sec);
> +	buf[0] = 0;
> +	buf[1] = 0;
> +	buf[2] = sec;
> +	buf[3] = sec >> 8;
> +	buf[4] = sec >> 16;
> +	buf[5] = sec >> 24;
> +	spin_lock_irq(&pdata->lock);
> +	__raw_writel(0, &rtcreg->adr);
> +	for (i = 0; i < 6; i++)
> +		__raw_writel(buf[i], &rtcreg->dat);
> +	ret = tx4939_rtc_cmd(rtcreg,
> +			     TX4939_RTCCTL_COMMAND_SETTIME |
> +			     (__raw_readl(&rtcreg->ctl) & TX4939_RTCCTL_ALME));
> +	spin_unlock_irq(&pdata->lock);
> +	return ret;
> +}

 it would be better to implement set_mmss instead of set_time


> +
> +static int tx4939_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
> +	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
> +	int i, ret;
> +	unsigned long sec;
> +	unsigned char buf[6];
> +
> +	spin_lock_irq(&pdata->lock);
> +	ret = tx4939_rtc_cmd(rtcreg,
> +			     TX4939_RTCCTL_COMMAND_GETTIME |
> +			     (__raw_readl(&rtcreg->ctl) & TX4939_RTCCTL_ALME));
> +	if (ret) {
> +		spin_unlock_irq(&pdata->lock);
> +		return ret;
> +	}
> +	__raw_writel(2, &rtcreg->adr);
> +	for (i = 2; i < 6; i++)
> +		buf[i] = __raw_readl(&rtcreg->dat);
> +	spin_unlock_irq(&pdata->lock);
> +	sec = (buf[5] << 24) | (buf[4] << 16) | (buf[3] << 8) | buf[2];
> +	rtc_time_to_tm(sec, tm);
> +	return 0;

 this shouldn't lead to problems but an return rtc_valid_tm would be preferable


> +}
> +
> +static int tx4939_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
> +	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
> +	int i, ret;
> +	unsigned long sec;
> +	unsigned char buf[6];
> +
> +	if (alrm->time.tm_sec < 0 ||
> +	    alrm->time.tm_min < 0 ||
> +	    alrm->time.tm_hour < 0 ||
> +	    alrm->time.tm_mday < 0 ||
> +	    alrm->time.tm_mon < 0 ||
> +	    alrm->time.tm_year < 0)
> +		return -EINVAL;
> +	rtc_tm_to_time(&alrm->time, &sec);
> +	buf[0] = 0;
> +	buf[1] = 0;
> +	buf[2] = sec;
> +	buf[3] = sec >> 8;
> +	buf[4] = sec >> 16;
> +	buf[5] = sec >> 24;
> +	spin_lock_irq(&pdata->lock);
> +	__raw_writel(0, &rtcreg->adr);
> +	for (i = 0; i < 6; i++)
> +		__raw_writel(buf[i], &rtcreg->dat);
> +	ret = tx4939_rtc_cmd(rtcreg, TX4939_RTCCTL_COMMAND_SETALARM |
> +			     (alrm->enabled ? TX4939_RTCCTL_ALME : 0));
> +	spin_unlock_irq(&pdata->lock);
> +	return ret;
> +}
> +
> +static int tx4939_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> +{
> +	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
> +	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
> +	int i, ret;
> +	unsigned long sec;
> +	unsigned char buf[6];
> +	u32 ctl;
> +
> +	spin_lock_irq(&pdata->lock);
> +	ret = tx4939_rtc_cmd(rtcreg,
> +			     TX4939_RTCCTL_COMMAND_GETALARM |
> +			     (__raw_readl(&rtcreg->ctl) & TX4939_RTCCTL_ALME));
> +	if (ret) {
> +		spin_unlock_irq(&pdata->lock);
> +		return ret;
> +	}
> +	__raw_writel(2, &rtcreg->adr);
> +	for (i = 2; i < 6; i++)
> +		buf[i] = __raw_readl(&rtcreg->dat);
> +	ctl = __raw_readl(&rtcreg->ctl);
> +	alrm->enabled = (ctl & TX4939_RTCCTL_ALME) ? 1 : 0;
> +	alrm->pending = (ctl & TX4939_RTCCTL_ALMD) ? 1 : 0;
> +	spin_unlock_irq(&pdata->lock);
> +	sec = (buf[5] << 24) | (buf[4] << 16) | (buf[3] << 8) | buf[2];
> +	rtc_time_to_tm(sec, &alrm->time);
> +	return 0;
> +}
> +
> +static irqreturn_t tx4939_rtc_interrupt(int irq, void *dev_id)
> +{
> +	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev_id);
> +	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
> +	unsigned long events = RTC_IRQF;
> +
> +	spin_lock(&pdata->lock);
> +	if (__raw_readl(&rtcreg->ctl) & TX4939_RTCCTL_ALMD) {
> +		events |= RTC_AF;
> +		tx4939_rtc_cmd(rtcreg, TX4939_RTCCTL_COMMAND_NOP);
> +	}
> +	spin_unlock(&pdata->lock);
> +	rtc_update_irq(pdata->rtc, 1, events);
> +	return IRQ_HANDLED;
> +}
> +
> +static int tx4939_rtc_ioctl(struct device *dev,
> +			    unsigned int cmd, unsigned long arg)
> +{
> +	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
> +	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
> +	struct rtc_time tm;
> +	struct rtc_wkalrm alarm;
> +	void __user *uarg = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case RTC_ALM_SET:
> +		if (copy_from_user(&alarm.time, uarg, sizeof(tm)))
> +			return -EFAULT;
> +		alarm.enabled = 0;
> +		alarm.pending = 0;
> +		/* keep all date/time in alarm.time */
> +		return rtc_set_alarm(pdata->rtc, &alarm);

 the rtc subsystem maps ALM_SET to set_alarm, you don't need it.


> +	case RTC_AIE_OFF:
> +		spin_lock_irq(&pdata->lock);
> +		tx4939_rtc_cmd(rtcreg, TX4939_RTCCTL_COMMAND_NOP);
> +		spin_unlock_irq(&pdata->lock);
> +		break;
> +	case RTC_AIE_ON:
> +		spin_lock_irq(&pdata->lock);
> +		tx4939_rtc_cmd(rtcreg, TX4939_RTCCTL_COMMAND_NOP |
> +			       TX4939_RTCCTL_ALME);
> +		spin_unlock_irq(&pdata->lock);
> +		break;

 AIE_ON an OFF are mapped to alarm_irq_enable, please see the latest patches
 on the rtc mailing list or here http://patchwork.ozlabs.org/patch/9676/


> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops tx4939_rtc_ops = {
> +	.read_time	= tx4939_rtc_read_time,
> +	.set_time	= tx4939_rtc_set_time,
> +	.read_alarm	= tx4939_rtc_read_alarm,
> +	.set_alarm	= tx4939_rtc_set_alarm,
> +	.ioctl		= tx4939_rtc_ioctl,
> +};
> +
> +static ssize_t tx4939_rtc_nvram_read(struct kobject *kobj,
> +				     struct bin_attribute *bin_attr,
> +				     char *buf, loff_t pos, size_t size)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
> +	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
> +	ssize_t count;
> +
> +	spin_lock_irq(&pdata->lock);
> +	for (count = 0; size > 0 && pos < TX4939_RTC_REG_RAMSIZE;
> +	     count++, size--) {
> +		__raw_writel(pos++, &rtcreg->adr);
> +		*buf++ = __raw_readl(&rtcreg->dat);
> +	}
> +	spin_unlock_irq(&pdata->lock);
> +	return count;
> +}
> +
> +static ssize_t tx4939_rtc_nvram_write(struct kobject *kobj,
> +				      struct bin_attribute *bin_attr,
> +				      char *buf, loff_t pos, size_t size)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct tx4939rtc_plat_data *pdata = get_tx4939rtc_plat_data(dev);
> +	struct tx4939_rtc_reg __iomem *rtcreg = pdata->rtcreg;
> +	ssize_t count;
> +
> +	spin_lock_irq(&pdata->lock);
> +	for (count = 0; size > 0 && pos < TX4939_RTC_REG_RAMSIZE;
> +	     count++, size--) {
> +		__raw_writel(pos++, &rtcreg->adr);
> +		__raw_writel(*buf++, &rtcreg->dat);
> +	}
> +	spin_unlock_irq(&pdata->lock);
> +	return count;
> +}
> +
> +static struct bin_attribute tx4939_rtc_nvram_attr = {
> +	.attr = {
> +		.name = "nvram",
> +		.mode = S_IRUGO | S_IWUSR,
> +	},
> +	.size = TX4939_RTC_REG_RAMSIZE,
> +	.read = tx4939_rtc_nvram_read,
> +	.write = tx4939_rtc_nvram_write,
> +};
> +
> +static int __init tx4939_rtc_probe(struct platform_device *pdev)
> +{
> +	struct rtc_device *rtc;
> +	struct tx4939rtc_plat_data *pdata;
> +	struct resource *res;
> +	int irq, ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -ENODEV;
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	if (!devm_request_mem_region(&pdev->dev, res->start,
> +				     res->end - res->start + 1, pdev->name))
> +		return -EBUSY;

 use resource_size()

> +	pdata->rtcreg = devm_ioremap(&pdev->dev, res->start,
> +				     res->end - res->start + 1);
> +	if (!pdata->rtcreg)
> +		return -EBUSY;
> +
> +	spin_lock_init(&pdata->lock);
> +	tx4939_rtc_cmd(pdata->rtcreg, TX4939_RTCCTL_COMMAND_NOP);
> +	if (devm_request_irq(&pdev->dev, irq, tx4939_rtc_interrupt,
> +			     IRQF_DISABLED | IRQF_SHARED,
> +			     pdev->name, &pdev->dev) < 0)
> +		return -EBUSY;
> +	rtc = rtc_device_register(pdev->name, &pdev->dev,
> +				  &tx4939_rtc_ops, THIS_MODULE);
> +	if (IS_ERR(rtc))
> +		return PTR_ERR(rtc);

> +	pdata->rtc = rtc;
> +	platform_set_drvdata(pdev, pdata);

 it's better to set those pointers as early as possible 


> +	ret = sysfs_create_bin_file(&pdev->dev.kobj, &tx4939_rtc_nvram_attr);
> +	if (ret)
> +		rtc_device_unregister(rtc);
> +	return ret;
> +}
> +
> +static int __exit tx4939_rtc_remove(struct platform_device *pdev)
> +{
> +	struct tx4939rtc_plat_data *pdata = platform_get_drvdata(pdev);
> +	struct rtc_device *rtc = pdata->rtc;
> +
> +	sysfs_remove_bin_file(&pdev->dev.kobj, &tx4939_rtc_nvram_attr);
> +	rtc_device_unregister(rtc);
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}
> +
> +static struct platform_driver tx4939_rtc_driver = {
> +	.remove		= __exit_p(tx4939_rtc_remove),
> +	.driver		= {
> +		.name	= "tx4939rtc",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init tx4939rtc_init(void)
> +{
> +	return platform_driver_probe(&tx4939_rtc_driver, tx4939_rtc_probe);
> +}
> +
> +static void __exit tx4939rtc_exit(void)
> +{
> +	platform_driver_unregister(&tx4939_rtc_driver);
> +}
> +
> +module_init(tx4939rtc_init);
> +module_exit(tx4939rtc_exit);
> +
> +MODULE_DESCRIPTION("TX4939 internal RTC driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:tx4939rtc");

 MODULE_AUTHOR please

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
