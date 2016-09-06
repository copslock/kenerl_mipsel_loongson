Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Sep 2016 04:11:52 +0200 (CEST)
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34636 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbcIFCLpfLNTq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Sep 2016 04:11:45 +0200
Received: by mail-pf0-f193.google.com with SMTP id g202so10589606pfb.1;
        Mon, 05 Sep 2016 19:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xG553scowsXM5pVjC4PRJL7kO3SVOVzlXhawAmfqMmM=;
        b=hKn31oObPeDJ1G+ykmBVknbIE+SKRaM0htsE4eTiFokn1p1W26uuYgWlPO5EnLWYlH
         jk1PhujSKywiFszH6X/iLzP/YwNLZZmXtWz0MJ++XNqm68oBGIQT+H6hMysC2PATVGO1
         yG2pEcEg0fFiAYmT3tFOfpT097x8cT82NUTawDHCY09pYZ/WZeM8D/T5dKxiy30Lbm3i
         cwywXC9XY3A/caiqDgW6I4MgTfxaeNJ5OUDQDcedBCLXwrOfBDlhygOol6CSlRzkye4f
         3yAwZQEmGwgrVOOjx0+Kct8lkEX48kDuaHTIPnh36h0W5gqZkIdhY7vetAHzThlhom48
         suMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xG553scowsXM5pVjC4PRJL7kO3SVOVzlXhawAmfqMmM=;
        b=F1WUJSLm8udc40R2l4LGJfVPxzLFcMUWFHgsUhYXj9P3Eu4CFrRiqv+/njW7Ql3Bvq
         nICeGOgy+nwM9zEEBIrOwA2l3gwy8NVY51gjFusic0RidRaZEcYepW6zFvWJ6Rlk3PMm
         ZjCLWcjNYyP8KA8Jz3nr1+FfUutOxt4S0BgKxDUpYsyl93a0Ym5//EQcBr19j8gtzcRq
         87bwq6aH3sOcwj555h+z/W0Wml8qCcIfbSteQJUOkZKHUoc8jHdINbM+7KO4sADJuOFZ
         JQ8pgaliGwX9pC4XQMTeUW+d8Y1rfjZccO2doaDmUDHo0IzCK61sfCHY4hS+DrpSgZE6
         fZCA==
X-Gm-Message-State: AE9vXwPnpK9EQh8qnv/dg+DcA+WFhNDzIUNNd8ny/tEkIzB1PshCYagLYI1yeaOUULcOVg==
X-Received: by 10.98.55.1 with SMTP id e1mr68625673pfa.58.1473127899674;
        Mon, 05 Sep 2016 19:11:39 -0700 (PDT)
Received: from ly-pc ([180.109.129.68])
        by smtp.gmail.com with ESMTPSA id a5sm36075706pfc.89.2016.09.05.19.11.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 19:11:38 -0700 (PDT)
Date:   Tue, 6 Sep 2016 10:11:38 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     keguang.zhang@gmail.com, ralf@linux-mips.org
Cc:     gnaygnil@gmail.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: Add RTC support for Loongson1C board
Message-ID: <20160906021126.GA4671@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55040
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

The patch adds RTC support for Loongson1C board, and enable
the external crystal when the RTC is first powered up.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>
---
 arch/mips/include/asm/mach-loongson32/platform.h |  1 +
 arch/mips/loongson32/common/platform.c           | 13 +++++++++++++
 arch/mips/loongson32/ls1c/Makefile               |  2 +-
 arch/mips/loongson32/ls1c/board.c                |  9 ++++-----
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 672531a..7adc313 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -30,5 +30,6 @@ void __init ls1x_clk_init(void);
 void __init ls1x_dma_set_platdata(struct plat_ls1x_dma *pdata);
 void __init ls1x_nand_set_platdata(struct plat_ls1x_nand *pdata);
 void __init ls1x_serial_set_uartclk(struct platform_device *pdev);
+void __init ls1x_rtc_set_extclk(struct platform_device *pdev);
 
 #endif /* __ASM_MACH_LOONGSON32_PLATFORM_H */
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 4d12e36..beff085 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -23,6 +23,10 @@
 #include <dma.h>
 #include <nand.h>
 
+#define LS1X_RTC_CTRL	((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + 0x40))
+#define RTC_EXTCLK_OK	(BIT(5) | BIT(8))
+#define RTC_EXTCLK_EN	BIT(8)
+
 /* 8250/16550 compatible UART */
 #define LS1X_UART(_id)						\
 	{							\
@@ -66,6 +70,15 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 		p->uartclk = clk_get_rate(clk);
 }
 
+void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
+{
+	u32 val;
+
+	val = __raw_readl(LS1X_RTC_CTRL);
+	if (!(val & RTC_EXTCLK_OK))
+		__raw_writel(val | RTC_EXTCLK_EN, LS1X_RTC_CTRL);
+}
+
 /* CPUFreq */
 static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
 	.clk_name	= "cpu_clk",
diff --git a/arch/mips/loongson32/ls1c/Makefile b/arch/mips/loongson32/ls1c/Makefile
index 891eac4..a92c6cd 100644
--- a/arch/mips/loongson32/ls1c/Makefile
+++ b/arch/mips/loongson32/ls1c/Makefile
@@ -1,5 +1,5 @@
 #
-# Makefile for loongson1B based machines.
+# Makefile for loongson1C based machines.
 #
 
 obj-y += board.o
diff --git a/arch/mips/loongson32/ls1c/board.c b/arch/mips/loongson32/ls1c/board.c
index 3d69bd6..a96bed5 100644
--- a/arch/mips/loongson32/ls1c/board.c
+++ b/arch/mips/loongson32/ls1c/board.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2016 Ling Yang <gnaygnil@gmail.com>
+ * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
  *
  * This program is free software; you can redistribute	it and/or modify it
  * under  the terms of	the GNU General	 Public License as published by the
@@ -12,17 +12,16 @@
 static struct platform_device *ls1c_platform_devices[] __initdata = {
 	&ls1x_uart_pdev,
 	&ls1x_eth0_pdev,
+	&ls1x_rtc_pdev,
 };
 
 static int __init ls1c_platform_init(void)
 {
-	int err;
-
 	ls1x_serial_set_uartclk(&ls1x_uart_pdev);
+	ls1x_rtc_set_extclk(&ls1x_rtc_pdev);
 
-	err = platform_add_devices(ls1c_platform_devices,
+	return platform_add_devices(ls1c_platform_devices,
 				   ARRAY_SIZE(ls1c_platform_devices));
-	return err;
 }
 
 arch_initcall(ls1c_platform_init);
-- 
1.9.1
