Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jun 2010 19:27:02 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:63853 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491995Ab0FER0z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jun 2010 19:26:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id E294E395;
        Sat,  5 Jun 2010 19:26:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id XTnpyaXX2PwF; Sat,  5 Jun 2010 19:26:49 +0200 (CEST)
Received: from [192.168.37.30] (port-11083.pppoe.wtnet.de [84.46.43.118])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 6C8C5393;
        Sat,  5 Jun 2010 19:26:39 +0200 (CEST)
Message-ID: <4C0A88B0.4060107@metafoo.de>
Date:   Sat, 05 Jun 2010 19:26:08 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Wan ZongShun <mcuos.com@gmail.com>
CC:     rtc-linux@googlegroups.com, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: Re: [rtc-linux] [RFC][PATCH 15/26] RTC: Add JZ4740 RTC driver
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>        <1275505832-17185-7-git-send-email-lars@metafoo.de> <AANLkTilyeoul7MEs0Q-tlHLdVHBQg6QIuucvy2UH2nkF@mail.gmail.com>
In-Reply-To: <AANLkTilyeoul7MEs0Q-tlHLdVHBQg6QIuucvy2UH2nkF@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 27076
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 3915

Hi

Wan ZongShun wrote:
> 2010/6/3 Lars-Peter Clausen <lars@metafoo.de>:
>   
>> This patch adds support for the RTC unit on JZ4740 SoCs.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Paul Gortmaker <p_gortmaker@yahoo.com>
>> Cc: rtc-linux@googlegroups.com
>> ---
>>  drivers/rtc/Kconfig      |   11 ++
>>  drivers/rtc/Makefile     |    1 +
>>  drivers/rtc/rtc-jz4740.c |  344 ++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 356 insertions(+), 0 deletions(-)
>>  create mode 100644 drivers/rtc/rtc-jz4740.c
>>
>> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
>> index 10ba12c..d0ed7e6 100644
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -905,4 +905,15 @@ config RTC_DRV_MPC5121
>>          This driver can also be built as a module. If so, the module
>>          will be called rtc-mpc5121.
>>
>> +config RTC_DRV_JZ4740
>> +       tristate "Ingenic JZ4740 SoC"
>> +       depends on RTC_CLASS
>> +       depends on MACH_JZ4740
>> +       help
>> +         If you say yes here you get support for the Ingenic JZ4740 SoC RTC
>> +         controller.
>> +
>> +         This driver can also be buillt as a module. If so, the module
>> +         will be called rtc-jz4740.
>> +
>>  endif # RTC_CLASS
>> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
>> index 5adbba7..fedf9bb 100644
>> --- a/drivers/rtc/Makefile
>> +++ b/drivers/rtc/Makefile
>> @@ -47,6 +47,7 @@ obj-$(CONFIG_RTC_DRV_EP93XX)  += rtc-ep93xx.o
>>  obj-$(CONFIG_RTC_DRV_FM3130)   += rtc-fm3130.o
>>  obj-$(CONFIG_RTC_DRV_GENERIC)  += rtc-generic.o
>>  obj-$(CONFIG_RTC_DRV_ISL1208)  += rtc-isl1208.o
>> +obj-$(CONFIG_RTC_DRV_JZ4740)   += rtc-jz4740.o
>>  obj-$(CONFIG_RTC_DRV_M41T80)   += rtc-m41t80.o
>>  obj-$(CONFIG_RTC_DRV_M41T94)   += rtc-m41t94.o
>>  obj-$(CONFIG_RTC_DRV_M48T35)   += rtc-m48t35.o
>> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
>> new file mode 100644
>> index 0000000..41ab78f
>> --- /dev/null
>> +++ b/drivers/rtc/rtc-jz4740.c
>> @@ -0,0 +1,344 @@
>> +/*
>> + *  Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
>> + *             JZ4740 SoC RTC driver
>> + *
>> + *  This program is free software; you can redistribute         it and/or modify it
>> + *  under  the terms of         the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the License, or (at your
>> + *  option) any later version.
>> + *
>> + *  You should have received a copy of the  GNU General Public License along
>> + *  with this program; if not, write  to the Free Software Foundation, Inc.,
>> + *  675 Mass Ave, Cambridge, MA 02139, USA.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/rtc.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +
>> +#define JZ_REG_RTC_CTRL                0x00
>> +#define JZ_REG_RTC_SEC         0x04
>> +#define JZ_REG_RTC_SEC_ALARM   0x08
>> +#define JZ_REG_RTC_REGULATOR   0x0C
>> +#define JZ_REG_RTC_HIBERNATE   0x20
>> +#define JZ_REG_RTC_SCRATCHPAD  0x34
>> +
>> +#define JZ_RTC_CTRL_WRDY       BIT(7)
>> +#define JZ_RTC_CTRL_1HZ                BIT(6)
>> +#define JZ_RTC_CTRL_1HZ_IRQ    BIT(5)
>> +#define JZ_RTC_CTRL_AF         BIT(4)
>> +#define JZ_RTC_CTRL_AF_IRQ     BIT(3)
>> +#define JZ_RTC_CTRL_AE         BIT(2)
>> +#define JZ_RTC_CTRL_ENABLE     BIT(0)
>> +
>> +struct jz4740_rtc {
>> +       struct resource *mem;
>> +       void __iomem *base;
>> +
>> +       struct rtc_device *rtc;
>> +
>> +       unsigned int irq;
>> +
>> +       spinlock_t lock;
>> +};
>> +
>> +static inline uint32_t jz4740_rtc_reg_read(struct jz4740_rtc *rtc, size_t reg)
>> +{
>> +       return readl(rtc->base + reg);
>> +}
>> +
>> +static inline void jz4740_rtc_wait_write_ready(struct jz4740_rtc *rtc)
>> +{
>> +       uint32_t ctrl;
>> +       do {
>> +               ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
>> +       } while (!(ctrl & JZ_RTC_CTRL_WRDY));
>> +}
>> +
>> +
>> +static inline void jz4740_rtc_reg_write(struct jz4740_rtc *rtc, size_t reg,
>> +                                       uint32_t val)
>> +{
>> +       jz4740_rtc_wait_write_ready(rtc);
>> +       writel(val, rtc->base + reg);
>> +}
>> +
>> +static void jz4740_rtc_ctrl_set_bits(struct jz4740_rtc *rtc, uint32_t mask,
>> +                                       uint32_t val)
>> +{
>> +       unsigned long flags;
>> +       uint32_t ctrl;
>> +
>> +       spin_lock_irqsave(&rtc->lock, flags);
>> +
>> +       ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
>> +
>> +       /* Don't clear interrupt flags by accident */
>> +       ctrl |= JZ_RTC_CTRL_1HZ | JZ_RTC_CTRL_AF;
>> +
>> +       ctrl &= ~mask;
>> +       ctrl |= val;
>> +
>> +       jz4740_rtc_reg_write(rtc, JZ_REG_RTC_CTRL, ctrl);
>> +
>> +       spin_unlock_irqrestore(&rtc->lock, flags);
>> +}
>> +
>> +static inline struct jz4740_rtc *dev_to_rtc(struct device *dev)
>> +{
>> +       return dev_get_drvdata(dev);
>> +}
>> +
>>     
>
> Why do you need to re-implement the 'dev_to_rtc' instead of using
> 'platform_get_drvdata' provided by Linux own.'
>   
I like to write self documenting code, so this documents how to get the
a pointer to the jz4740_rtc struct if you only have device. But I guess
in this case it's safe to use dev_get_drvdata directly from within the
other of the drivers functions without loosing to much.
>> +static int jz4740_rtc_read_time(struct device *dev, struct rtc_time *time)
>> +{
>> +       struct jz4740_rtc *rtc = dev_to_rtc(dev);
>> +       uint32_t secs, secs2;
>> +
>> +       secs = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC);
>> +       secs2 = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC);
>> +
>> +       while (secs != secs2) {
>> +               secs = secs2;
>> +               secs2 = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC);
>> +       }
>> +
>> +       rtc_time_to_tm(secs, time);
>> +
>> +       return rtc_valid_tm(time);
>> +}
>> +
>> +static int jz4740_rtc_set_mmss(struct device *dev, unsigned long secs)
>> +{
>> +       struct jz4740_rtc *rtc = dev_to_rtc(dev);
>> +
>> +       if ((uint32_t)secs != secs)
>> +               return -EINVAL;
>> +
>> +       jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC, secs);
>> +
>> +       return 0;
>> +}
>> +
>> +static int jz4740_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +       struct jz4740_rtc *rtc = dev_to_rtc(dev);
>> +       uint32_t secs, secs2;
>> +       uint32_t ctrl;
>> +
>> +       secs = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC_ALARM);
>> +       secs2 = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC_ALARM);
>> +
>> +       while (secs != secs2) {
>> +               secs = secs2;
>> +               secs2 = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SEC_ALARM);
>> +       }
>> +
>> +       ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
>> +
>> +       alrm->enabled = !!(ctrl & JZ_RTC_CTRL_AE);
>> +       alrm->pending = !!(ctrl & JZ_RTC_CTRL_AF);
>> +
>> +       rtc_time_to_tm(secs, &alrm->time);
>> +
>> +       return rtc_valid_tm(&alrm->time);
>> +}
>> +
>> +static int jz4740_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>> +{
>> +       struct jz4740_rtc *rtc = dev_to_rtc(dev);
>> +       unsigned long secs;
>> +
>> +       rtc_tm_to_time(&alrm->time, &secs);
>> +
>> +       if ((uint32_t)secs != secs)
>> +               return -EINVAL;
>> +
>> +       jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC_ALARM, (uint32_t)secs);
>> +       jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_AE,
>> +                                       alrm->enabled ? JZ_RTC_CTRL_AE : 0);
>> +
>> +       return 0;
>> +}
>> +
>> +static int jz4740_rtc_update_irq_enable(struct device *dev, unsigned int enable)
>> +{
>> +       struct jz4740_rtc *rtc = dev_to_rtc(dev);
>> +       jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_1HZ_IRQ,
>> +                                       enable ? JZ_RTC_CTRL_1HZ_IRQ : 0);
>> +       return 0;
>> +}
>> +
>> +
>> +static int jz4740_rtc_alarm_irq_enable(struct device *dev, unsigned int enable)
>> +{
>> +       struct jz4740_rtc *rtc = dev_to_rtc(dev);
>> +       jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_AF_IRQ,
>> +                                       enable ? JZ_RTC_CTRL_AF_IRQ : 0);
>> +       return 0;
>> +}
>> +
>> +static struct rtc_class_ops jz4740_rtc_ops = {
>> +       .read_time      = jz4740_rtc_read_time,
>> +       .set_mmss       = jz4740_rtc_set_mmss,
>> +       .read_alarm     = jz4740_rtc_read_alarm,
>> +       .set_alarm      = jz4740_rtc_set_alarm,
>> +       .update_irq_enable = jz4740_rtc_update_irq_enable,
>> +       .alarm_irq_enable = jz4740_rtc_alarm_irq_enable,
>> +};
>> +
>> +static irqreturn_t jz4740_rtc_irq(int irq, void *data)
>> +{
>> +       struct jz4740_rtc *rtc = data;
>> +       uint32_t ctrl;
>> +       unsigned long events = 0;
>> +       ctrl = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_CTRL);
>> +
>> +       if (ctrl & JZ_RTC_CTRL_1HZ)
>> +               events |= (RTC_UF | RTC_IRQF);
>> +
>> +       if (ctrl & JZ_RTC_CTRL_AF)
>> +               events |= (RTC_AF | RTC_IRQF);
>> +
>> +       rtc_update_irq(rtc->rtc, 1, events);
>> +
>> +       jz4740_rtc_ctrl_set_bits(rtc, JZ_RTC_CTRL_1HZ | JZ_RTC_CTRL_AF, 0);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +void jz4740_rtc_poweroff(struct device *dev)
>> +{
>> +       struct jz4740_rtc *rtc = dev_get_drvdata(dev);
>> +       jz4740_rtc_reg_write(rtc, JZ_REG_RTC_HIBERNATE, 1);
>> +}
>> +EXPORT_SYMBOL_GPL(jz4740_rtc_poweroff);
>> +
>> +static int __devinit jz4740_rtc_probe(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +       struct jz4740_rtc *rtc;
>> +       uint32_t scratchpad;
>> +
>> +       rtc = kmalloc(sizeof(*rtc), GFP_KERNEL);
>> +
>> +       rtc->irq = platform_get_irq(pdev, 0);
>> +
>> +       if (rtc->irq < 0) {
>> +               ret = -ENOENT;
>> +               dev_err(&pdev->dev, "Failed to get platform irq\n");
>> +               goto err_free;
>> +       }
>> +
>> +       rtc->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!rtc->mem) {
>> +               ret = -ENOENT;
>> +               dev_err(&pdev->dev, "Failed to get platform mmio memory\n");
>> +               goto err_free;
>> +       }
>> +
>> +       rtc->mem = request_mem_region(rtc->mem->start, resource_size(rtc->mem),
>> +                                       pdev->name);
>> +
>> +       if (!rtc->mem) {
>> +               ret = -EBUSY;
>> +               dev_err(&pdev->dev, "Failed to request mmio memory region\n");
>> +               goto err_free;
>> +       }
>> +
>> +       rtc->base = ioremap_nocache(rtc->mem->start, resource_size(rtc->mem));
>> +
>> +       if (!rtc->base) {
>> +               ret = -EBUSY;
>> +               dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
>> +               goto err_release_mem_region;
>> +       }
>> +
>> +       spin_lock_init(&rtc->lock);
>> +
>> +       platform_set_drvdata(pdev, rtc);
>> +
>> +       rtc->rtc = rtc_device_register(pdev->name, &pdev->dev, &jz4740_rtc_ops,
>> +                                       THIS_MODULE);
>> +
>> +       if (IS_ERR(rtc->rtc)) {
>> +               ret = PTR_ERR(rtc->rtc);
>> +               dev_err(&pdev->dev, "Failed to register rtc device: %d\n", ret);
>> +               goto err_iounmap;
>> +       }
>> +
>> +       ret = request_irq(rtc->irq, jz4740_rtc_irq, 0,
>> +                               pdev->name, rtc);
>> +
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "Failed to request rtc irq: %d\n", ret);
>> +               goto err_unregister_rtc;
>> +       }
>> +
>> +       scratchpad = jz4740_rtc_reg_read(rtc, JZ_REG_RTC_SCRATCHPAD);
>> +       if (scratchpad != 0x12345678) {
>> +               jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SCRATCHPAD, 0x12345678);
>> +               jz4740_rtc_reg_write(rtc, JZ_REG_RTC_SEC, 0);
>> +       }
>> +
>> +       return 0;
>> +
>> +err_unregister_rtc:
>> +       rtc_device_unregister(rtc->rtc);
>> +err_iounmap:
>> +       platform_set_drvdata(pdev, NULL);
>> +       iounmap(rtc->base);
>> +err_release_mem_region:
>> +       release_mem_region(rtc->mem->start, resource_size(rtc->mem));
>> +err_free:
>> +       kfree(rtc);
>> +
>> +       return ret;
>> +}
>> +
>> +static int __devexit jz4740_rtc_remove(struct platform_device *pdev)
>> +{
>> +       struct jz4740_rtc *rtc = platform_get_drvdata(pdev);
>> +
>> +       free_irq(rtc->irq, rtc);
>> +
>> +       rtc_device_unregister(rtc->rtc);
>> +
>> +       iounmap(rtc->base);
>> +       release_mem_region(rtc->mem->start, resource_size(rtc->mem));
>> +
>> +       kfree(rtc);
>> +
>> +       platform_set_drvdata(pdev, NULL);
>> +
>> +       return 0;
>> +}
>> +
>> +struct platform_driver jz4740_rtc_driver = {
>> +       .probe = jz4740_rtc_probe,
>> +       .remove = __devexit_p(jz4740_rtc_remove),
>> +       .driver = {
>> +               .name = "jz4740-rtc",
>> +               .owner = THIS_MODULE,
>> +       },
>> +};
>> +
>> +static int __init jz4740_rtc_init(void)
>> +{
>> +       return platform_driver_register(&jz4740_rtc_driver);
>>     
>
> platform_driver_probe is much better here.
>
>   
Ok.
>> +}
>> +module_init(jz4740_rtc_init);
>> +
>> +static void __exit jz4740_rtc_exit(void)
>> +{
>> +       platform_driver_unregister(&jz4740_rtc_driver);
>> +}
>> +module_exit(jz4740_rtc_exit);
>> +
>> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("RTC driver for the JZ4740 SoC\n");
>> +MODULE_ALIAS("platform:jz4740-rtc");
>> --
>> 1.5.6.5
>>
>> -
Thanks for reviewing the patch.

- Lars
