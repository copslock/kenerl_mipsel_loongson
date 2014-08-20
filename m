Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 23:35:45 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:61138 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006152AbaHVVfloDxNn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 23:35:41 +0200
Received: by mail-wi0-f175.google.com with SMTP id ho1so259157wib.14
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pjc4KmMNS4Xze+gHAWprE0ZR4ajQpbv180xUV0tDpeM=;
        b=ugOCuBJT/ohGDAtLCqZ+8W9USec2wIC2oibjFb8dQxsxIz0wQm+UTkFoCyiVLcRQhb
         DyuWI7m0TEDdzZSqn6lgcZ7/ZPeoSTNVstSiUJZlqNM+pgV9K+1EE1D5o+ldwmh4VM5N
         KNgVMPdV8DCH0h2fmifqY5w56EoBPGOXkRpCqDDJOI581a2eGZZdR8KujHbNPh/qSOBv
         aIzg5ctrywI+uB9U6Pi+I8sGycboZwscIh1miNKTZg7BgUB5WWXzeJu254fg4uVmIl49
         woReyMT2VGawwNqrDLEkLunkWR/ucbZFtNQYDnQbrv83D7O7qZjdYJUZz4VaQN35FQoB
         L3CQ==
X-Received: by 10.180.187.20 with SMTP id fo20mr10250502wic.58.1408563414348;
        Wed, 20 Aug 2014 12:36:54 -0700 (PDT)
Received: from localhost.localdomain (p4FD8DBDE.dip0.t-ipconnect.de. [79.216.219.222])
        by mx.google.com with ESMTPSA id vn10sm60779177wjc.28.2014.08.20.12.36.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Aug 2014 12:36:53 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 4/4] MIPS: Alchemy: db1300: add touch penirq support
Date:   Wed, 20 Aug 2014 21:36:33 +0200
Message-Id: <1408563393-132515-5-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1408563393-132515-1-git-send-email-manuel.lauss@gmail.com>
References: <1408563393-132515-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

wire up the WM9713 pendown irq support.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/devboards/db1300.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index e476ae9..1c64fdb 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -21,6 +21,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
+#include <linux/wm97xx.h>
 
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
@@ -711,6 +712,46 @@ static struct platform_device db1300_lcd_dev = {
 
 /**********************************************************************/
 
+static void db1300_wm97xx_irqen(struct wm97xx *wm, int enable)
+{
+	if (enable)
+		enable_irq(DB1300_AC97_PEN_INT);
+	else
+		disable_irq_nosync(DB1300_AC97_PEN_INT);
+}
+
+static struct wm97xx_mach_ops db1300_wm97xx_ops = {
+	.irq_enable	= db1300_wm97xx_irqen,
+	.irq_gpio	= WM97XX_GPIO_3,
+};
+
+static int db1300_wm97xx_probe(struct platform_device *pdev)
+{
+	struct wm97xx *wm = platform_get_drvdata(pdev);
+
+	/* external pendown indicator */
+	wm97xx_config_gpio(wm, WM97XX_GPIO_13, WM97XX_GPIO_IN,
+			   WM97XX_GPIO_POL_LOW, WM97XX_GPIO_STICKY,
+			   WM97XX_GPIO_WAKE);
+
+	/* internal "virtual" pendown gpio */
+	wm97xx_config_gpio(wm, WM97XX_GPIO_3, WM97XX_GPIO_OUT,
+			   WM97XX_GPIO_POL_LOW, WM97XX_GPIO_NOTSTICKY,
+			   WM97XX_GPIO_NOWAKE);
+
+	wm->pen_irq = DB1300_AC97_PEN_INT;
+
+	return wm97xx_register_mach_ops(wm, &db1300_wm97xx_ops);
+}
+
+static struct platform_driver db1300_wm97xx_driver = {
+	.driver.name	= "wm97xx-touch",
+	.driver.owner	= THIS_MODULE,
+	.probe		= db1300_wm97xx_probe,
+};
+
+/**********************************************************************/
+
 static struct platform_device *db1300_dev[] __initdata = {
 	&db1300_eth_dev,
 	&db1300_i2c_dev,
@@ -755,6 +796,9 @@ int __init db1300_dev_setup(void)
 	i2c_register_board_info(0, db1300_i2c_devs,
 				ARRAY_SIZE(db1300_i2c_devs));
 
+	if (platform_driver_register(&db1300_wm97xx_driver))
+		pr_warn("DB1300: failed to init touch pen irq support!\n");
+
 	/* Audio PSC clock is supplied by codecs (PSC1, 2) */
 	__raw_writel(PSC_SEL_CLK_SERCLK,
 	    (void __iomem *)KSEG1ADDR(AU1300_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
-- 
2.0.4
