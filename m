Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2016 03:25:20 +0200 (CEST)
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35705 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992161AbcI3BZNDF5R0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2016 03:25:13 +0200
Received: by mail-pa0-f66.google.com with SMTP id t6so486316pae.2;
        Thu, 29 Sep 2016 18:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1GLzGz/jb8Oud8JOWVP+lEVD4bcuRbclC+RWqpwMqVQ=;
        b=TsXpk1icluhndEempp5OyAvMi9Dq78mN8AQGHUgR8kWbCNeo7tBjeIDZQzFuJREt5e
         5A9DJ9uxqM9MwgcYj7Dc7akQkCYcDpUTdetD3sxLHYKsbSj+lcB081hL/US9+fQe+QXd
         5bl9cxurDjCcyXBpaLNDjN0X6l14d0PTSTj49uctqy4bsniuFV8wOvKNclLrbQnXT6Sb
         hW3E0wCwQGhZrqiV3hkAe6sj5aKPyLcGLnIU+4gt2VvCmjxs/J6mEKoZ9kB7Wt+aDPfE
         LDEOKkeG8JxuyT2E28Fyd3bJQcU56JZJdEClbqx7pZfAYq/IVyVYomyjDlLfZ/YstPQ2
         53xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1GLzGz/jb8Oud8JOWVP+lEVD4bcuRbclC+RWqpwMqVQ=;
        b=gcIL7j/TGRgwW1BIt4c/AKV79B2ydNzXrjnPKBXO/bEEXAOLPK4az03WN2NJCAAgRX
         ia63vFEwgv/yR/u6cyLdZJmqI+1t7DGmwzk30uJXD8XijObOlx6yldjRLd4ngXINknOs
         aMeWY/4f+3R/zcc7ebG3PJdV6nK0z1gLjKGF9QTPqnPTAUWyajIpSaYFdooe8vK094Vz
         L0/tMUe7NDx+cSH9yey8jWTP2G2vfrlF+7VE4yGETxtsUaHMGqvSQurEgizDI/sbhnzO
         G64EIrme7Imo6sGZl5CWRrUC0Vxnt53yyNuFw0++Yb/rNwU9JvRFHgWv4woBDAz3gosx
         6NgA==
X-Gm-Message-State: AA6/9RmGeB2NcWC5PkT3AhIdJ4n7EZsqLKuNxEy0mWgsgY1U5bmfxiZ7+UslsVeFcWhLkQ==
X-Received: by 10.66.193.71 with SMTP id hm7mr7352058pac.164.1475198707039;
        Thu, 29 Sep 2016 18:25:07 -0700 (PDT)
Received: from ly-pc (ec2-52-77-214-225.ap-southeast-1.compute.amazonaws.com. [52.77.214.225])
        by smtp.gmail.com with ESMTPSA id w69sm22997467pfd.28.2016.09.29.18.25.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 18:25:05 -0700 (PDT)
Date:   Fri, 30 Sep 2016 09:24:57 +0800
From:   Yang Ling <gnaygnil@gmail.com>
To:     keguang.zhang@gmail.com, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        gnaygnil@gmail.com
Subject: [PATCH v2] MIPS: loongson32: Remove several RTC-related macros
Message-ID: <20160930012450.GA8739@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55300
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

Add regs-rtc.h to replace the macros of redundancy.

Signed-off-by: Yang Ling <gnaygnil@gmail.com>

---
V2:
  Add the header file regs-rtc.h in loongson1.h.
---
 arch/mips/include/asm/mach-loongson32/loongson1.h |  1 +
 arch/mips/include/asm/mach-loongson32/regs-rtc.h  | 23 +++++++++++++++++++++++
 arch/mips/loongson32/common/platform.c            | 22 +++++++++-------------
 3 files changed, 33 insertions(+), 13 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index 3584c40..a4cacda 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -52,6 +52,7 @@
 #include <regs-clk.h>
 #include <regs-mux.h>
 #include <regs-pwm.h>
+#include <regs-rtc.h>
 #include <regs-wdt.h>
 
 #endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-rtc.h b/arch/mips/include/asm/mach-loongson32/regs-rtc.h
new file mode 100644
index 0000000..1fe724b
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson32/regs-rtc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
+ *
+ * Loongson 1 RTC timer Register Definitions.
+ *
+ * This program is free software; you can redistribute	it and/or modify it
+ * under  the terms of	the GNU General	 Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __ASM_MACH_LOONGSON32_REGS_RTC_H
+#define __ASM_MACH_LOONGSON32_REGS_RTC_H
+
+#define LS1X_RTC_REG(x) \
+		((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + (x)))
+
+#define LS1X_RTC_CTRL	LS1X_RTC_REG(0x40)
+
+#define RTC_EXTCLK_OK	(BIT(5) | BIT(8))
+#define RTC_EXTCLK_EN	BIT(8)
+
+#endif /* __ASM_MACH_LOONGSON32_REGS_RTC_H */
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index beff085..4e28e0f 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -23,10 +23,6 @@
 #include <dma.h>
 #include <nand.h>
 
-#define LS1X_RTC_CTRL	((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + 0x40))
-#define RTC_EXTCLK_OK	(BIT(5) | BIT(8))
-#define RTC_EXTCLK_EN	BIT(8)
-
 /* 8250/16550 compatible UART */
 #define LS1X_UART(_id)						\
 	{							\
@@ -70,15 +66,6 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 		p->uartclk = clk_get_rate(clk);
 }
 
-void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
-{
-	u32 val;
-
-	val = __raw_readl(LS1X_RTC_CTRL);
-	if (!(val & RTC_EXTCLK_OK))
-		__raw_writel(val | RTC_EXTCLK_EN, LS1X_RTC_CTRL);
-}
-
 /* CPUFreq */
 static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
 	.clk_name	= "cpu_clk",
@@ -357,6 +344,15 @@ struct platform_device ls1x_ehci_pdev = {
 };
 
 /* Real Time Clock */
+void __init ls1x_rtc_set_extclk(struct platform_device *pdev)
+{
+	u32 val;
+
+	val = __raw_readl(LS1X_RTC_CTRL);
+	if (!(val & RTC_EXTCLK_OK))
+		__raw_writel(val | RTC_EXTCLK_EN, LS1X_RTC_CTRL);
+}
+
 struct platform_device ls1x_rtc_pdev = {
 	.name		= "ls1x-rtc",
 	.id		= -1,
-- 
1.9.1
