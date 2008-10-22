Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2008 08:31:24 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:54167 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S22074419AbYJVHbU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Oct 2008 08:31:20 +0100
Received: (qmail 11270 invoked by uid 1000); 22 Oct 2008 09:31:14 +0200
Date:	Wed, 22 Oct 2008 09:31:14 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Alessandro Zummo <alessandro.zummo@towertech.it>
Cc:	rtc-linux@googlegroups.com, Linux-MIPS <linux-mips@linux-mips.org>,
	Kevin Hickey <khickey@rmicorp.com>
Subject: Re: [rtc-linux] [RFC PATCH] Au1xxx on-chip counter-as-RTC driver
Message-ID: <20081022073114.GA11169@roarinelk.homelinux.net>
References: <20080809161402.15e24b2e@flagship.roarinelk.net> <20081021203815.1a0a246d@i1501.lan.towertech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081021203815.1a0a246d@i1501.lan.towertech.it>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hi Alessandro,

On Tue, Oct 21, 2008 at 08:38:15PM +0200, Alessandro Zummo wrote:
> On Sat, 9 Aug 2008 16:14:02 +0200
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
> > It works so far on the DB1200 board; however it takes up
> > to 5 seconds until the written value actually hits the
> > register, so the hardware clock is always off (the minimum
> > seems to be 3 seconds on the DB1200).  I'd like to get
> > some feedback on how to work around this "anomaly".
> 
>  Hi Manuel,
> 
>   any news on this driver? I'd need feedback from linux-mips
>  to get it thru.

Here's a slightly updated version which has been running on a DB1200
demoboard for almost 2 months now.  I received no feedback on the
original, unfortunately.

Thanks!
	Manuel Lauss

--- 
From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Sat, 9 Aug 2008 15:27:55 +0200
Subject: [PATCH] RTC: Au1000 On-Chip Counter0-as-RTC driver.

Simple driver which uses the Au1xxx Time-Of-Year counter (counter0)
as a 1Hz RTC.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/pb1200/platform.c |    6 +
 drivers/rtc/Kconfig                 |    9 ++
 drivers/rtc/Makefile                |    1 +
 drivers/rtc/rtc-au1xxx.c            |  189 +++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-au1xxx.c

diff --git a/arch/mips/alchemy/pb1200/platform.c b/arch/mips/alchemy/pb1200/platform.c
index f8fb0ae..8f3bc98 100644
--- a/arch/mips/alchemy/pb1200/platform.c
+++ b/arch/mips/alchemy/pb1200/platform.c
@@ -71,7 +71,13 @@ static struct platform_device smc91c111_device = {
 	.resource	= smc91c111_resources
 };
 
+static struct platform_device rtc_device = {
+	.name	= "rtc-au1xxx",
+	.id	= -1,
+};
+
 static struct platform_device *board_platform_devices[] __initdata = {
+	&rtc_device,
 	&ide_device,
 	&smc91c111_device
 };
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 814f49f..0a7aac4 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -594,6 +594,15 @@ config RTC_DRV_AT91SAM9_GPBR
 	  will be used.  The default of zero is normally OK to use, but
 	  on some systems other software needs to use that register.
 
+config RTC_DRV_AU1XXX
+	tristate "Au1xxx TOY-as-RTC support"
+	depends on SOC_AU1X00
+	help
+	  This driver uses Au1000 on-chip Counter0 as a Real Time Clock.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-au1xxx.
+
 config RTC_DRV_BFIN
 	tristate "Blackfin On-Chip RTC"
 	depends on BLACKFIN && !BF561
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index d6a9ac7..796a179 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -20,6 +20,7 @@ rtc-core-$(CONFIG_RTC_INTF_SYSFS) += rtc-sysfs.o
 obj-$(CONFIG_RTC_DRV_AT32AP700X)+= rtc-at32ap700x.o
 obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
 obj-$(CONFIG_RTC_DRV_AT91SAM9)	+= rtc-at91sam9.o
+obj-$(CONFIG_RTC_DRV_AU1XXX)	+= rtc-au1xxx.o
 obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
 obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_DS1216)	+= rtc-ds1216.o
diff --git a/drivers/rtc/rtc-au1xxx.c b/drivers/rtc/rtc-au1xxx.c
new file mode 100644
index 0000000..fb05eec
--- /dev/null
+++ b/drivers/rtc/rtc-au1xxx.c
@@ -0,0 +1,189 @@
+/*
+ * Au1xxx counter0 (aka Time-of-year counter) RTC interface driver.
+ *
+ * Copyright (C) 2008 Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+/* All current Au1xxx SoCs have 2 counters fed by an external 32.768 kHz
+ * crystal. Counter 0, which keeps counting during sleep/powerdown, is
+ * used to count seconds since the beginning of the unix epoch.
+ *
+ * The counters must be configured and enabled by bootloader/board code;
+ * no checks as to whether they really get a proper 32.768kHz clock are
+ * made.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/rtc.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <asm/mach-au1x00/au1000.h>
+
+/* 32kHz clock enabled and detected */
+#define CNTR_OK (SYS_CNTRL_E0 | SYS_CNTRL_32S)
+
+struct au1xtoy_rtc {
+	struct rtc_device *rtc_dev;
+	struct mutex toycnt_lock;
+};
+
+static int au1xtoy_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct au1xtoy_rtc *rtc = platform_get_drvdata(pdev);
+	unsigned long t;
+
+	if (mutex_lock_interruptible(&rtc->toycnt_lock))
+		return -ERESTARTSYS;
+
+	t = au_readl(SYS_TOYREAD);
+	mutex_unlock(&rtc->toycnt_lock);
+
+	rtc_time_to_tm(t, tm);
+
+	if (rtc_valid_tm(tm) < 0) {
+		dev_err(dev, "invalid date stored in counter0\n");
+		rtc_time_to_tm(0, tm);
+	}
+
+	return 0;
+}
+
+static int au1xtoy_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct au1xtoy_rtc *rtc = platform_get_drvdata(pdev);
+	unsigned long t;
+
+	rtc_tm_to_time(tm, &t);
+
+	if (mutex_lock_interruptible(&rtc->toycnt_lock))
+		return -ERESTARTSYS;
+
+	au_writel(t, SYS_TOYWRITE);
+	au_sync();
+
+	/* wait for the pending register write to succeed.  This can
+	 * take up to 6 seconds...
+	 */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
+		schedule();
+
+	mutex_unlock(&rtc->toycnt_lock);
+
+	return 0;
+}
+
+static struct rtc_class_ops au1xtoy_rtc_ops = {
+	.read_time	= au1xtoy_rtc_read_time,
+	.set_time	= au1xtoy_rtc_set_time,
+};
+
+static int __devinit au1xtoy_rtc_probe(struct platform_device *pdev)
+{
+	struct au1xtoy_rtc *rtc;
+	unsigned long u, to;
+	int ret;
+
+	rtc = kzalloc(sizeof(struct au1xtoy_rtc), GFP_KERNEL);
+	if (unlikely(!rtc))
+		return -ENOMEM;
+
+	mutex_init(&rtc->toycnt_lock);
+
+	u = au_readl(SYS_COUNTER_CNTRL);
+	if (!(u & CNTR_OK)) {
+		dev_err(&pdev->dev, "counters not working; aborting.\n");
+		ret = -ENODEV;
+		goto out_err;
+	}
+
+	ret = -ETIMEDOUT;
+
+	/* set counter0 tickrate to 1Hz if necessary */
+	if (au_readl(SYS_TOYTRIM) != 32767) {
+		/* wait until hardware gives access to TRIM register */
+		to = 0x00100000;
+		while ((au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_T0S) && to--)
+			schedule();
+
+		if (!to) {
+			/* timed out waiting for register access; assume
+			 * counters are unusable.
+			 */
+			dev_err(&pdev->dev, "timeout waiting for access\n");
+			goto out_err;
+		}
+
+		/* set 1Hz TOY tick rate */
+		au_writel(32767, SYS_TOYTRIM);
+		au_sync();
+	}
+
+	/* wait until the hardware allows writes to the counter reg */
+	while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C0S)
+		schedule();
+
+	rtc->rtc_dev = rtc_device_register("rtc-au1xxx", &pdev->dev,
+					   &au1xtoy_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtc_dev)) {
+		ret = PTR_ERR(rtc->rtc_dev);
+		goto out_err;
+	}
+
+	platform_set_drvdata(pdev, rtc);
+
+	return 0;
+
+out_err:
+	kfree(rtc);
+	return ret;
+}
+
+static int __devexit au1xtoy_rtc_remove(struct platform_device *pdev)
+{
+	struct au1xtoy_rtc *rtc = platform_get_drvdata(pdev);
+
+	if (likely(rtc->rtc_dev))
+		rtc_device_unregister(rtc->rtc_dev);
+
+	platform_set_drvdata(pdev, NULL);
+
+	kfree(rtc);
+
+	return 0;
+}
+
+static struct platform_driver au1xtoy_rtc_platform_driver = {
+	.driver		= {
+		.name	= "rtc-au1xxx",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= au1xtoy_rtc_probe,
+	.remove		= __devexit_p(au1xtoy_rtc_remove),
+};
+
+static int __init au1xtoy_rtc_init(void)
+{
+	return platform_driver_register(&au1xtoy_rtc_platform_driver);
+}
+
+static void __exit au1xtoy_rtc_exit(void)
+{
+	platform_driver_unregister(&au1xtoy_rtc_platform_driver);
+}
+
+module_init(au1xtoy_rtc_init);
+module_exit(au1xtoy_rtc_exit);
+
+MODULE_DESCRIPTION("Au1xxx TOY-counter-based RTC driver");
+MODULE_AUTHOR("Manuel Lauss");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:rtc-au1xxx");
-- 
1.6.0.2
